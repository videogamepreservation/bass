include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_sequates	equ	1
include_scripts	equ	1
include_flags	equ	1
include_logic	equ	1
include_error_codes equ	1
	include include.asm



start32data

max_objects	equ	30

object_list	dd	max_objects dup (?)

tmousex	dd	?
tmousey	dd	?
new_safe_x	dd	?
new_safe_y	dd	?

current_section	dd	-1

end32data


start32save_data

save_current_section dd -1

past_intro	dd	0				;set when past intro sequence

end32save_data



start32code
	extrn	logic_turn:near
	extrn	logic_simple_anim:near
	extrn	logic_anim:near
	extrn	logic_script:near
	extrn	remove_object_from_walk:near


fn_get_to	proc

;	always load a get-to script-	S2(28Aug92tw)
;	does NOT check to see if we're at the place
;	this is because with doorways you walk to different
;	places according to whether the door is open or closed
;	so if you click on a closed door you walk to the closed
;	door & open it - if you then click again you run the
;	same get-to which will now walk you through the door
;	because its open. this is also the reason that the
;	action mode is passed here - because some get-to's
;	need to know what you're going to do in order to get
;	you to the right place - strange - but true

;	esi is compact
;	eax is target place id
;	ebx is mode - doors need to know at get-to stage
;		      - before the action script

	mov	(cpt [esi]).c_up_flag,bx		;save mode for action script
	push	eax				;save target place id
	movzx	eax,(cpt [esi]).c_place		;where we currently are
	add	(cpt [esi]).c_mode,4		;next level up
	fetch_compact edi
	mov	edi,(cpt [edi]).c_get_to_table	;get get to table
	pop	eax

	cherror edi,e,0,em_internal_error

get_to_loop:	cmp	ax,[edi]				;found entry?
	je	load_script

	cherror wpt [edi],e,-1,em_internal_error	;if we get to end (-1) then place is missing

	lea	edi,4[edi]
	jmp	get_to_loop

load_script:	movzx	ebx,(cpt [esi]).c_mode		;get current mode
	movzx	eax,wpt 2[edi]			;get new script
	mov	c_base_sub[esi+ebx],eax

	clear	eax				;drop out of script
	ret					;but stay in script mode

fn_get_to	endp




fn_ar	proc

;	Set mega esi to route to eax=x,ebx=y

	mov	(cpt [esi]).c_down_flag,1		;assume failure in-case logic is interupted by speech (esp Joey)

	mov	(cpt [esi]).c_ar_target_x,ax
	mov	(cpt [esi]).c_ar_target_y,bx
	mov	(cpt [esi]).c_logic,l_ar		;Set to AR mode

	and	(cpt [esi]).c_xcood,0fff8h
	and	(cpt [esi]).c_ycood,0fff8h

	clear	eax				;drop out of script
	ret

fn_ar	endp




fn_leaving	proc

;	mega is leaving this place for the next
;	sub 1 from previous place's at flag	S2(14Oct92tw)
;	also clear the previous at-watch flag

;	its possible that neither may have been set...

;	* inc'ing & dec'ing has the effect of
;	showing us how many people are at a place
;	and not just anyone here, yes or no

	mov	(cpt[esi]).c_at_watch,0		;clear the previous place's
						;at watch flag - there might
						;not have been one
	movzx	eax,(cpt[esi]).c_leaving		;get the previous flag
	jife	ax,no_previous_flag

	sub	dpt [offset script_variables+eax],1	;decrement the script variable
	mov	(cpt[esi]).c_leaving,0		;I shall do this only once

no_previous_flag:	mov	al,1				;keep going
	ret

fn_leaving	endp




fn_ar_animate	proc

;	Set compact to animation

	mov	(cpt[esi]).c_mood,0		;high level 'not stood still'
	mov	(cpt[esi]).c_logic,l_ar_anim
	clear	eax				;drop out of script
	ret

fn_ar_animate	endp




fn_turn_to	proc

;	turn compact esi to direction al

	mov	ebx,eax
	clear	eax
	mov	al,20				;5 tables = 5 dwords
	mul	(cpt[esi]).c_dir			;get current direction
	mov	(cpt[esi]).c_dir,bx		;set new direction
	add	ax,(cpt[esi]).c_mega_set
	lea	eax,(cpt[esi+eax]).c_turn_table_up
	mov	eax,[eax+ebx*4]			;get direction data
	jife	eax,no_turn

	mov	(cpt[esi]).c_turn_prog,eax		;put turn program in
	mov	(cpt[esi]).c_logic,l_turning
	call	logic_turn
	clear	eax				;drop out of script
	ret

