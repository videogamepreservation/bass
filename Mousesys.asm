include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_flags	equ	1
	include include.asm


start32data

emouse_b	dd	0


lock_mouse_x	dd	?
lock_mouse_y	dd	?

	align	4

mousexoff	dd	0					;mouse x offset


no_main_objects	equ	24				;table for which mouse goes with which object
no_linc_objects	equ	21

mouse_object_list	dd	65
	dd	9
	dd	66
	dd	64
	dd	8
	dd	63
	dd	10
	dd	11
	dd	71
	dd	76
	dd	37
	dd	36
	dd	42
	dd	75
	dd	79
	dd	6
	dd	74
	dd	39
	dd	49
	dd	43
	dd	34
	dd	35
	dd	77
	dd	38

;	Link cursors

	dd	24625
	dd	24649
	dd	24827
	dd	24651
	dd	24583
	dd	24581
	dd	24582
	dd	24628
	dd	24650
	dd	24629
	dd	24732
	dd	24631
	dd	24584
	dd	24630
	dd	24626
	dd	24627
	dd	24632
	dd	24643
	dd	24828
	dd	24830
	dd	24829


ifdef with_replay
data_saved	dd	0			;used to prevent double checks
endif

end32data



start32code
	extrn	script:near
	extrn	sprite_mouse:near


mouse_engine	proc

	test	[mouse_b],-1				;fucking amiga bodge
	jne	not_amiga_bodge
	mov	[logic_talk_button_release],0
not_amiga_bodge:

	mov	eax,[amouse_x]				;make a copy of the mouse registers
	add	eax,top_left_x
	mov	[tmousex],eax
	mov	eax,[amouse_y]
	add	eax,top_left_y
	mov	[tmousey],eax

	clear	eax					;ensure button not pressed while looking at it
	xchg	eax,[bmouse_b]
	mov	[emouse_b],eax

ifdef with_replay
	mov	[data_saved],0
	call	check_replay_mouse
endif
	test	[mouse_stop],-1				;mouse stop?
	jne	me_ret

	bt	[mouse_status],1				;cursor and buttons?
	jnc	me_ret

	call	pointer_engine

	bt	[mouse_status],2				;buttons enabled?
	jc	button_engine_1

me_ret:	mov	[emouse_b],0				;don't save up buttons
	ret

mouse_engine	endp




pointer_engine	proc

;	What is the pointer over
;	run get-ons and get-offs

;	using a seperate list of id's has the added advantage
;	of allowing us to set the priority of each item.
;	i.e. people come before floor areas...

	mov	eax,[mouse_list_no]			;starting mouse list number - the list may change itself

get_mouse_list:	fetch_compact edi

pointer_loop:	flodswl eax,edi
	jife	eax,pointer_eol

	cmp	ax,-1
	jne	not_address_skip

	mov	ax,[edi]					;new list id
	jmp	get_mouse_list

not_address_skip:	fetch_compact

	bt	(cpt[esi]).c_status,4			;is mouse detectable
	jnc	pointer_loop

	mov	eax,[screen]				;on current screen?
	cmp	ax,(cpt[esi]).c_screen
	jne	pointer_loop

;	Find the set

	mov	ax,(cpt[esi]).c_mouse_rel_x		;look at mouse x
	add	ax,(cpt[esi]).c_xcood
	cmp	ax,wpt[tmousex]
	ja	pointer_loop				;too far left?

	add	ax,(cpt[esi]).c_mouse_size_x
	cmp	ax,wpt[tmousex]
	jc	pointer_loop				;too far right?

;	now y

	mov	ax,(cpt[esi]).c_mouse_rel_y
	add	ax,(cpt[esi]).c_ycood
	cmp	ax,wpt[tmousey]
	ja	pointer_loop				;too high?

	add	ax,(cpt[esi]).c_mouse_size_y
	cmp	ax,wpt[tmousey]
	jc	pointer_loop

;	its a hit

	movzx	eax,wpt[edi-2]				;get id of item

pointer_eol:	;ax is 0 or id of item beneath cursor

	cmp	eax,[special_item]
	je	pe_ret

