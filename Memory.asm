include_macros	equ	1
include_deb_mac	equ	1
include_error_codes equ	1

	include include.asm





ifdef mem_check			;check memory allocated and dealocated

;WARNING! THIS DISABLES FREE
;watch_address	equ	0147f8ch

abs_max_memory	equ	(2000*1000)		;up in 100000's

memory_item	struc

address	dd	?
mem_size	dd	?
call_add	dd	?

memory_item	ends

memory_block_size	equ	40

start32data
	align 4


memory_list	dd	?			;pointer to allocation list
memory_entries	dd	?			;no of entries
memory_block	dd	?			;space allocated for entries
total_memory	dd	?			;32 bit memory currently allocated
dos_mem_allocated	dd	0			;16 bit memory allocated
max_memory	dd	0			;largest amount of memory allocated



end32data

endif


start32code
	extrn	_malloc:near
	extrn	_realloc:near
	extrn	_free:near
ifdef mem_check
	extrn	free_fixed_items:near
	extrn	free_text_items:near
endif


initialise_memory	proc

ifdef mem_check

	push	memory_block_size*SIZE memory_item		;set up the memory list
	call	_malloc
	lea	esp,4[esp]
	mov	[memory_list],eax
	mov	[memory_entries],0
	mov	[memory_block],memory_block_size
	mov	[total_memory],0
endif
	ret

initialise_memory	endp




my_malloc	proc

;	Allocate eax bytes

	;printf "malloc %d bytes",eax

ifdef debug_42
	jifne	eax,not_0
	call_address
	program_error em_internal_error
not_0:
endif

ifdef mem_check
	mov	ecx,[memory_entries]			;check for room
	cmp	ecx,[memory_block]
	jc	room

	push	eax
	mov	eax,[memory_block]			;allocate more memory
	add	eax,memory_block_size
	mov	[memory_block],eax
	mov	ebx,SIZE memory_item
	mul	ebx
	push	eax
	push	[memory_list]
	call	_realloc
	lea	esp,8[esp]
	mov	[memory_list],eax
	pop	eax
	mov	ecx,[memory_entries]

room:	;Find a free place (ecx=memory_entries)

	mov	ebx,[memory_list]
	jcxz	first_one
find_place:	test	(memory_item ptr[ebx]).address,-1
	je	found_place
	add	ebx,SIZE memory_item
	floop	find_place

first_one:	inc	[memory_entries]

found_place:	mov	(memory_item ptr[ebx]).mem_size,eax
	add	[total_memory],eax

ifdef mem_check	;register max memory we use
	mov	edx,[total_memory]
	cmp	[max_memory],edx
	jnc	max_ok
	mov	[max_memory],edx
max_ok:
endif

;	Check if we are allocating too much memory

ifdef debug_42
	cmp	[total_memory],abs_max_memory
	jc	no_test
	printf	"abs_max_memory was %d",abs_max_memory
	printf "We want %d",[total_memory]
no_test:
endif

	push	ebx
	push	eax
	call	_malloc
	jife	eax,no_memory
	lea	esp,4[esp]
	pop	ebx
	mov	(memory_item ptr[ebx]).address,eax
	pop	ecx
	push	ecx
	mov	(memory_item ptr[ebx]).call_add,ecx


ifdef watch_address
	cmp	eax,watch_address
	jne	not_watch
	call	Aaaaaaaa
not_watch:
endif

else	;ifdef mem_check

	push	eax
	call	_malloc
	jife	eax,no_memory
	lea	esp,4[esp]
endif

	ret

no_memory:
ifdef mem_check
	printf "total memory %d",[total_memory]
endif
	program_error em_memory_error

my_malloc	endp




my_free	proc

;	Free memory location eax

	cherror eax,e,0,em_internal_error

ifdef mem_check
	mov	esi,[memory_list]
	mov	ecx,[memory_entries]
look_loop:	cmp	(memory_item ptr[esi]).address,eax
	je	found_mem
	add	esi,SIZE memory_item
	floop	look_loop

	pop	ebx
	printf "address %x not allocated (call %x)",eax,ebx
	program_error em_internal_error

found_mem:	push	eax				;save for free
	mov	eax,(memory_item ptr[esi]).mem_size
	sub	[total_memory],eax
	mov	(memory_item ptr[esi]).address,0
ifndef watch_address
	call	_free
endif

else	;ifdef mem_check

	push	eax
	call	_free
endif

	lea	esp,4[esp]
	ret

my_free	endp



ifdef mem_check
end32code
start32data

free_list	dd	backscreen
	dd	game_grid
	dd	mouse_text_data
	dd	saved_data
	dd	game_grids
	dd	mice_data
	dd	route_grid
	dd	main_character_set
	dd	link_character_set
	dd	control_char_set
	dd	object_mouse_data
	dd	status_ch_set
	dd	work_palette
	dd	c2_save_game_texts
	dd	spp_control_panel
	dd	spp_button
	dd	spp_dn_btn
	dd	spp_save_panel
	dd	spp_yes_no
	dd	spp_slide
	dd	spp_slode
	dd	c2_palette_data
	dd	dinner_table_area
	dd	pre_after_table_area
ifdef with_replay
	dd	replay_data
endif
	dd	-1
end32data
start32code


check_mem	proc

;	First deallocate what we can

	printf "checking memory free"

	mov	esi,offset free_list

free_loop:	lodsd
	cmp	eax,-1
	je	free_done
	push	esi
	mov	eax,[eax]
	jife	eax,noppy
	call	my_free
noppy:	pop	esi
	jmp	free_loop

free_done:	mov	esi,offset loaded_file_list

free_lflop:	lodsd
	jife	eax,flop_done
	and	eax,2047
	push	esi
	mov	eax,[offset item_list+eax*4]	;get address and clear entry
	call	my_free
	pop	esi
	jmp	free_lflop

flop_done:	mov	esi,offset module_list
	mov	ecx,16
mod_check:	lodsd
	jife	eax,no_mod
	push	esi
	push	ecx
	call	my_free
	pop	ecx
	pop	esi
no_mod:	loop	mod_check

	call	free_fixed_items
	call	free_text_items

;	Now check for what we couldn't

	mov	esi,[memory_list]
	mov	ecx,[memory_entries]
	jife	ecx,no_mentries
check_loop:	mov	eax,(memory_item ptr[esi]).address
	jife	eax,no_mem
	mov	ebx,(memory_item ptr[esi]).call_add
	printf "%xh not deallocated (call %x)",eax,ebx
no_mem:	add	esi,SIZE memory_item
	loop	check_loop
no_mentries:	printf "Total_mem (left) %d",[total_memory]

	mov	eax,[max_memory]
	mov	ebx,[dos_mem_allocated]
	add	ebx,eax
	printf "Max memory %d (%d with dos mem)",eax,ebx

	ret

check_mem	endp

ifdef watch_address
Aaaaaaaa	proc

	ret

Aaaaaaaa	endp
endif

endif

end32code

	end