no_turn:	mov	al,1				;keep going
	ret

fn_turn_to	endp




fn_set_to_stand	proc

;	run the appropriate animation for what
;	direction the mega is facing	S2(3Sep92tw)
;	the animator returns to script mode

;	* processes first stand cycle to avoid gaps

	mov	(cpt[esi]).c_mood,1			;high level stood still
	movzx	eax,(cpt[esi]).c_dir			;get direction
	movzx	ebx,(cpt[esi]).c_mega_set			;get mega set
	lea	ebx,(cpt[ebx+esi]).c_stand_up
	mov	ebx,[ebx+eax*4]				;get pointer to data
	flodsws ax,ebx					;get frames offset
	mov	(cpt[esi]).c_offset,ax
	mov	(cpt[esi]).c_grafix_prog,ebx
	mov	(cpt[esi]).c_logic,l_simple_mod
	call	logic_simple_anim
	clear	eax					;drop out of script
	ret

fn_set_to_stand	endp




fn_foreground	proc

;	Make sprite eax a foreground sprite

	fetch_compact
	and	bpt(cpt[esi]).c_status,0f8h
	or	bpt(cpt[esi]).c_status,st_foreground
	mov	eax,1
	ret

fn_foreground	endp




fn_toggle_grid	proc

;	Toggle a mega's grid plotting

	mov	al,st_grid_plot				;use this to continue script
	xor	bpt(cpt[esi]).c_status,al
	ret

fn_toggle_grid	endp




fn_run_anim_mod	proc

;	Set to l_animate mode
;	coordinates yes
;	sync	     no

;	eax is animation number

	fetch_compact edi

;	edi points to animation data

	flodsws ax,edi					;get sprite set
	mov	(cpt[esi]).c_offset,ax
	mov	(cpt[esi]).c_grafix_prog,edi
	mov	(cpt[esi]).c_logic,l_mod_animate
	call	logic_anim
	clear	eax					;drop from script
	ret

fn_run_anim_mod	endp




fn_reset_id	proc

;	used when a mega is to be restarted
;	eg - when a smaller mega turn to larger
;	   - a mega changes rooms...

;	eax is id, ebx is reset block

	fetch_compact
	mov	eax,ebx
	fetch_compact edi

reset_loop:	movzx	eax,wpt[edi]
	add	edi,2
	cmp	ax,-1
	je	done
	flodsws bx,edi
	mov	[esi+eax],bx
	jmp	reset_loop

done:	ret						;ax=-1 for continue script


fn_reset_id	endp




fn_inc_mega_set	proc

;	esi is mega

	mov	eax,next_mega_set				;use this to continue script
	add	(cpt[esi]).c_mega_set,ax
	ret

fn_inc_mega_set	endp




fn_dec_mega_set	proc

	mov	eax,next_mega_set				;use this to continue script
	sub	(cpt[esi]).c_mega_set,ax
	ret

fn_dec_mega_set	endp




fn_sort	proc

;	Set mega eax to sort mode

	fetch_compact
	and	bpt(cpt[esi]).c_status,0f8h
	mov	al,st_sort				;use this to continue script
	or	bpt(cpt[esi]).c_status,al
	ret

fn_sort	endp




fn_add_human	proc

;	reintroduce the mouse so that the human
;	can control the player
;	could still be stwitched out at high-level

	test	[mouse_stop],-1
	jne	mouse_is_locked

	or	[mouse_status],6				;cursor & mouse
	mov	eax,[new_safe_x]
	mov	[tmousex],eax				;restore cursor x and y
	mov	eax,[new_safe_y]
	mov	[tmousey],eax

	cmp	[amouse_y],2				;stop mouse activating top line
	jnc	no_y_cor
	mov	[amouse_y],2
no_y_cor:

;	force the pointer engine into running a get-off
;	even if it's over nothing

;	KWIK-FIX
;	get off may contain script to remove mouse pointer text
;	surely this script  should be run just in case
;	I am going to try it anyway

	mov	eax,[get_off]
	jife	eax,no_get_off
	call	script

no_get_off:	mov	[special_item],-1
	mov	[get_off],reset_mouse

mouse_is_locked:	mov	al,1
	ret

fn_add_human	endp




fn_interact	proc

