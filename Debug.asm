include_macros	equ	1
include_deb_mac	equ	1
include_flags	equ	1
include_error_codes equ	1
	include include.asm



start32data

ifdef debug_42

show_debug_vars	dd	1
else
show_debug_vars	dd	0
endif

no_chars	equ	11

c_text_no	dd	0				;current speech number

status_buffer	db	game_screen_width*5 dup (?)

	align 4

status_ch_set	dd	0

end32data


do_stat	macro var,pos

	mov	eax,var
	mov	ebx,pos
	call	status_int
endm


start32code


debug_loop	proc

	test	[show_debug_vars],-1
	je	dl_ret

	do_stat [game_cycle],0
ifdef with_replay
	do_stat [db_next_cycle],7
endif
	do_stat [screen],14
	do_stat [c_text_no],21

	do_stat [voc_progress],28

ifdef debug_42
	do_stat [tseq_frames],40
	;do_stat [replay_data_ptr],47
	;do_stat [door_77_78_flag],54
endif

	push	es
	mov	es,[screen_segment]
	mov	esi,offset status_buffer
	mov	edi,game_screen_width * game_screen_height
	mov	ecx,game_screen_width*5
	rep	movsb
	pop	es

dl_ret:	ret

debug_loop	endp




status_char	proc

;	print char al at position ebx

	test	[status_ch_set],-1
	jne	got_set
	push	eax
	push	ebx
	mov	eax,60152
	clear	edx
	call	load_file
	mov	[status_ch_set],eax
	pop	ebx
	pop	eax

got_set:	cmp	al,' '
	je	space

	sub	al,'0'
	jmp	do_ch

space:	mov	al,10
	jmp	do_ch

do_ch:	movzx	eax,al
	imul	eax,3
	mov	esi,eax
	add	esi,[status_ch_set]
	mov	edi,ebx
	imul	edi,4
	add	edi,offset status_buffer

	mov	edx,5
	clear	eax
line_loop:	mov	ecx,3
	rep	movsb
	stosb
	add	esi,no_chars*3 - 3
	add	edi,game_screen_width-4
	floop	edx,line_loop

	ret


status_char	endp




status_int	proc

;	print eax at ebx

	cmp	eax,1000000
	jc	not_max
	mov	eax,999999

not_max:	clear	ebp
	jife	eax,zero
	call	do_char
	jmp	all_done

zero:	mov	al,'0'
	call	status_char
	inc	ebx
	inc	ebp

all_done:	;pad out to 5 wide

	mov	al,' '
	call	status_char
	inc	ebp
	cmp	ebp,5
	jc	all_done
	jmp	si_ret

do_char:	mov	ecx,10
	clear	edx
	idiv	ecx
	push	edx
	jife	eax,done
	call	do_char
done:	pop	eax
	add	al,'0'
	call	status_char
	inc	ebx
	inc	ebp
si_ret:	ret

status_int	endp


ifdef debug_42

proc_start	_fetch_item_section__Ni

fi_sect	equ	8

;	fetch the address of a section item list

	mov	eax,fi_sect[ebp]
	shl	eax,2
	mov	eax,[eax+offset item_list+section_0_item*4]

proc_end	_fetch_item_section__Ni,4






flip_grid	proc

;	Display a ton of stuff depending on the grids

	bt	[_debug_flag],df_grid
	jnc	no_grid

	mov	ebx,[screen]				;get current screen
	mov	bl,bpt [offset grid_convert_table+ebx]
	cherror bl,nc,tot_no_grids,em_internal_error

	imul	ebx,ebx,grid_size
	add	ebx,[game_grids]				;pointer to grid start
	mov	edx,31					;start bit

	mov	esi,[game_grid]
	mov	edi,[backscreen]
	add	edi,(GRID_H-1)*full_screen_width

	mov	ch,GRID_Y				;screen height

y_loop:	push	edi
	mov	cl,GRID_X				;screen width

x_loop:	push	ecx

	;first check two walk grid bits

	bt	[ebx],edx
	jnc	no_grid1

	mov	eax,0ffffffffh
	stosd
	mov	eax,0ffffffh
	stosd
	sub	edi,8
	or	bpt[esi],81h

no_grid1:	add	edi,8
	dec	edx
	bt	[ebx],edx
	jnc	no_grid2

	mov	eax,0ffffffffh
	stosd
	mov	eax,0ffffffh
	stosd
	sub	edi,8
	or	bpt[esi],81h

no_grid2:	add	edi,8
	dec	edx
	jns	no_new_byte

	add	ebx,4
	mov	edx,31

no_new_byte:	inc	esi

	pop	ecx

	floop	cl,x_loop

	pop	edi
	add	edi,GRID_H*full_screen_width

	floop	ch,y_loop


;--------------------------------------------------------------------------------------------------

no_grid:	ret

flip_grid	endp




proc_start	_mgetch__Nv

waitk:	call	fetch_key
	je	waitk

proc_end	_mgetch__Nv


endif	;debug_42


end32code


	end
