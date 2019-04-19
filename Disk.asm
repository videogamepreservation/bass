include_flags	equ	1
include_struc	equ	1
include_deb_mac	equ	1
include_macros	equ	1
include_error_codes equ	1
include_language_codes equ 1
	include include.asm


;	The data for game 2 will be held in one very large data file.
;	A small file contains the data required for loading the data


no_of_files_hd	equ	1600	;1500
no_of_files_cd	equ	5200

max_files_in_list	equ	60				;max no of files in chip list or fast list


start32data


data_file_name	db	"sky.dsk",0
dinner_file_name	db	"sky.dnr",0
restart_name	db	"sky.rst",0
config_name	db	"sky.cfg",0

save_game_text_fileh db	"sky     .sav",0
save_game_nameh	db	"sky     .000",0

				;   cfg		actual
lang_conv	db	0		;0 English		English
	db	usa_code		;3 Us		American
	db	french_code	;2 French		French
	db	german_code	;1 German		German
	db	iti_code		;5 Italian		Italian
	db	spa_code		;xx6 P'guese		P'guese
	db	por_code		;xx7 Spanish		Swedish
	db	swe_code		;4 Swedish		Swedish

	align 4

restart_name_p	dd	0				;pointer to name of restart file
save_game_text_file dd	0
save_game_name	dd	0

config_file_present dd	0

data_disk_handle	dd	?				;handle for data disk

;dinner_table	dd	(no_of_files*2) dup (0)
dinner_table_area	dd	?				;where to put the dinner table
dinner_table_size	dd	?				;no of files we are allowed

file_flags	dd	?				;flags from dinner table
file_offset	dd	?				;offset into dsk file
file_size	dd	?				;size of file

fixed_dest	dd	?				;set to 0 if we don't have a fixed place
file_dest	dd	?				;where to load the data
comp_dest	dd	?				;where to decompress it to

decomp_size	dd	?				;uncompressed size

ifdef debug_42
comp_file	dd	?
endif

build_list	dw	max_files_in_list dup (0)		;list of loaded files


end32data


start32save_data

;	fast and chip list not allocated so it can be saved easily

loaded_file_list	dd	max_files_in_list dup (0)		;list of loaded files

end32save_data


start32code
	extrn	my_malloc:near
	extrn	my_free:near
	extrn	_UnpackM1:near


initialise_disk	proc

;	Load in the dinner table

	mov	eax,no_of_files_hd*8		;allocate space for dinner table
	mov	ebx,no_of_files_hd
	test	[_cd_version],-1			;cd version has far more
	je	not_id_cd
	mov	eax,no_of_files_cd*8		;allocate space for dinner table
	mov	ebx,no_of_files_cd
not_id_cd:	mov	[dinner_table_size],ebx
	call	my_malloc
	mov	[dinner_table_area],eax

	open_file dinner_file_name,em_no_dnr_file
	mov	[restart_name_p],offset restart_name
	mov	[save_game_text_file],offset save_game_text_fileh
	mov	[save_game_name],offset save_game_nameh

	mov	edx,offset data_disk_handle	;check no of files is correct
	mov	ecx,4
	mov	ebx,eax
	mov	ah,3fh
	disk_int
	jc	dnr_f_error

	mov	eax,[data_disk_handle]		;no of files in dnr
	cmp	[dinner_table_size],eax
	jnc	disk_ok

disk_rd_error2::	program_error em_disk_rd_error

dnr_f_error:	program_error em_dnr_file

disk_ok:	;Load in the dinner table

	mov	[dinner_table_size],eax

	mov	edx,[dinner_table_area]
	shl	[data_disk_handle],3			;8 bytes per entry
	mov	ecx,[data_disk_handle]
	mov	ah,3fh
	disk_int
	jc	disk_rd_error2
	cmp	eax,[data_disk_handle]
	jne	disk_rd_error2
	close_file

;	Open up the data disk

	open_file data_file_name,em_no_dsk_file

	mov	[data_disk_handle],eax

	ret

initialise_disk	endp




load_fixed_items	proc

;	Load in one or two files

ifndef s1_demo
	load_fixed	36
endif
	load_fixed	49
	load_fixed	50
	load_fixed	73
	load_fixed	262
ifndef s1_demo
	load_fixed	263
	load_fixed	264
	load_fixed	265
	load_fixed	266
	load_fixed	267
	load_fixed	269
	load_fixed	271
	load_fixed	272
endif

	ret

load_fixed_items	endp

ifdef mem_check