;	esi is compact
;	eax is target id

	add	(cpt[esi]).c_mode,4			;next level up
	mov	(cpt[esi]).c_logic,l_script
	fetch_compact edi
	movzx	eax,(cpt[edi]).c_action_script		;get target action script
	movzx	ebx,(cpt[esi]).c_mode			;put into correct mode
	mov	c_base_sub[esi+ebx],eax
	clear	eax					;drop out of script
	ret

fn_interact	endp




fn_await_sync	proc

	test	(cpt[esi]).c_sync,-1
	jne	that_was_quick

;	Set compact to l_wait_sync

	mov	(cpt[esi]).c_logic,l_wait_sync
	clear	eax					;drop out of script
	ret

that_was_quick:	mov	al,1
	ret

fn_await_sync	endp




fn_pause	proc

;	Set mega to l_pause

;	wait eax cycles

	mov	(cpt[esi]).c_flag,ax
	mov	(cpt[esi]).c_logic,l_pause

	clear	eax					;drop out of script
	ret

fn_pause	endp




fn_send_sync	proc

;	Send a sync to a mega

;	eax is mega
;	ebx is sync value

	fetch_compact
	mov	(cpt[esi]).c_sync,bx

	clear	eax					;drop out of script
	ret

fn_send_sync	endp




fn_quit	proc

	clear	eax					;just drop out of the script
	ret

fn_quit	endp




fn_run_frames	proc

;	Set to l_frames
;	sync checks but not on this first cycle

;	eax is sequence number

	fetch_compact edi
	mov	(cpt[esi]).c_logic,l_frames
	mov	ax,[edi]
	mov	(cpt[esi]).c_offset,ax
	add	edi,2
	cherror wpt[edi],e,0,em_internal_error
	mov	(cpt[esi]).c_grafix_prog,edi
	call	logic_simple_anim
	clear	eax					;drop out of script
	ret

fn_run_frames	endp




fn_set_alternate	proc

;	change current script
;	takes a whole cycle

;	esi is mega
;	ax is script

	mov	(cpt[esi]).c_alt,ax
	mov	(cpt[esi]).c_logic,l_alt
	clear	eax					;stop the script
	ret

fn_set_alternate	endp




fn_simple_mod	proc

;	set to l_simple_mod mode	S2(19Nov92tw)
;	as FN_run_anim_mod except we ignore
;	the x,y coordinates in the sequence data

;	eax is anim seq number

	fetch_compact edi
	flodsws ax,edi

	and	eax,0ffffh
	mov	(cpt[esi]).c_offset,ax
	cherror wpt[edi],e,0,em_internal_error
	mov	(cpt[esi]).c_grafix_prog,edi
	mov	(cpt[esi]).c_logic,l_simple_mod
	call	logic_simple_anim
	clear	eax
	ret

fn_simple_mod	endp




fn_random	proc

;	eax is a number to and the random number with

	push	eax
	call	do_random
	pop	ebx
	movzx	eax,wpt[random+2]
	and	eax,ebx
	mov	[rnd],eax
	mov	al,1				;continue script
	ret

fn_random	endp




fn_clear_stop	proc

	mov	[mouse_stop],0
	mov	al,1
	ret

fn_clear_stop	endp




fn_idle	proc

;	set the player idling

	mov	(cpt[esi]).c_logic,0
	mov	al,1				;script continues
	ret

fn_idle	endp




fn_kill_id	proc

;	remove compact eax from game

	jife	eax,fk_ret			;id 0 = kill text

	push	esi
	fetch_compact
	bt	(cpt[esi]).c_status,7		;plotted into grid?
	jnc	not_on_grid
	call	remove_object_from_walk
not_on_grid:	mov	(cpt[esi]).c_status,0
	pop	esi

fk_ret:	mov	al,1				;continue
	ret

fn_kill_id	endp




fn_start_menu	proc

;	initialise the top menu bar	S2(9Oct92tw)
;	eax contains the address of the 1st object (o0 for game menu, k0 for linc)

	add	eax,offset script_variables
	push	eax

;	(1) FIRST, SET UP THE 2 ARROWS SO THEY APPEAR ON SCREEN

	mov	edx,[screen]

	mov	eax,47
	fetch_compact
	mov	(cpt[esi]).c_status,st_mouse+st_foreground+st_logic+st_recreate
	mov	(cpt[esi]).c_screen,dx

	mov	eax,48
	fetch_compact
	mov	(cpt[esi]).c_status,st_mouse+st_foreground+st_logic+st_recreate
	mov	(cpt[esi]).c_screen,dx


;	(2) COPY OBJECTS FROM NON-ZERO INVENTORY VARIABLES INTO OBJECT DISPLAY LIST (& COUNT THEM)

