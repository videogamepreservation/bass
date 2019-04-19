include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_flags	equ	1
include_error_codes equ	1
	include include.asm

mice_file	equ	60300



start32data
	align 4

mouse_data_start	dd	?

;	Mouse status variables

amouse_x	dd	?				;actual mouse coordinates
amouse_y	dd	?
mouse_b	dd	?				;used to check for repeat presses

bmouse_b	dd	?				;mouse button latch

mouse_offset_x	dd	0				;for offsetting the mouse
mouse_offset_y	dd	0				;+ve offsets only, mouse moves left or up

ds_val	dw	?
	dw	?

mouse_stack	db	1000 dup (?)
mouse_stack_end	dd	?

;	Mouse data variables

mouse_type2	dd	?				;number of current mouse
mouse_data2	dd	0				;pointer to mouse data (from mouse_type)

mouse_width	dd	6				;mouse width and height
mouse_height	dd	6

mouse_position	dd	?				;current screen address of mouse
mask_width	dd	6				;width on screen
mask_height	dd	6				;height on screen

saved_data	dd	0				;place for saved data

mouse_flag	dd	0				;bit 0 set when in handler
						;bit 1 set when screen data has been saved
						;bit 2 set when we don't want to show mouse

mice_data	dd	0				;address of mouse sprites
object_mouse_data	dd	0				;address of object mouse sprites

screen_segment	dw	?				;descriptor for screen (0a000:0)

ifdef with_replay
_replay_flag	dd	0
endif

mouse_data_end	dd	?

end32data


start32code
	public	restore_mouse_data


init_mouse	proc

	push	es				;protect es from memlock's

	clear	eax
	int	33h

	cmp	ax,-1
	je	found_mouse
ifdef ignore_mouse
	jmp	found_mouse
endif
	program_error em_no_mouse

found_mouse:	mov	[ds_val],ds				;save default ds

	mov	ax,252bh				;lock the memory used by the mouse handler
	mov	bx,501h
	mov	ecx,offset mouse_handler
	mov	edx,offset end_handler
	sub	edx,ecx
	push	cs
	pop	es
	int	21h
	jc	memlock_error


	mov	ax,252bh				;lock the data too
	mov	bx,501h
	mov	ecx,offset mouse_data_start
	mov	edx,offset mouse_data_end
	sub	edx,ecx
	push	ds
	pop	es
	int	21h
	jc	memlock_error


;	Load the mouse sprite file and lock it

	mov	eax,mice_file			;load it
	clear	edx
	call	load_file
	mov	[mice_data],eax
	mov	[mouse_data2],eax

	push	eax				;lock the memory
	mov	eax,mice_file
	call	get_file_size
	mov	edx,eax
	pop	ecx
	mov	bx,501h
	mov	ax,252bh
	int	21h
	jc	memlock_error

;	Allocate data for the text mouse and lock it

	mov	eax,[mice_data]
	movzx	ebx,(s ptr[eax]).s_width
	movzx	eax,(s ptr[eax]).s_height
	imul	eax,ebx
	add	eax,SIZE s
	push	eax

	call	my_malloc
	mov	[saved_data],eax

	pop	edx
	mov	ecx,eax
	mov	bx,501h
	mov	ax,252bh
	int	21h
	jc	memlock_error


;	Load in the object mouse file

	mov	eax,mice_file+1
	clear	edx
	call	load_file
	mov	[object_mouse_data],eax

	mov	[mouse_width],1
	mov	[mouse_height],1

;	Holy shit, what the hell is all this rubbish!


	mov	ax,2509h				;Get system segments and selectors
	int	21h				;real mode cs in bx
	shl	ebx,16				;move cs: to top of ebx
	mov	bx,offset __X386_CODESEG_16:mouse_init
	push	ebx
	mov	ax,250dh				;Get real mode call back address
	int	21h
	mov	edi,eax				;Real mode call back address
	pop	ebx				;real mode mouse routine
	;mov	edx,0ffffh			;mouse handler mask
	clear	ecx				;no parameters
	mov	ax,250eh				;call real mode mouse initialiser
	int	21h

	bts	[system_flags],sf_mouse

;	Set up some things for the mouse

;	set horixontal range 640

	mov	cx,0
	mov	dx,639
	mouse_int 7

;	set vertical range

	mov	cx,0
	mov	dx,198
	mouse_int 8

;	Set up correct mouse coordinates

	mouse_int 3

	shr	cx,1
	mov	wpt [amouse_x],cx
	mov	wpt [amouse_y],dx

no_mouse:	pop	es

	ret

memlock_error::	program_error em_internal_error

init_mouse	endp




replace_mouse_cursors proc

;	replace the mouse cursors from file eax

	mov	edx,[object_mouse_data]
	call	load_file

	ret

replace_mouse_cursors endp


;--------------------------------------------------------------------------------------------------