free_fixed_items	proc

	free_fixed_item	36
	free_fixed_item	49
	free_fixed_item	50
	free_fixed_item	73
	free_fixed_item	262
	free_fixed_item	263
	free_fixed_item	264
	free_fixed_item	265
	free_fixed_item	266
	free_fixed_item	267
	free_fixed_item	269
	free_fixed_item	271
	free_fixed_item	272

	ret

free_fixed_items	endp

endif

;--------------------------------------------------------------------------------------------------

load_file	proc

;	Load in file eax to address edx.
;	If edx = 0 then allocate memory for this file

;	First find the file

ifdef file_order_chk
	extrn	_this_file_loaded__Ni:near
	push_all
	push	eax
	call	_this_file_loaded__Ni
	pop_all
endif

ifdef debug_42
	;call_address
	mov	[comp_file],eax
	show_files "load file %d,%d (%d)"
	test	[_cd_version],-1
	je	njnj
	border 3fh
njnj:
endif

ifdef with_screen_saver
	mov	[sssss_count],0			;loading files is a sign of activity
endif
	call	get_file_info

	mov	eax,[esi+5]			;get size + flags
	mov	[file_flags],eax
	and	eax,03fffffh
	mov	[file_size],eax
	;printf "size %d",eax

ifdef debug_42
	jifne	eax,f_not_miss
	ret
f_not_miss:
endif

	mov	ecx,[esi+2]			;get file offset
	and	ecx,0ffffffh

	;printf "offset 1 %d (%x)",ecx,ecx

	btr	ecx,23
	jnc	no_xtra

	shl	ecx,4				;position goes over 16m boundary

no_xtra:	mov	[file_offset],ecx
	mov	[fixed_dest],edx			;save dest address or 0 if we need some
	mov	[file_dest],edx
	mov	[comp_dest],edx

;	Do we need to allocate memory

	or	edx,edx
	jne	no_allocate

	call	my_malloc
	mov	[file_dest],eax

no_allocate:	;Position the file pointer

	mov	ax,4200h
	mov	ebx,[data_disk_handle]
	mov	ecx,[file_offset]
	;printf "offset 2 %d (%x)",ecx,ecx

ifdef file_order_chk
	extrn	_position_file__Ni:near
	push_all
	push	ecx
	call	_position_file__Ni
	pop_all
endif

	mov	edx,ecx
	shr	ecx,16
	and	edx,0ffffh
	bts	[system_flags],sf_test_disk
	disk_int
	jc	disk_rd_error2
	btr	[system_flags],sf_test_disk
	shl	edx,16				;check we got there
	mov	dx,ax
	cmp	edx,[file_offset]
	jne	disk_rd_error2

;	Now read in the data

	mov	ah,3fh
	mov	ebx,[data_disk_handle]
	mov	ecx,[file_size]
	;printf "size %d",ecx

ifdef file_order_chk
	extrn	_load_file_data__Ni:near
	push_all
	push	ecx
	call	_load_file_data__Ni
	pop_all
endif
	mov	edx,[file_dest]
	bts	[system_flags],sf_test_disk
	disk_int
	btr	[system_flags],sf_test_disk
	cmp	eax,[file_size]
	jne	disk_rd_error2

	mov	eax,[file_dest]
	bt	[file_flags],23			;skip decomp check?
	jc	not_compressed

;--------------------------------------------------------------------------------------------------

;	check for old robby boy

	bt	(s ptr[eax]).flag,7		;bit 7 set for robs compression
	jnc	not_robbo

;	decompress northern style

	mov	esi,eax

	movzx	eax,(s ptr[esi]).flag		;get uncompressed size
	clear	al
	shl	eax,8
	mov	ax,(s ptr[esi]).s_tot_size

	mov	[decomp_size],eax			;save total size

;	If we didn't have a place for this file make one

	test	[fixed_dest],-1
	jne	got_mem

	call	my_malloc
	mov	[comp_dest],eax

got_mem:	mov	esi,[file_dest]
	mov	edi,[comp_dest]

	bt	[file_flags],22			;do we include the header
	jc	not_ihead
	mov	ecx,SIZE s
	rep	movsb
	jmp	dun_hed

not_ihead:	add	esi,SIZE s

dun_hed:	push	0
	push	edi
	push	esi
	call	_UnpackM1
	lea	esp,12[esp]

	push	ds				;restore es
	pop	es

;	If eax = 0 then the file was not compressed, we already have it

	jifne	eax,was_compressed

	test	[fixed_dest],-1			;don't free compressed data if dest is fixed
	jne	fxd_free

	mov	eax,[comp_dest]
	call	my_free

fxd_free:	mov	eax,[file_dest]			;wasn't decompressed so wasn't moved
	jmp	not_compressed

was_compressed:	;In theory data are now decompressed

	bt	[file_flags],22			;did we include the header
	jc	not_inc_head
	add	eax,SIZE s