;	sort the objects and pad with blanks

	pop	esi
	mov	edi,offset object_list
	mov	ecx,max_objects
	clear	edx

menu_create:	lodsd
	jife	eax,empty_slot
	stosd
	inc	edx
empty_slot:	loop	menu_create

	mov	[menu_length],edx				;save menu length

;	(3) OK, NOW TOP UP THE LIST WITH THE REQUIRED NO. OF BLANK OBJECTS (for min display length 11)

	cmp	edx,11
	jnc	stage_4

	mov	eax,51		;id of first blank

	mov	ecx,11
	sub	ecx,edx

do_blank:	stosd
	inc	eax
	loop	do_blank

;	(4) KILL ID's OF ALL 20 OBJECTS SO UNWANTED ICONS (SCROLLED OFF) DON'T REMAIN ON SCREEN
;	    (There should be a better way of doing this - only kill id of 12th item when menu has scrolled right)

stage_4:	mov	esi,offset object_list
	mov	ecx,max_objects

reset_icons_loop:	lodsd
	jife	eax,menu_5

	fetch_compact edi
	mov	(cpt[edi]).c_status,st_logic
	loop	reset_icons_loop


;	(5) NOW FIND OUT WHICH OBJECT TO START THE DISPLAY FROM (depending on scroll offset)

menu_5:	mov	esi,offset  object_list

	cmp	edx,11					;check we can scroll
	jnc	can_scroll

	mov	[scroll_offset],0
	jmp	stage_6

can_scroll:	mov	ebx,[scroll_offset]
	sub	edx,11					;make edx no  we can scroll
	cmp	ebx,edx
	jc	calc_bytes

	mov	ebx,edx
	mov	[scroll_offset],ebx

calc_bytes:	shl	ebx,2					;no of bytes to skip in object list
	add	esi,ebx


;	(6) AND FINALLY, INITIALISE THE 11 OBJECTS SO THEY APPEAR ON SCREEEN

stage_6:	mov	edx,[menu]				;check if id_std_menu_logic
	;sub	edx,id_std_menu_logic
	mov	ebp,[screen]

	mov	ecx,11
	mov	ebx,128+28				;rolling x coordinate

menu_int_loop:	lodsd
	fetch_compact edi

	mov	(cpt[edi]).c_status,st_mouse+st_foreground+st_logic+st_recreate
	mov	(cpt[edi]).c_screen,bp

	mov	(cpt[edi]).c_xcood,bx
	add	bx,24
	mov	(cpt[edi]).c_ycood,112

	cmp	edx,2
	jne	next_object

	mov	(cpt[edi]).c_ycood,136			;set y-coord to fully down because menu fully down
							; and so player might be scrolling new icons into view

next_object:	loop	menu_int_loop

	mov	al,1				;carry on
	ret

fn_start_menu	endp




fn_assign_base	proc

;	start id processing a base script	S2(26Aug92tw)
;	used when player clicks on something, or,
;	when a mega is to have a new base... etc.

;	eax is id
;	ebx is script

	fetch_compact
	mov	(cpt[esi]).c_mode,c_base_mode
	mov	(cpt[esi]).c_logic,l_script
	mov	(cpt[esi]).c_base_sub,ebx

	mov	al,1					;keep going
	ret

fn_assign_base	endp




fn_toggle_mouse	proc

;	Toggle the mouse highlighting

;	eax is id

	fetch_compact
	xor	(cpt[esi]).c_status,st_mouse
	mov	al,1
	ret

fn_toggle_mouse	endp




fn_move_items	proc

;	Move a list of id's to another screen

;	eax is list number
;	ebx is screen number

	mov	edi,[offset move_list+eax*4]

move_loop:	flodswl eax,edi
	jife	eax,move_done

	fetch_compact
	mov	(cpt[esi]).c_screen,bx
	jmp	move_loop

move_done:	mov	al,1
	ret

fn_move_items	endp




fn_send_fast_sync	proc

;	send a sync to a mega, continue with current script

;	eax is mega id
;	ebx is sync value

	fetch_compact
	mov	(cpt[esi]).c_sync,bx
	mov	al,1
	ret

fn_send_fast_sync	endp




fn_background	proc

;	set us to background

	and	(cpt[esi]).c_status,0fff8h
	or	(cpt[esi]).c_status,st_background

	mov	al,1
	ret

fn_background	endp




fn_we_wait	proc

;	We have hit another mega
;	we are going to wait for it to move