mouse_handler	proc far

	pushf
	push	eax
	push	es

	mov	ax,ss
	mov	es,ax
	mov	eax,esp

	mov	ss,cs:[ds_val]				;use cs to load ss
	mov	esp,offset mouse_stack_end

	push_all
	cld

	mov	ds,cs:[ds_val]				;use cs to load ds
ifdef with_screen_saver
	mov	[sssss_count],0
endif

;	Check we have not interrupted the mouse handler
	bts	[mouse_flag],mf_in_int
	jc	mh_ret

;	Store the current mouse position

	shr	ecx,1					;x coords are 0-639
	and	ecx,7ffh
	and	edx,7ffh

	cmp	ecx,full_screen_width-1			;-1 so some of mouse is always on screen
	jc	xok					;-1 also avoid problems with moving too far
	mov	ecx,full_screen_width-2			;   right on menu right arrow
xok:	mov	[amouse_x],ecx


	cmp	edx,full_screen_height-8
	jc	yok
	mov	edx,full_screen_height-1-8
yok:	mov	[amouse_y],edx

;	Two buttons, predictably the opposite way round to the amiga

	and	ebx,3					;strip any rubbish
	je	no_butt

	sar	ebx,1					;swap buttons
	jnc	no_butt
	bts	ebx,1

no_butt:	;If mouse button has changed check for new mouse press

	cmp	ebx,[mouse_b]
	je	button_waiting

	mov	[mouse_b],ebx

;	If no mouse button waiting for processing then check for a mouse button

	test	[bmouse_b],0fh
	jne	button_waiting
	test	ebx,0fh
	je	button_waiting
	mov	[bmouse_b],ebx

button_waiting:	;if we are in the middle of a flip then don't draw the mouse

	bt	[mouse_flag],mf_no_update
	jc	no_draw

	bts	[system_flags],sf_mouse_stopped
	bt	[system_flags],sf_test_disk
	;jc	no_draw
	btr	[system_flags],sf_mouse_stopped

	call	restore_mouse_data
	call	draw_new_mouse

no_draw:	btr	[mouse_flag],mf_in_int		;we are out of the handler

mh_ret:	pop_all

	mov	esp,eax
	mov	ax,es
	mov	ss,ax

	pop	es
	pop	eax
	popf

	retf


;--------------------------------------------------------------------------------------------------

calculate_mouse_values::

;	Calculate some mouse values

;	Include any offset

	mov	eax,[amouse_y]
	sub	eax,[mouse_offset_y]
	jnc	not_neg_y
	clear	eax
not_neg_y:	push	eax					;save mouse_y including offset
	imul	eax,eax,full_screen_width
	mov	ebx,[amouse_x]

	sub	ebx,[mouse_offset_x]
	jnc	not_neg_x
	clear	ebx
not_neg_x:	add	eax,ebx					;ebx is mouse_x including offset
	mov	[mouse_position],eax
	cherror eax,nc,64000,em_internal_error

	mov	eax,[mouse_width]
	mov	[mask_width],eax
	add	eax,ebx	;[amouse_x]
	sub	eax,full_screen_width
	jc	no_mask_x
	sub	[mask_width],eax

no_mask_x:	mov	eax,[mouse_height]
	mov	[mask_height],eax
	pop	ebx					;restore mouse_y including offset
	add	eax,ebx
	sub	eax,full_screen_height-8
	jc	no_mask_y
	sub	[mask_height],eax

no_mask_y:	retn

;--------------------------------------------------------------------------------------------------

;	save data under mouse

save_mouse_data::	push	ds
	push	es
	mov	ax,ds
	mov	es,ax
	mov	ds,[screen_segment]
	mov	bx,es:[screen_segment]
	mov	ds,bx

	mov	esi,es:[mouse_position]

	mov	edi,es:[saved_data]

	mov	edx,es:[mask_height]

sm_y_loop:	push	esi
	mov	ecx,es:[mask_width]
	rep	movsb
	pop	esi
	add	esi,full_screen_width
	floop	edx,sm_y_loop

	pop	es
	pop	ds

	bts	[mouse_flag],mf_saved

	retn

;--------------------------------------------------------------------------------------------------

;	draw the mouse

draw_mouse::	push	es
	mov	es,[screen_segment]
	mov	esi,[mouse_data2]
	add	esi,SIZE s
	mov	edi,[mouse_position]
	mov	edx,[mask_height]
mouse_y_loop:	push	esi
	push	edi
	mov	ecx,[mask_width]

mouse_x_loop:	lodsb
	jife	al,no_mpix
	mov	es:[edi],al
no_mpix:	inc	edi
	floop	ecx,mouse_x_loop

	pop	edi
	pop	esi

	add	esi,[mouse_width]
	add	edi,full_screen_width
	floop	edx,mouse_y_loop

	pop	es
	retn

;--------------------------------------------------------------------------------------------------

;	Restore data under mouse