;	ok, the pointer has a change of circumstances
;	if the cursor is now over nothing then run the
;	get-off script, else, if the cursor is now over something
;	then run the new get-on and set up a new get off

ifdef with_replay
	call	save_mouse_values
endif
	mov	[special_item],eax

	jife	eax,run_get_off

;	ok, the cursor is over something
;	run the get-off if it was previously over something else

	mov	eax,[get_off]
	jife	eax,setup_on

	call	script

setup_on:	;over something so run new get-on

	movzx	eax,(cpt[esi]).c_mouse_off			;save get off for later
	mov	[get_off],eax

	movzx	eax,(cpt[esi]).c_mouse_on
	jife	eax,pe_ret

	jmp	script

pe_ret::	ret

pointer_engine	endp




run_get_off	proc

;	run and clear get off script

	clear	eax
	xchg	eax,[get_off]
	jife	eax,pe_ret
	jmp	script

run_get_off	endp




button_engine_1	proc

;	checks for clicking on special_item
;	"compare the size of this routine to S1 mouse_button"

	test	[emouse_b],-1			;anything pressed
	je	no_button

;	ok, a button is pressed

ifdef with_replay
	call	save_mouse_values
endif
	mov	eax,[emouse_b]
	mov	[button],eax
	mov	[emouse_b],0

	mov	eax,[special_item]		;over anything?
	jife	eax,no_button

	fetch_compact
	movzx	eax,(cpt[esi]).c_mouse_click
	jife	eax,no_button

	jmp	script				;do the script

no_button:	ret

button_engine_1	endp




fn_disk_mouse	proc

;	Turn the mouse into a disk mouse

	mov	eax,mouse_disk
	mov	ebx,11
	mov	ecx,11
	call	sprite_mouse

	mov	al,1					;don't quit from interpreter
	ret

fn_disk_mouse	endp




fn_normal_mouse	proc

	mov	eax,mouse_normal
	clear	ebx
	clear	ecx
	call	sprite_mouse

	mov	al,1
	ret

fn_normal_mouse	endp




fn_no_human	proc

	test	[mouse_stop],-1
	jne	mouse_locked

	and	[mouse_status],1			;preserve stop, kill cursor and buttons
	call	run_get_off			;clear anything else

	call	fn_blank_mouse			;no cursor

mouse_locked:	mov	al,1				;keep going
	ret

fn_no_human	endp




fn_set_stop	proc

	or	[mouse_stop],1			;set the stop flag

	mov	al,1				;and keep going
	ret

fn_set_stop	endp




fn_blank_mouse	proc

	mov	[mousexoff],0			;re-align mouse

	mov	eax,mouse_blank
	clear	ebx
	clear	ecx
	call	sprite_mouse

	mov	al,1
	ret

fn_blank_mouse	endp




fn_cross_mouse	proc

	test	[object_held],-1
	jne	fn_close_hand

fn_cross_mouse	endp
do_cross_mouse	proc

	mov	eax,mouse_cross
	mov	ebx,4		;5
	mov	ecx,4
	call	sprite_mouse

	mov	al,1
	ret

do_cross_mouse	endp




fn_close_hand	proc

;	Indicate we have an object that is not over an object

	mov	edx,[object_held]
	jife	edx,fn_normal_mouse		;no object no mouse cursor

;	Find the sprite to go with this object

	call	find_mouse_cursor

	shl	eax,1
	mov	esi,[object_mouse_data]		;get offset into data
	movzx	ecx,(s ptr[esi]).s_sp_size
	imul	eax,ecx
	add	eax,SIZE s
	add	esi,eax

	mov	edi,[mice_data]			;transfer data to first mouse sprite
	add	edi,SIZE s
	rep	movsb

	clear	eax
	mov	ebx,5
	mov	ecx,5
	call	sprite_mouse

	mov	al,1
	ret

fn_close_hand	endp




fn_open_hand	proc

;	Indicate we have an object which is over another object

	mov	esi,offset mouse_object_list