;	esi is us
;	eax is it's id

	mov	(cpt[esi]).c_waiting_for,ax

fn_we_wait	endp
;NOWT IN YERE
stop_and_wait	proc

;	2nd entry point called from logic_ar_animate

	add	(cpt[esi]).c_mode,4
	movzx	eax,(cpt[esi]).c_stop_script
	movzx	ebx,(cpt[esi]).c_mode
	mov	c_base_sub[esi+ebx],eax
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

stop_and_wait	endp




fn_no_sprite_engine proc

;	stop the compact printing	S2(29Oct92tw)
;	remove foreground, background & sort

	and	(cpt[esi]).c_status,0fff8h
	mov	al,1
	ret

fn_no_sprite_engine endp




fn_face_id	proc

;	return the direction to turn to face another id

;	esi is us
;	eax is id to turn to

;	pass back result in c_just_flag

	fetch_compact edi

	mov	ax,(cpt[esi]).c_xcood
	sub	ax,(cpt[edi]).c_xcood			;check left
	jnc	its_to_left

;	we're to the left

	neg	ax
	mov	(cpt[esi]).c_get_to_flag,3
	jmp	vertical_check

its_to_left:	mov	(cpt[esi]).c_get_to_flag,2

vertical_check:	;now check y

;	ax is x diff

	mov	bx,(cpt[esi]).c_ycood

;	we must find the true bottom of the sprite
;	it is not enough to use y coord because changing
;	sprite offsets can ruin the formula - instead we
;	will use the bottom of the mouse collision area


	mov	cx,(cpt[edi]).c_ycood
	add	cx,(cpt[edi]).c_mouse_rel_y
	add	cx,(cpt[edi]).c_mouse_size_y
	sub	bx,cx
	jnc	its_above

	neg	bx
	cmp	bx,ax					;check if hor > ver
	jc	end_of_fn

	mov	(cpt[esi]).c_get_to_flag,1			;we will face down

end_of_fn:	mov	al,1
	ret

its_above:	cmp	bx,ax
	jc	end_of_fn

	mov	(cpt[esi]).c_get_to_flag,0
	mov	al,1
	ret

fn_face_id	endp




fn_start_sub	proc

;	Run a subroutine

	add	(cpt[esi]).c_mode,4
	movzx	ebx,(cpt[esi]).c_mode
	mov	c_base_sub[esi+ebx],eax

	clear	eax					;drop out
	ret

fn_start_sub	endp




fn_send_request	proc

;	send an interaction script to id

;	eax is id of target
;	ebx is script

	fetch_compact
	mov	(cpt[esi]).c_request,bx

	clear	eax					;drop out
	ret

fn_send_request	endp




fn_check_request	proc

;	check for interaction request	S2(23Sep92tw)
;	setup if found
;	should be called from base -
;	(anything above base will be destroyed)

	mov	al,1					;assume script continue

	test	(cpt[esi]).c_request,-1
	je	fcr_ret

	mov	(cpt[esi]).c_mode,c_action_mode		;into action mode

	movzx	ebx,(cpt[esi]).c_request			;get script
	mov	(cpt[esi]).c_action_sub,ebx

	clear	eax					;drop from script
	mov	(cpt[esi]).c_request,ax			;and trash request
fcr_ret:	ret

fn_check_request	endp




fn_stop_mode	proc

;	switch compact into stop mode

	mov	(cpt[esi]).c_logic,l_stopped
	clear	eax					;stop the script
	ret

fn_stop_mode	endp




fn_fetch_place	proc

;	fetch the c_place of a mega

	fetch_compact
	movzx	eax,(cpt[esi]).c_place
	mov	[result],eax

	mov	al,1
	ret

fn_fetch_place	endp




fn_custom_joey	proc

;	return id's x & y coordinate & c_mood (i.e. stood still yes/no)
;	used by Joey-Logic - done in code like this because scripts can't
;	get access to another megas compact as easily

	fetch_compact

	movzx	eax,(cpt[esi]).c_xcood
	mov	[player_x],eax

	movzx	eax,(cpt[esi]).c_ycood
	mov	[player_y],eax

	movzx	eax,(cpt[esi]).c_mood
	mov	[player_mood],eax

	movzx	eax,(cpt[esi]).c_screen
	mov	[player_screen],eax

	mov	al,1
	ret

fn_custom_joey	endp




fn_test_list	proc

;	a list of compacts are checked against an x & y coordinate

;	eax is list id
;	ebx = x
;	ecx = y

	mov	[result],0			;assume fail
	fetch_compact