not_inc_head:

ifdef debug_42
	cmp	eax,[decomp_size]			;check size
	je	size_ok

	printf "********************************"
	show_files "decomp file %d,%d (%d)",[comp_file]
	printf "decomp size %d",eax
	printf "should be %d",[decomp_size]
	printf "file flags %x",[file_flags]
	printf "file size %d",[file_size]
	printf "file offset %d",[file_offset]
	printf "********************************"
size_ok:
endif
	test	[fixed_dest],-1			;do we need to deallocate file memory
	jne	no_ffree

	mov	eax,[file_dest]
	call	my_free

no_ffree:	mov	eax,[comp_dest]

	jmp	not_compressed

not_robbo:

not_compressed:
ifdef debug_42
	test	[_cd_version],-1
	je	popo
	border 0
popo:
endif

	bt	[system_flags],sf_mouse_stopped
	jnc	no_mouse_fix

	push	eax
	call	restore_mouse_data
	call	draw_new_mouse
	pop	eax

	btr	[system_flags],sf_mouse_stopped

no_mouse_fix:	;printf "loaded to %x",eax
	ret

load_file	endp




fn_cache_chip	proc

;	chip list always loaded after fast list

	fetch_compact				;get address of list

	mov	edi,offset build_list		;find end of build list
	clear	eax
	mov	ecx,-1
	repne	scasw
	lea	edi,[edi-2]

build_loop:	lodsw
	stosw
	jifne	ax,build_loop

	jmp	fn_cache_files

fn_cache_chip	endp

fn_cache_fast	proc

;	fast list always loaded first

ifdef file_order_chk
	extrn	_lseek_allowed__Ni:near		;disk jump allowed on room change

	push_all
	push	[screen]
	call	_lseek_allowed__Ni
	pop_all
endif

;	if list = 0 then load no files

	jife	eax,no_files

	cherror [build_list],ne,0,em_internal_error

	fetch_compact

	jife	esi,no_files

	mov	edi,offset build_list
	clear	eax

build_loop:	lodsw
	stosw
	jifne	ax,build_loop

no_files:	mov	al,1
	ret

fn_cache_fast	endp

fn_cache_files	proc

;	Cache in sprites.
;	Use build list

	call	trash_all_fx			;get rid of any fx that are going on

	mov	esi,offset build_list
	mov	edi,offset loaded_file_list

;	edi points to list of files already loaded
;	esi points to files we want to load

;	First check what files must be kept.

	push	edi

	mov	ebx,edi				;use this to update list

one_checked:	mov	edx,[ebx]			;get a loaded file
	jife	edx,all_checked
	add	ebx,4

	push	esi

check_dump_loop:	and	wpt[esi],7fffh			;Tony has a dodgy bit 15, trash it and use result
	je	dump_it				;to check for end of list

	cmp	dx,[esi]				;check file
	je	keep_it

	add	esi,2
	jmp	check_dump_loop

keep_it:	mov	[edi],edx			;keep this one
	add	edi,4
	pop	esi
	jmp	one_checked

dump_it:	push	edi
	push	ebx
	clear	eax
	and	edx,2047				;strip off disk sets
	xchg	eax,[offset item_list+edx*4]	;get address and clear entry
	call	my_free
	pop	ebx
	pop	edi

	pop	esi
	jmp	one_checked

all_checked:	;esi still points to files we want
	;edi points to end of list
	mov	dpt[edi],0

	pop	edi				;now points to start of loaded files

cache_loop:	movzx	eax,wpt[esi]			;get a file we want
	and	ax,7fffh				;strip bit and check for end
	je	cached
	lea	esi,2[esi]

	mov	bx,ax				;check for amiga dummy file
	and	bx,7ffh
	cmp	bx,7ffh				;7ff is dummy amiga only file
	je	cache_loop

	push	edi				;see if we have this file already

check_load_loop:	test	dpt[edi],-1			;end of list?
	je	load_it

	cmp	eax,[edi]
	je	skip_it

	lea	edi,4[edi]
	jmp	check_load_loop

load_it:	;we need this file

	stosd					;put number into list
	mov	dpt[edi],0

ifdef file_order_chk	;flag cached files as we already check for repeats

	extrn	_next_file_repeatable__Nv:near
	push_all
	call	_next_file_repeatable__Nv
	pop_all
endif

	push	esi
	push	eax				;save number for set
	clear	edx
	call	load_file			;get the file
	pop	ebx				;get no for set
	and	ebx,2047				;strip disk number

	mov	[offset item_list+ebx*4],eax	;and put location in

	pop	esi				;go back for more
skip_it:	pop	edi
	jmp	cache_loop