restore_mouse_data::

	btr	[mouse_flag],mf_saved
	jnc	rmd_ret

	push	es
	mov	es,[screen_segment]

	mov	esi,[saved_data]
	mov	edi,[mouse_position]
	mov	edx,[mask_height]

rm_loop:	push	edi
	mov	ecx,[mask_width]
	rep	movsb
	pop	edi
	add	edi,full_screen_width
	floop	edx,rm_loop

	pop	es

rmd_ret:	retn

;--------------------------------------------------------------------------------------------------


draw_new_mouse::	call	calculate_mouse_values
	call	save_mouse_data
	call	draw_mouse
	retn

end_handler::


mouse_handler	endp





draw_mouse_to_back_screen proc

;	Draw the mouse to the back screen.

	bts	[mouse_flag],mf_in_int

;	First re-save the data under the back screen

	mov	esi,[mouse_position]
	add	esi,[backscreen]
	push	esi

	mov	edi,[saved_data]

	mov	edx,[mask_height]

save_loop:	push	esi
	mov	ecx,[mask_width]
	rep	movsb
	pop	esi
	add	esi,full_screen_width
	floop	edx,save_loop

;	Now draw mouse

	pop	edi				;address to draw to
	mov	esi,[mouse_data2]
	add	esi,SIZE s

	mov	edx,[mask_height]

draw_loop:	push	esi
	push	edi
	mov	ecx,[mask_width]
pix_loop:	lodsb
	or	al,al
	je	no_pix
	mov	bpt es:[edi],al
no_pix:	inc	edi
	floop	ecx,pix_loop
	pop	edi
	add	edi,full_screen_width
	pop	esi
	add	esi,[mouse_width]
	floop	edx,draw_loop

	btr	[mouse_flag],mf_in_int

	ret

draw_mouse_to_back_screen	endp





restore_data_to_back_screen proc

;	Restore saved data to the back screen

	mov	esi,[saved_data]

	mov	edi,[mouse_position]
	add	edi,[backscreen]

	mov	edx,[mask_height]

restore_loop:	push	edi
	mov	ecx,[mask_width]
	rep	movsb
	pop	edi
	add	edi,full_screen_width
	floop	edx,restore_loop

	btr	[mouse_flag],mf_got_int
	jnc	no_int
	call	restore_mouse_data
	call	draw_new_mouse

no_int:	ret

restore_data_to_back_screen endp





sprite_mouse	proc

;	eax is frame number of this mouse
;	ebx is mouse x offset
;	ecx is mouse y offset

	bts	[mouse_flag],mf_in_int

	mov	[mouse_type2],eax
	mov	[mouse_offset_x],ebx
	mov	[mouse_offset_y],ecx

	push	esi

	push	eax
	call	restore_mouse_data
	pop	eax

	mov	esi,[mice_data]
	mul	(s ptr[esi]).s_sp_size			;point to frame
;	add	eax,SIZE s
	add	eax,esi
	mov	[mouse_data2],eax

	movzx	eax,(s ptr[esi]).s_width
	mov	[mouse_width],eax
	movzx	ebx,(s ptr[esi]).s_height
	mov	[mouse_height],ebx
	
	call	draw_new_mouse

	btr	[mouse_flag],mf_in_int
	pop	esi
	ret

sprite_mouse	endp


remove_mouse	proc

;	Remove and stop the mouse

	bts	[mouse_flag],mf_no_update
	call	restore_mouse_data
	ret

remove_mouse	endp

restore_mouse	proc

	call	draw_new_mouse
	btr	[mouse_flag],mf_no_update
	ret

restore_mouse	endp



ifdef with_replay

replay_mouse	proc

	bts	[mouse_flag],mf_in_int

	mov	[amouse_x],eax
	mov	[amouse_y],ebx

	call	restore_mouse_data
	call	draw_new_mouse

	btr	[mouse_flag],mf_in_int

	ret

replay_mouse	endp




;proc_start	_set_replay__Nv
;
;	bts	[_replay_flag],rf_replay_on
;
;proc_end	_set_replay__Nv



endif


end32code


start16code

call_back_addr	dd	?				;Address of DOS32 call back device

mouse_init	proc	far
assume ds:__X386_CODESEG_16
	mov	[call_back_addr],edi		;set call back
	push	cs
	pop	es
	mov	ax,12
	mov	dx,offset mouse_call
	mov	cx,07fh	;dx			;mouse mask
	int	33h

	retf
mouse_init	endp

mouse_call	proc	far
	db	66h			;push dword below
	push	0			;push a dword zero for pointer to segments
	push	0			;dummy space for protected mode cs
;	masm can't be convinced to push a 32 bit offset so do it the hard way......
	db	66h			;size prefix
	db	68h			;push immediate
	dd	offset mouse_handler	;offset of protected mode procedure
	call	cs:call_back_addr		;call 32 bit function mous_call32
	add	sp,10			;pop parameters off stack
	ret				;return to mouse driver
mouse_call	endp


end16code


	end