test_loop:	test	wpt[esi],-1			;end of list?
	je	test_end

	cmp	bx,[esi]				;left x
	jc	next

	cmp	bx,2[esi]			;right x
	jnc	next

	cmp	cx,4[esi]			;top y
	jc	next

	cmp	cx,6[esi]			;bottom y
	jnc	next

	movzx	eax,wpt 8[esi]			;get value
	mov	[result],eax

next:	add	esi,10
	jmp	test_loop

test_end:	mov	al,1
	ret

fn_test_list	endp




fn_person_here	proc

;	is id eax in room ebx

	mov	[result],1			;start with yes
	fetch_compact
	cmp	bx,(cpt[esi]).c_screen
	je	fph_ret
	mov	[result],0			;nope
fph_ret:	mov	al,1
	ret

fn_person_here	endp




fn_unhighlight	proc

;	eax is item to unhighlight

	fetch_compact
	dec	(cpt[esi]).c_frame
	mov	(cpt[esi]).c_get_to_flag,0
	mov	al,1
	ret

fn_unhighlight	endp




fn_new_list	proc

;	Reset the chooser list

	mov	edi,offset text1
	clear	eax
	mov	ecx,16
	rep	stosd
	mov	al,1
	ret

fn_new_list	endp




fn_ask_this	proc

;	eax is text number
;	ebx is animation number

;	find first free position

	mov	esi,offset text1

find_hole:	test	dpt[esi],-1
	je	found_hole
	add	esi,8
	jmp	find_hole

found_hole:	mov	[esi],eax
	mov	4[esi],ebx

	mov	al,1
	ret

fn_ask_this	endp




fn_chooser	proc

;	setup the text questions to be clicked on
;	read from text1 until 0	S2(2Oct92tw)

	bts	[system_flags],sf_choosing			;can't save/restore while choosing

	push	esi

	mov	[the_chosen_one],0			;clear result

	mov	edi,offset text1
	mov	ebx,top_left_y				;rolling coordinate

chooser_loop:	mov	eax,[edi]				;text number
	jife	eax,set_up_player
	lea	edi,4[edi]

	push	edi
	push	eax
	push	ebx

	mov	ebx,game_screen_width
	clear	ecx					;no logic
	mov	dl,241	;255
	clear	ebp					;no centre
	call	low_text_manager

;	stipple the text, eax points to data

	movzx	ebx,(s ptr[eax]).s_height
	movzx	edx,(s ptr[eax]).s_width
	shr	edx,1

stipple_loop:	mov	ecx,edx

stip_loop:	test	bpt[eax],-1				;only change 0's
	jne	no_stip
	mov	bpt[eax],1
no_stip:	lea	eax,2[eax]
	floop	ecx,stip_loop

	inc	eax
	floop	ebx,stipple_loop

	pop	ebx
	pop	eax
	pop	edi

;	esi is text compact

	mov	(cpt[esi]).c_get_to_flag,ax		;text number

	mov	eax,[edi]				;get animation number
	lea	edi,4[edi]
	mov	(cpt[esi]).c_down_flag,ax

	or	(cpt[esi]).c_status,st_mouse		;mouse detects

	mov	(cpt[esi]).c_xcood,top_left_x		;set coordinates
	mov	(cpt[esi]).c_ycood,bx
	add	ebx,12

	jmp	chooser_loop

set_up_player:	pop	esi

	cmp	edi,offset text1				;check for nowt to choose
	je	nowt

	mov	(cpt[esi]).c_logic,l_choose		;player frozen until choice made
	call	fn_add_human				;bring back mouse

	clear	eax					;stop script
	ret

nowt:	mov	al,1
	ret

fn_chooser	endp




fn_highlight	proc

;	Highlight text item in new colour

;	eax is item number
;	ebx is new pen

;	as it turns out the new pens are either 11 or 12
;	11 for highlight, 12 for unhighlight

	sub	ebx,11

	xor	bl,1
	add	bl,241

	fetch_compact					;get item compact number
	movzx	eax,(cpt[esi]).c_flag			;get id of data item
	fetch_item					;get address of text data

	call	change_text_sprite_colour

	mov	al,1					;continue
	ret

fn_highlight	endp




fn_text_kill	proc

;	Kill of text items that are mouse detectable

	mov	eax,first_text_compact			;first id
	mov	ecx,10					;10 items

trash_text_loop:	push	eax
	fetch_compact
	pop	eax
	bt	(cpt[esi]).c_status,4			;st_mouse?
	jnc	not_die

	mov	(cpt[esi]).c_status,0			;remove item