;	Find the sprite to go with this object

	mov	edx,[object_held]
	call	find_mouse_cursor
	
	shl	eax,1
	inc	eax
	mov	esi,[object_mouse_data]		;get offset into data
	movzx	ecx,(s ptr[esi]).s_sp_size
	imul	eax,ecx
	add	eax,SIZE s
	add	esi,eax

	mov	edi,[mice_data]			;transfer data to first mouse sprite
	add	edi,SIZE s
	rep	movsb

	clear	eax
	mov	ebx,5
	mov	ecx,5
	call	sprite_mouse

	mov	al,1
	ret

fn_open_hand	endp




fn_cursor_left	proc

	mov	eax,mouse_left
	clear	ebx
	mov	ecx,5
	call	sprite_mouse

	mov	al,1
	ret

fn_cursor_left	endp




fn_cursor_right	proc

	mov	eax,mouse_right
	mov	ebx,9
	mov	ecx,4
	call	sprite_mouse
	
	mov	al,1
	ret

fn_cursor_right	endp




fn_cursor_down	proc

	mov	eax,mouse_down
	mov	ebx,9
	mov	ecx,4
	call	sprite_mouse
	
	mov	al,1
	ret

fn_cursor_down	endp




fn_cursor_up	proc

	mov	eax,mouse_up
	mov	ebx,9
	mov	ecx,4
	call	sprite_mouse
	
	mov	al,1
	ret

fn_cursor_up	endp




fn_no_buttons	proc

;	remove the mouse buttons

	and	[mouse_status],0fffffffbh
	mov	al,1
	ret

fn_no_buttons	endp




fn_add_buttons	proc

	mov	al,4				;use this to keep script going
	or	bpt[mouse_status],al
	ret

fn_add_buttons	endp


ifdef with_replay

save_mouse_values	proc

	test	[data_saved],-1
	jne	no_record
	mov	[data_saved],1

	pusha

;	Save a mouse action

;	Sometimes the thing the mouse is interacting with will be slightly off position, basically
;	mega characters. Save certain megas' coordinates so we are sure to hit them

	mov	eax,[special_item]
	cmp	eax,1
	je	save_joey
	cmp	eax,16
	je	save_joey
	cmp	eax,16441
	je	save_joey
	jmp	no_save

save_joey:	push	eax
	fetch_compact
	mov	eax,-2					;-2 = save joey coords
	pop	ebx
	shl	ebx,16
	mov	bx,(cpt[esi]).c_screen			;save screen x and y
	mov	cx,(cpt[esi]).c_xcood
	shl	ecx,16
	mov	cx,(cpt[esi]).c_ycood
	call	replay_record_event

no_save:	mov	eax,[tmousex]
	mov	ebx,[tmousey]
	mov	ecx,[emouse_b]
	call	replay_record_event

	popa

no_record:	ret

save_mouse_values	endp

endif


wait_mouse_not_pressed proc

	test	[mouse_b],-1
	jne	wait_mouse_not_pressed

	mov	[bmouse_b],0

	ret

wait_mouse_not_pressed endp




find_mouse_cursor	proc

;	Find mouse cursor for item edx

	mov	esi,offset mouse_object_list

;	Check main game objects

	mov	eax,no_main_objects
	mov	ecx,eax

find_mouse1:	cmp	edx,[esi]
	je	found_mouse
	lea	esi,4[esi]
	loop	find_mouse1

;	Check linc objects

	mov	eax,no_linc_objects
	mov	ecx,eax

find_mouse2:	cmp	edx,[esi]
	je	found_mouse
	lea	esi,4[esi]
	loop	find_mouse2

	mov	ecx,eax

found_mouse:	sub	eax,ecx		;calculate sprite number

	ret
	
find_mouse_cursor	endp




lock_mouse	proc

	mov	eax,[amouse_x]
	mov	[lock_mouse_x],eax
	mov	eax,[amouse_y]
	mov	[lock_mouse_y],eax

	ret

lock_mouse	endp


unlock_mouse	proc

	mov	ecx,[lock_mouse_x]
	mov	[amouse_x],ecx
	mov	edx,[lock_mouse_y]
	mov	[amouse_y],edx
	mov	ax,4
	shl	ecx,1
	int	33h

	ret


unlock_mouse	endp



end32code
	end