cached:	mov	[build_list],0
	mov	al,1
	ret

fn_cache_files	endp




fn_flush_buffers	proc

;	dump all loaded sprites

	mov	esi,offset loaded_file_list

;	esi points to list to dump

	push	esi

one_checked:	lodsd					;get a loaded file
	jife	eax,all_checked

	push	esi

	clear	edx
	and	eax,2047				;strip off disk sets
	xchg	edx,[offset item_list+eax*4]	;get address and clear entry
	mov	eax,edx
	call	my_free

	pop	esi
	jmp	one_checked

all_checked:	pop	esi				;empty list
	mov	dpt[esi],0

	mov	al,1
	ret

	ret

fn_flush_buffers	endp




proc_start	_load_config__Nv

;	Try and open the config file

;	mov	ax,3d00h
;	mov	edx,offset config_name
;	disk_int
;	jc	no_config

	push	offset config_name
	call	_open_for_read__Npc
	cmp	eax,-1
	je	no_config

	mov	[config_file_present],1

;	Load in the config bytes

	mov	edx,offset config_name			;dont need this again
	mov	ecx,5
	mov	ebx,eax
	mov	ah,3fh
	disk_int

	movzx	eax,[config_name]				;get language byte

	mov	al,byte ptr [offset lang_conv + eax]

ifdef italian_set
	mov	al,iti_code
endif
ifdef spanish_set
	mov	al,spanish_code
endif

	mov	byte ptr [_language],al

	jife	al,no_config				;on non english versions have text as well as speech
	cmp	al,usa_code
	je	no_config

	printf "setting the options!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	bts	[system_flags],sf_allow_text
	bts	[system_flags],sf_allow_speech

no_config:

proc_end	_load_config__Nv




fn_flush_chip	proc

;	This should be done automatically

	mov	al,1
	ret

fn_flush_chip	endp





fn_mini_load	proc

;	Load in a 'temporary' file
;	load it into the chip list

;	eax is file number

	mov	esi,offset loaded_file_list		;check file is not already loaded
	cherror dpt[esi],e,0,em_internal_error		;always used when other grafix present
look_loop:	cmp	eax,[esi]
	je	loaded
	lea	esi,4[esi]
	test	dpt [esi],-1
	jne	look_loop

;	need to load the file

	mov	[esi],eax			;tag file on to end of list
	mov	dpt 4[esi],0

	push	eax
	clear	edx
	call	load_file
	pop	ebx				;make pointer to entry in item list
	and	ebx,2047
	mov	[offset item_list+ebx*4],eax

loaded:	mov	al,1
	ret


fn_mini_load	endp




get_file_info	proc

;	Point to info on file eax

	mov	esi,[dinner_table_area]
	mov	ecx,[dinner_table_size]
find_loop:	cmp	ax,[esi]
	je	found_file
	add	esi,8
	floop	find_loop

;	if file is speech file then return eax=0 if file not found

	bt	[system_flags],sf_speech_file
	jnc	not_speech

	btr	[system_flags],sf_test_disk
	pop	eax			;trash return address
	clear	eax
	ret				;return with eax = 0

not_speech:	show_files "mutating %d,%d (%d)"
	cherror eax,e,75,em_internal_error
ifdef debug_42
	pop	eax			;get to original call address
	call_address
	push	eax
endif
	mov	eax,75
	jmp	get_file_info

found_file:	ret

get_file_info	endp




get_file_size	proc

	call	get_file_info

	mov	eax,[esi+5]			;get size + flags
	and	eax,03fffffh

	ret

get_file_size	endp




restore_file_lists	proc

	mov	esi,offset loaded_file_list

;	Load list of files starting at esi

load_loop:	lodsd
	jife	eax,load_done

	push	esi
	push	eax
	clear	edx
	call	load_file
	pop	edx
	and	edx,2047
	mov	[offset item_list+edx*4],eax
	pop	esi
	jmp	load_loop

load_done:	ret

restore_file_lists	endp




proc_start	_get_current_disk_drive__Nv

	mov	ah,19h
	int	21h
	and	eax,0ffh

proc_end	_get_current_disk_drive__Nv




proc_start	_get_free_disk_space__Ni

drive	equ	8

	mov	ah,36h					;get free disk space
	mov	edx,drive[ebp]
	inc	edx
	int	21h

	cmp	ax,-1					;no drive?
	je	disk_0

	movzx	eax,ax
	movzx	ebx,bx
	movzx	ecx,cx

	imul	eax,ebx
	imul	eax,ecx

	jmp	got_sp

disk_0:	clear	eax
got_sp:


proc_end	_get_free_disk_space__Ni,4


end32code

	end