not_die:	inc	eax
	loop	trash_text_loop

	mov	al,1
	ret

fn_text_kill	endp




fn_text_kill2	proc

;	Kill all text items,

	mov	eax,first_text_compact			;first id
	mov	ecx,10					;10 items

trash_text_loop:	push	eax
	fetch_compact
	mov	(cpt[esi]).c_status,0			;remove item
	pop	eax
	inc	eax
	loop	trash_text_loop

	mov	al,1
	ret

fn_text_kill2	endp




fn_fetch_y	proc

;	this is really daft, done for the furnace room where the c_status
;	of the lifter depends upon the players y_cood - strange, but true	S2(5Feb93tw)

;	eax is id to fetch y coordinate of

	fetch_compact
	movzx	eax,(cpt[esi]).c_ycood
	mov	[result],eax

	mov	al,1
	ret

fn_fetch_y	endp




fn_alt_set_alternate proc

;	this is the alternate set alternate routine
;	change the current script	S2(9feb93tw)
;	takes a whole cycle

;	eax is target
;	ebx is script

	fetch_compact
	mov	(cpt[esi]).c_alt,bx
	mov	(cpt[esi]).c_logic,l_alt

	clear	eax
	ret

fn_alt_set_alternate endp




fn_mouse_on	proc

;	switch on the mouse highlighting

;	eax is item to affect

	fetch_compact

	or	(cpt[esi]).c_status,st_mouse

	mov	al,1
	ret

fn_mouse_on	endp




fn_mouse_off	proc

;	switch on the mouse highlighting

;	eax is item to affect

	fetch_compact

	and	(cpt[esi]).c_status,NOT st_mouse

	mov	al,1
	ret

fn_mouse_off	endp




fn_change_name	proc

;	eax is id
;	ebx is new text  number

	fetch_compact
	mov	(cpt[esi]).c_cursor_text,bx
	mov	al,1
	ret

fn_change_name	endp




fn_they_start_sub	proc

;	eax is mega
;	ebx is script number

	fetch_compact

	add	(cpt[esi]).c_mode,4
	movzx	ecx,(cpt[esi]).c_mode
	mov	c_base_sub[esi+ecx],ebx

	mov	al,1
	ret

fn_they_start_sub	endp




fn_set_mega_set	proc

;	eax is mega
;	ebx is set no

	fetch_compact
	imul	ebx,next_mega_set
	mov	(cpt[esi]).c_mega_set,bx

	mov	al,1
	ret


fn_set_mega_set	endp




fn_arrived	proc

;	mega has arrived at a place
;	called by get-to script

;	esi is mega
;	eax is script variable to increment

	mov	(cpt[esi]).c_leaving,ax

	inc	dpt[offset script_variables+eax]

	mov	al,1
	ret


fn_arrived	endp




fn_no_sprites_a6	proc

;	stop the compact printing
;	remove foreground, background and sort

;	eax is is

	fetch_compact
	and	(cpt[esi]).c_status,0fff8h

	mov	al,1
	ret

fn_no_sprites_a6	endp




fn_plot_grid	proc

;	eax = x
;	ebx = y
;	ecx = width

	dec	ecx			;make dbf compatible

	mov	edx,ecx
	mov	ecx,eax
	call	fn_get_grid_values
	je	skip_this
	call	fn_object_to_walk

skip_this:	mov	al,1
	ret

fn_plot_grid	endp




fn_remove_grid	proc

;	eax = x
;	ebx = y
;	ecx = width

	mov	edx,ecx
	mov	ecx,eax
	call	fn_get_grid_values
	je	skip_this
	call	fn_remove_object_from_walk

skip_this:	mov	al,1
	ret

fn_remove_grid	endp




fn_new_background	proc

;	set id eax to background

	fetch_compact
	and	(cpt[esi]).c_status,0fff8h
	or	(cpt[esi]).c_status,st_background

	mov	al,1
	ret

fn_new_background	endp




fn_clear_request	proc

;	target has not responded to sync
;	eax is id of target

	fetch_compact
	mov	(cpt[esi]).c_request,0

	mov	al,1
	ret

fn_clear_request	endp




fn_eyeball	proc

;	set 'result' to frame no. pointing to foster, according to table used
;	eg. FN_eyeball (id_eye_90_table);

	fetch_compact edi		;eye table

	mov	eax,id_blue_foster
	fetch_compact

	movzx	eax,(cpt[esi]).c_xcood	;168 < x < 416
	sub	eax,168
	shr	eax,3

	movzx	ebx,(cpt[esi]).c_ycood	;256 < y < 296
	sub	ebx,256
	shl	ebx,2
	and	ebx,0ffe0h

	add	eax,ebx
	shl	eax,1

	movzx	eax,wpt[eax+edi]		;get frame no
	add	eax,s91
	mov	[result],eax

	mov	al,1
	ret

fn_eyeball	endp




fn_leave_section	proc

ifdef s1_demo
	program_error em_game_over
endif

	cmp	eax,5			;linc section has different mouse cursors
	jne	not_linc

	mov	eax,60301
	call	replace_mouse_cursors

not_linc:	mov	al,1
	ret

fn_leave_section	endp




fn_enter_section	proc

ifdef s1_demo
	cmp	eax,2
	jc	sec_ok
	program_error em_game_over
sec_ok:
endif
	mov	[cur_section],eax

	cmp	eax,5				;section 5 has different mouse icons
	jne	not_linc

	push	eax
	mov	eax,60302
	call	replace_mouse_cursors
	pop	eax

not_linc:	cmp	eax,[current_section]
	je	same_section

	mov	[current_section],eax
	mov	[save_current_section],eax

	inc	eax
	call	load_section_music

	call	load_grids

same_section:	mov	al,1
	ret

fn_enter_section	endp




fn_save_coods	proc

	mov	eax,[tmousex]
	mov	[safex],eax
	mov	eax,[tmousey]
	mov	[safey],eax

	mov	al,1
	ret

fn_save_coods	endp




fn_skip_intro_code proc


;	This is the point at which the game re-starts
;	To get the restart data the game must be saved now, on the final version, however
;	the code must be compatible with the version that saved the game but not do any
;	actual saving
;	The save code must therefore be kept in the final version but disabled

;	This is done by replacing a nop instruction with a ret for the final version


	mov	al,1				;disable escape past intro on all versions
	mov	bpt [past_intro],al

ifdef save_restart_file
	nop					;This nop...
else
	ret					;...will become this ret
endif

	mov	edx,[restart_name_p]
	call	c2_save_game_to_disk				;On final version this call is never reached

	mov	al,1
	ret

fn_skip_intro_code endp




fn_new_swing_seq	proc

;	Only certain files work on pc

	cmp	eax,85
	je	do_seq
	cmp	eax,106
	je	do_seq
	cmp	eax,75
	je	do_seq
	cmp	eax,15
	je	do_seq

	jmp	no_seq

do_seq:	fetch_item
	dec	bpt[esi]

	call	start_timer_sequence

no_seq:	mov	al,1
	ret

fn_new_swing_seq	endp


fn_wait_swing_end	proc

ifndef no_timer
	test	[tseq_frames],-1
	jne	fn_wait_swing_end
else
	mov	[tseq_frames],0
endif
	mov	al,1
	ret

fn_wait_swing_end	endp



anim_sequence	proc

;	esi points to the data

	push	es
	mov	es,[screen_segment]

	clear	eax

	lodsb				;no frames
	mov	ecx,eax
	;dec	ecx

frame_loop:	push	ecx
	clear	edi
	clear	ecx

do_frame:	lodsb				;no to skip
	add	edi,eax
	cmp	al,-1
	je	do_frame

diffy:	lodsb				;no to do
	mov	cl,al
	rep	movsb
	cmp	al,-1
	je	diffy

	cmp	edi,game_screen_height*game_screen_width
	jc	do_frame

	call	stabilise
	clear	eax

	pop	ecx
	floop	ecx,frame_loop

	pop	es	

no_seq::	mov	al,1
	ret

anim_sequence	endp




fn_printf	proc

ifdef debug_42
	printf "fn_printf %d",eax
	call	debug_printf
endif
	mov	al,1
	ret

fn_printf	endp



ifdef debug_42
debug_printf	proc


	pusha
	mov	ebx,70
	call	status_int
	call	debug_loop
	popa
	ret

debug_printf	endp
endif



fn_blank_screen	proc

	call	clear_screen
	mov	al,1
	ret

fn_blank_screen	endp




fn_fetch_x	proc

;	fetch x of compact eax

	fetch_compact
	movzx	eax,(cpt[esi]).c_xcood
	mov	[result],eax

	mov	al,1
	ret

fn_fetch_x	endp




fn_quit_to_dos	proc

	program_error em_game_over

fn_quit_to_dos	endp


end32code

	end
