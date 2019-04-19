include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_scripts	equ	1
include_flags	equ	1
include_logic	equ	1
	include include.asm


ifdef with_screen_saver
sssss_time	equ	(1350*50)			;time till game stops if no user input
endif

start32data
	extrn	past_intro:dword

	align 4


logic_table	dd	return
	dd	logic_script			;1  script processor
	dd	logic_auto_route			;2  Make a route
	dd	logic_ar_anim			;3  Follow a route
	dd	logic_ar_turn			;4  Mega turns araound
	dd	logic_alt			;5  Set up new get-to script
	dd	logic_anim			;6  Follow a sequence
	dd	logic_turn			;7  Mega turning
	dd	logic_cursor			;8  id tracks the pointer
	dd	logic_talk			;9  count down and animate
	dd	logic_listen			;10 player waits for talking id
	dd	logic_stopped			;11 wait for id to move
	dd	logic_choose			;12 wait for player to click
	dd	logic_frames			;13 animate just frames
	dd	logic_pause			;14 Count down to 0 and go
	dd	logic_wait_sync			;15 Set to l_script when sync!=0
	dd	logic_simple_anim			;16 Module anim without x,y's


logic_talk_button_release dd 0				;Bodge to cope with amiga bodge

click_table	dw	id_foster
	dw	id_joey
	dw	id_jobs
	dw	id_lamb
	dw	id_anita
	dw	id_son
	dw	id_dad
	dw	id_monitor
	dw	id_shades
	dw	mini_ss
	dw	full_ss
	dw	id_foreman
	dw	id_radman
	dw	id_gallager_bel
	dw	id_burke
	dw	id_body
	dw	id_holo
	dw	id_trevor
	dw	id_anchor
	dw	id_wreck_guard
	dw	id_skorl_guard

;	BASE LEVEL
	dw	id_sc30_henri
	dw	id_sc31_guard
	dw	id_sc32_vincent
	dw	id_sc32_gardener
	dw	id_sc32_buzzer
	dw	id_sc36_babs
	dw	id_sc36_barman
	dw	id_sc36_colston
	dw	id_sc36_gallagher
	dw	id_sc36_jukebox
	dw	id_danielle
	dw	id_sc42_judge
	dw	id_sc42_clerk
	dw	id_sc42_prosecution
	dw	id_sc42_jobsworth

;	UNDERWORLD
	dw	id_medi
	dw	id_witness
	dw	id_gallagher
	dw	id_ken
	dw	id_sc76_android_2
	dw	id_sc76_android_3
	dw	id_sc81_father
	dw	id_sc82_jobsworth

;	LINC WORLD
	dw	id_hologram_b

	dw	12289

	dw	-1

end32data


start32save_data

game_cycle	dd	0

end32save_data



start32code

	extrn	mouse_engine:near
	extrn	auto_route:near
	extrn	remove_object_from_walk:near
	extrn	object_to_walk:near
	extrn	stop_and_wait:near
	extrn	check_keyboard:near
	extrn	logic_cursor:near
	extrn	halve_palette:near
	extrn	double_palette:near
	extrn	fx_control:near
	extrn	print_version:near
ifdef clicking_optional
	extrn	_allow_clicking:dword
endif

;	This is the game loop...

_mainloop__Nv	proc

	mov	[game_50hz_count],0			;clear the frame counter

;	check start up

	mov	esi,offset foster

	cmp	[_start_flag2],1
	jc	no_start2

	mov	[past_intro],1

	je	pc_start_1

	cmp	[_start_flag2],3
	jc	pc_start_2
	je	pc_start_3

	cmp	[_start_flag2],5
	jc	pc_start_4
	je	pc_start_5

	cmp	[_start_flag2],7
	jc	pc_start_6
	je	pc_start_7

	cmp	[_start_flag2],9
	jc	start_8
	jmp	start_9

pc_start_1:	push	esi
	mov	eax,0
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_one
	jmp	start_done

pc_start_2:	push	esi
	mov	eax,1
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_s6
	jmp	start_done

pc_start_3:	push	esi
	mov	eax,2
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_29
	jmp	start_done

pc_start_4:	push	esi
	mov	eax,3
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_sc31
	jmp	start_done

pc_start_5:	push	esi
	mov	eax,4
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_sc66
	jmp	start_done

pc_start_6:	push	esi
	mov	eax,5
	call	fn_enter_section
	pop	esi
	mov	[logic_list_no],it_sc90_logic
	mov	eax,id_blue_foster
	fetch_compact
	mov	(cpt[esi]).c_base_sub,start_sc90
	jmp	start_done

pc_start_7:	push	esi
	mov	eax,0
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_sc81
	jmp	start_done

start_8:	mov	(cpt[esi]).c_base_sub,start_sc37
	jmp	start_done

start_9:	push	esi
	mov	eax,1
	call	fn_enter_section
	pop	esi
	mov	(cpt[esi]).c_base_sub,start_ten
	jmp	start_done

no_start2:
start_done:



mainloop:	inc	[game_cycle]

	call	check_keyboard
	call	mouse_engine
	call	fx_control
	call	logic_engine
	mov	al,-2
	call	voc_progress_report2
	call	noitcetorp_kcehc

	call	check_replay_skip
	jc	skip_replay

	call	re_create
	call	sprite_engine
	call	print_version
ifdef debug_42
	call	flip_grid
endif
	call	flip

skip_replay:	call	debug_loop

	call	check_replay_skip
	jc	mainloop

	call	stabilise

;	Sykes's super sexy screen saver

ifdef with_screen_saver
	cmp	[sssss_count],sssss_time
	jc	no_save

	call	halve_palette
save_wait:	cmp	[sssss_count],sssss_time
	jnc	save_wait
	call	double_palette
endif

no_save:	jmp	mainloop

_mainloop__Nv	endp




logic_engine	proc

	mov	eax,[logic_list_no]		;get correct logic list

new_logic_list:	fetch_compact edi

logic_loop:	movzx	eax,wpt[edi]
	add	edi,2
	jife	ax,le_ret			;0 means end of list

	cmp	ax,-1				;0ffffh means change address
	jne	not_ad_change

;	Change logic data address

	mov	ax,[edi]
	jmp	new_logic_list


;	Process id eax

not_ad_change:	mov	[cur_id],eax
	fetch_compact

;	check the id actually wishes to be processed

	bt	(compact ptr[esi]).c_status,6
	jnc	logic_loop

;	ok, here we process the logic bit system

	push	edi

	bt	(compact ptr[esi]).c_status,7
	jnc	no_grid_required

	call	remove_object_from_walk

no_grid_required:	movzx	eax,(compact ptr[esi]).c_logic

	call	[offset logic_table+eax*4]

	bt	(compact ptr [esi]).c_status,7
	jnc	still_no_grid

	call	object_to_walk

still_no_grid:	mov	(compact ptr[esi]).c_sync,0	;a sync sent to the compact
						;is available for one cycle
						;only. that cycle has just
						;ended so remove the sync.
						;presumably the mega has just
						;reacted to it.

	pop	edi
	jmp	logic_loop			;on to the next one


logic_engine	endp




le_ret:	;awaiting a proc

return:	ret					;a global return



;--------------------------------------------------------------------------------------------------


logic_auto_route	proc

	push	esi				;save compact
	call	auto_route
	mov	edi,esi
	pop	esi				;get compact back

	mov	(cpt[esi]).c_logic,l_script	;continue the script
	cmp	al,1				;route succeeded?
	jne	route_failed
	test	wpt[edi],-1			;zero route?
	je	zero_route

	mov	(cpt[esi]).c_grafix_prog,edi	;put graphic prog in
	mov	(cpt[esi]).c_down_flag,0		;route ok
	jmp	logic_script

route_failed:	mov	(cpt[esi]).c_down_flag,1		;return fail to script
	jmp	logic_script

zero_route:	mov	(cpt[esi]).c_down_flag,2		;return fail to script
	jmp	logic_script

logic_auto_route	endp


;--------------------------------------------------------------------------------------------------

logic_script	proc

;	si is the mega compact
;	Process the current mega's script
;	If the script finishes then drop back a level

	movzx	ebx,(compact ptr [esi]).c_mode	;get pointer to current script
	mov	eax,c_base_sub[ebx+esi]		;get script number and offset
	push	ebx
	call	script
	pop	ebx
	mov	c_base_sub[ebx+esi],eax		;save new offset

	test	eax,0ffff0000h			;if script finished then drop off a mode
	je	script_finish

;	have we gone up a mode? if so then keep processing

	cmp	bx,(cpt[esi]).c_mode
	je	return
	jmp	logic_script


;	ok, drop the sub/mode down a level
;	NB a base script that terminates must handle
;	things itself( FN_idle ) otherwise script mode will
;	continue and the results are unpredictable - presumably
;	this only happens on player base scripts, so use FN_idle followed by FN_quit so script will never end

script_finish:	cherror (cpt[esi]).c_mode,e,0,em_internal_error

	sub	(compact ptr[esi]).c_mode,4
	jmp	logic_script

logic_script	endp




logic_ar_anim	proc

;	Follow a route
;	Mega should be in c_get_to_mode

;	esi is compact

	test	(cpt[esi]).c_xcood,7		;only check collisions on character boundaries
	jne	not_zero_zero
	test	(cpt[esi]).c_ycood,7
	jne	not_zero_zero

;	On character boundary. Have we been told to wait?
;	if not - are WE colliding?

	cmp	(cpt[esi]).c_waiting_for,-1	;1st cycle of re-route does
	je	not_zero_zero			;not require collsion checks

	movzx	eax,(cpt[esi]).c_waiting_for
	jife	eax,not_enforced_stop

;	ok, we've been told we've hit someone
;	we will wait until we are no longer colliding
;	with them. here we check to see if we are (still) colliding.
;	if we are then run the stop script. if not clear the flag
;	and continue.

;	remember - this could be the first ar cycle for some time,
;	we might have been told to wait months ago. if we are
;	waiting for one person then another hits us then
;	c_waiting_for will be replaced by the new mega - this is
;	fine because the later collision will almost certainly
;	take longer to clear than the earlier one.

	call	collide
	je	stop_and_wait

;***

not_colliding:	;we are not in fact hitting this person so clr & continue
	;it must have registered some time ago

	mov	(cpt[esi]).c_waiting_for,0		;clear id flag

not_enforced_stop:	;ok, our turn to check for collisions

	mov	eax,[logic_list_no]

get_new_logic_list: fetch_compact ebx

collision_loop:	flodswl eax,ebx				;get an id
	jife	ax,not_collision			;0 is list end

	cmp	ax,-1			;address change?
	jne	not_skip_forward

	mov	eax,[ebx]			;get new logic list
	jmp	get_new_logic_list

not_skip_forward:	cmp	ax,wpt[cur_id]			;is it us?
	je	collision_loop

	mov	[hit_id],eax			;save target id for any possible c_mini_bump
	fetch_compact edi			;let's have a closer look

	bt	(cpt[edi]).c_status,st_collision_bit ;can it collide?
	jnc	collision_loop

	mov	dx,(cpt[edi]).c_screen		;is it on our screen?
	cmp	dx,(cpt[esi]).c_screen
	jne	collision_loop

;	mov	edx,[flag]			;save the id of target for
;	mov	edx,[cur_id]			;save the id of target for
;	mov	[hit_id],edx			;any possible c_mini_bump

	push	ebx
	call	collide_xx			;check for a hit
	pop	ebx
	jifne	eax,collision_loop

;	ok, we've hit a mega
;	is it moving... or something else?

	cmp	(cpt[edi]).c_logic,l_ar_anim	;check for following route
	je	moving_target

;	it is doing something else
;	we restart our get-to script
;	first tell it to wait for us - in case it starts moving
;	( *it may have already hit us and stopped to wait )

	mov	(cpt[esi]).c_waiting_for,-1	;effect 1 cycle collision skip
	mov	eax,[cur_id]			;tell it it is waiting for us
	mov	(cpt[edi]).c_waiting_for,ax	;(if it's not already)
	movzx	eax,(cpt[esi]).c_mode		;restart current script
	mov	wpt c_base_sub+2[esi+eax],0
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script			;do it right away

moving_target:	;ok, the target is also following ar sequences
	;we have the choice of what to do - wait or re-route

	movzx	eax,(cpt[esi]).c_mini_bump
	jmp	script

;************************

not_collision:	;ok, there was no collisions
	;now check for interaction request
	;*note: the interaction is always set up as an action script

	test	(cpt[esi]).c_request,-1			;anything
	je	check_at

	mov	(cpt[esi]).c_mode,c_action_mode		;put into action mode
	movzx	eax,(cpt[esi]).c_request
	mov	(cpt[esi]).c_action_sub,eax
	mov	(cpt[esi]).c_request,0			;trash request
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

check_at:	;any flag? - or any change?
	;if change then re-run the current script, which must be
	;a position independent get-to		 ----

	test	(cpt[esi]).c_at_watch,-1			;any flag set?
	je	not_zero_zero

;	ok, there is an at watch - see if it's changed

	movzx	eax,(cpt[esi]).c_at_watch
	mov	eax,[offset script_variables+eax]

	cmp	ax,(cpt[esi]).c_at_was			;still the same?
	je	not_zero_zero

;	changed so restart the current script
;	*not suitable for base initiated ARing

	movzx	eax,(cpt[esi]).c_mode
	mov	wpt c_base_sub+2[esi+eax],0
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

not_zero_zero:	;Main animation code

;	check 'at'
;	if the 'at' flag changes then re-run the get-to script

	mov	(cpt[esi]).c_waiting_for,0			;clear possible zero-zero skip

	mov	ebx,(cpt[esi]).c_grafix_prog
	test	wpt[ebx],-1
	jne	run_ar_anim

;	ok, move to new anim segment

	add	ebx,4
	test	wpt[ebx],-1				;end of route?
	jne	not_end_of_ar

;	ok, sequence has finished

	mov	(cpt[esi]).c_ar_anim_index,0		;will start afresh if new sequence continues in last direction
	mov	(cpt[esi]).c_down_flag,0			;pass back ok to script
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

not_end_of_ar:	;ebx is sequence

	mov	(cpt[esi]).c_grafix_prog,ebx
	mov	(cpt[esi]).c_ar_anim_index,0		;reset position

run_ar_anim:	movzx	eax,(cpt[esi]).c_dir			;check direction
	cmp	ax,[ebx+2]
	je	no_turning

;	ok, setup turning

	mov	ax,[ebx+2]
	xchg	ax,(cpt[esi]).c_dir

	mov	cx,20
	mul	cx					;5 tables, 5dwords
	add	ax,(cpt[esi]).c_mega_set			;get correct set
	lea	eax,(cpt[esi+eax]).c_turn_table_up
	movzx	ecx,(cpt[esi]).c_dir
	mov	eax,[eax+ecx*4]
	jife	eax,run_ar_anim
	mov	(cpt[esi]).c_turn_prog,eax			;c_grafix_prog already in use
	mov	(cpt[esi]).c_logic,l_ar_turning
	jmp	logic_ar_turn


no_turning:	shl	eax,2
	add	ax,(cpt[esi]).c_mega_set
	lea	eax,(cpt[esi+eax]).c_anim_up
	mov	edx,[eax]

new_inner_cycle:	movzx	eax,(cpt[esi]).c_ar_anim_index
	test	wpt[eax+edx],-1				;restart the internal anim
	jne	not_recycle

	clear	eax
	mov	(cpt[esi]).c_ar_anim_index,ax		;reset

not_recycle:	add	(cpt[esi]).c_ar_anim_index,s_length
	mov	cx,wpt [s_count+eax+edx]			;reduce the distance to travel
	sub	[ebx],cx
	mov	cx,wpt[s_frame+eax+edx]			;new graphic frame
	mov	(cpt[esi]).c_frame,cx
	mov	cx,wpt[s_ar_x+eax+edx]			;update x coordinate
	add	(cpt[esi]).c_xcood,cx
	mov	cx,wpt[s_ar_y+eax+edx]			;update y coordinate
	add	(cpt[esi]).c_ycood,cx

	ret

logic_ar_anim	endp




logic_ar_turn	proc

	mov	ebx,(cpt[esi]).c_turn_prog
	flodsws ax,ebx
	mov	(cpt[esi]).c_frame,ax
	mov	(cpt[esi]).c_turn_prog,ebx
	test	wpt[ebx],-1				;turn done?
	jne	lat_ret

;	Back to ar mode

	mov	(cpt[esi]).c_ar_anim_index,0
	mov	(cpt[esi]).c_logic,l_ar_anim

lat_ret:	ret

logic_ar_turn	endp




collide	proc

;	are we touching this id	S2(21Sep92tw) & (6Oct92tw)
;	this is mega to mega
;	this routine us customized for each direction a
;	mega may be facing & it takes into account
;	different sizes of mega chr$ - it is therefore very
;	flexible

;	'It's also impossible to visualise how this works'

;	esi is us
;	eax is id to test against

;	On return z=1 for collision

	fetch_compact edi

collide_xx::	movzx	ecx,(cpt[esi]).c_mega_set			;get correct set
	movzx	edx,(cpt[edi]).c_mega_set			;get correct set

	mov	ax,(cpt[edi]).c_xcood			;target's base coordinates
	and	al,0f8h
	mov	bx,(cpt[edi]).c_ycood
	and	bl,0f8h

;	The collision is direction dependant

	cmp	(cpt[esi]).c_dir,1
	jc	col_up
	je	col_down
	cmp	(cpt[esi]).c_dir,2
	je	col_left

;	Facing right

	cmp	bx,(cpt[esi]).c_ycood			;y's must be the same
	jne	no_collision

	sub	ax,(cpt[esi+ecx]).c_last_chr		;last block
	cmp	ax,(cpt[esi]).c_xcood
	je	collision
	sub	ax,8					;out another block
	cmp	ax,(cpt[esi]).c_xcood
	jne	no_collision

collision:	clear	eax
	ret
col_left:	;look left

	cmp	bx,(cpt[esi]).c_ycood			;y's must be the same
	jne	no_collision

	add	ax,(cpt[edi+edx]).c_last_chr
	cmp	ax,(cpt[esi]).c_xcood
	je	collision
	sub	ax,8					;out another one
	cmp	ax,(cpt[esi]).c_xcood
	je	collision

no_collision:	or	al,1
	ret

col_up:	;looking up

	sub	ax,(cpt[esi+ecx]).c_col_offset		;compensate for inner x offsets
	add	ax,(cpt[edi+edx]).c_col_offset

	push	eax					;save their x
	add	ax,(cpt[edi+edx]).c_col_width		;their rightmoast
	cmp	ax,(cpt[esi]).c_xcood
	pop	eax
	jc	no_collision

	sub	ax,(cpt[esi+ecx]).c_col_width		;our left, their right
	cmp	ax,(cpt[esi]).c_xcood
	jnc	no_collision

;	What about y's

	add	bx,8					;bring them down a line
	cmp	bx,(cpt[esi]).c_ycood
	je	collision
	add	bx,8					;bring them down a line
	cmp	bx,(cpt[esi]).c_ycood
	je	collision
	
	or	al,1					;no collision
	ret

col_down:	;down we are a going

	sub	ax,(cpt[esi+ecx]).c_col_offset		;compensate for inner x offsets
	add	ax,(cpt[edi+edx]).c_col_offset

	push	eax					;save their x
	add	ax,(cpt[edi+edx]).c_col_width		;their rightmoast
	cmp	ax,(cpt[esi]).c_xcood
	pop	eax
	jc	no_collision

	sub	ax,(cpt[esi+ecx]).c_col_width		;our left, their right
	cmp	ax,(cpt[esi]).c_xcood
	jnc	no_collision

;	What about y's

	sub	bx,8					;bring them up a line
	cmp	bx,(cpt[esi]).c_ycood
	je	collision
	sub	bx,8					;bring them up a line
	cmp	bx,(cpt[esi]).c_ycood
	je	collision
	
	or	al,1					;no collision
	ret

collide	endp




logic_turn	proc

;	Mega esi turns round and then returns to script mode

	mov	ebx,(cpt[esi]).c_turn_prog
	flodsws ax,ebx
	jife	ax,turn_to_script

	mov	(cpt[esi]).c_frame,ax
	mov	(cpt[esi]).c_turn_prog,ebx
	ret

turn_to_script:	mov	(cpt[esi]).c_ar_anim_index,0
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

logic_turn	endp




logic_frames	proc

;	follow an animation sequence	S2(3Sep92tw)
;	just frames - no coordinates
;	returns to script when no more frames (NULL)
;	returns to script when c_sync != 0

;	esi is compact

	test	(cpt[esi]).c_sync,-1		;what?!
	jne	return_to_script

logic_frames	endp
;	NOWT IN HERE
logic_simple_anim	proc

;	follow an animation sequence module
;	whilst ignoring the coordinate data

	mov	ebx,(cpt[esi]).c_grafix_prog

inr_frm_loop:	test	wpt[ebx],-1				;finished?
	jne	run_simple_seq

return_to_script::	mov	(cpt[esi]).c_down_flag,0			;return 'ok' to script
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

run_simple_seq:	flodsws ax,ebx					;get a command
	cmp	ax,send_sync
	je	frames_sync

	add	ebx,2					;skip coordinates (What??)
	flodsws ax,ebx					;get a frame
	mov	(cpt[esi]).c_grafix_prog,ebx
	cmp	ax,64
	jc	need_item_offset
	mov	(cpt[esi]).c_frame,ax
	ret

need_item_offset:	add	ax,(cpt[esi]).c_offset
	mov	(cpt[esi]).c_frame,ax
	ret

frames_sync:	flodsws ax,ebx					;get id to sync
	fetch_compact edi
	flodsws ax,ebx					;get sync
	mov	(cpt[edi]).c_sync,ax
	jmp	inr_frm_loop

logic_simple_anim	endp




logic_anim	proc

;	Follow an animation sequence
;	esi is compact


	mov	edx,(cpt[esi]).c_grafix_prog
inner_anim_loop:	test	wpt[edx],-1				;all done?
	je	seq_end

	flodsws ax,edx					;get a word
	cmp	ax,lf_start_fx				;check for sync or fx
	je	do_fx
	jnc	do_sync

	mov	(cpt[esi]).c_xcood,ax			;put coordinates and frame in
	flodsws ax,edx
	mov	(cpt[esi]).c_ycood,ax
	flodsws ax,edx
	or	ax,(cpt[esi]).c_offset
	mov	(cpt[esi]).c_frame,ax
	mov	(cpt[esi]).c_grafix_prog,edx
	ret

;	run out of sequence data so return to script

seq_end:	mov	(cpt[esi]).c_down_flag,0
	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

do_sync:	flodsws ax,edx
	fetch_compact edi
	flodsws ax,edx
	mov	(cpt[edi]).c_sync,ax
	jmp	inner_anim_loop

do_fx:	flodswl eax,edx					;get fx number
	flodswl ecx,edx					;volume
	push	esi
	push	edx
	clear	ebx					;channel 0
	call	fn_start_fx
	pop	edx
	pop	esi
	jmp	inner_anim_loop


logic_anim	endp




logic_wait_sync	proc

;	checks c_sync, when its non 0
;	the id is put back into script mode
;	use this instead of loops in the script

	test	(cpt[esi]).c_sync,-1
	je	return

	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

logic_wait_sync	endp




logic_pause	proc

;	keeps decrementing c_flag until it is 0  S2(5Nov92tw)
;	then it restarts script processing
;	I've done this to save the bother of doing
;	little loops everywhere in the scripts

	sub	(cpt[esi]).c_flag,1
	jne	return

	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

logic_pause	endp




logic_listen	proc

;	Stay in this mode until id in c_get_to_flag leaves l_talk mode

	mov	ax,(cpt[esi]).c_flag
	fetch_compact edi

	cmp	(cpt[edi]).c_logic,l_talk
	je	return

	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

logic_listen	endp




logic_talk	proc

;	first count through the frames
;	just frames - nothing tweeky
;	the speech finishes when the timer runs out &
;	not when the animation finishes
;	this routine is very task specific


;	Check for mouse clicking

	call	check_replay_skip
	jnc	no_kill_speech

	bt	[system_flags],sf_voc_playing
	jc	kill_speech

no_kill_speech:

ifdef clicking_optional
	test	[_allow_clicking],-1
	je	cant_click
endif

	test	[mouse_b],-1
	je	release_button
	test	[logic_talk_button_release],-1
	jne	cant_click

	mov	[logic_talk_button_release],1

;	Are we allowed to click

	mov	eax,[cur_id]
	mov	ebx,offset click_table
lt_click_check:	cmp	wpt[ebx],-1
	je	cant_click
	cmp	ax,[ebx]
	je	found_us
	lea	ebx,2[ebx]
	jmp	lt_click_check

found_us:	cmp	(cpt[esi]).c_sp_text_id,-1			;is this a voc file?
	je	kill_speech

	test	(cpt[esi]).c_grafix_prog,-1		;if no anim file just kill text
	je	text_die

	mov	ax,(cpt[esi]).c_get_to_flag		;if anim flag stop it
	mov	(cpt[esi]).c_frame,ax
	jmp	text_die


release_button:
cant_click:	;If speech is allowed then check for it to finish before finishing animations

	bt	[system_flags],sf_play_vocs		;sblaster?
	jnc	no_speech

	cmp	(cpt[esi]).c_sp_text_id,-1			;is this a voc file?
	jne	no_speech

	bt	[system_flags],sf_voc_playing		;finished?
	jc	no_speech				;play anim until it is

speech_die:	mov	(cpt[esi]).c_logic,l_script		;restart character control

	test	(cpt[esi]).c_grafix_prog,-1		;if no anim file then no stand info
	je	logic_script

	movzx	eax,(cpt[esi]).c_get_to_flag		;set character to stand
	mov	(cpt[esi]).c_frame,ax
	mov	(cpt[esi]).c_grafix_prog,0

;	push	esi
;	call	restore_saved_effects_0
;	pop	esi

	jmp	logic_script

kill_speech:	push	esi
	call	fn_stop_voc
	pop	esi

	jmp	speech_die

no_speech:	mov	ebx,(cpt[esi]).c_grafix_prog		;no anim file?
	jife	ebx,past_speech_anim

	test	wpt[ebx],-1				;run out of frames
	je	clean_up_speech

;	we will force the animation to finish 3 game cycles
;	before the speech actually finishes - because it looks good.

	cmp	(cpt[esi]).c_sp_time,3
	jne	not_time_to_stop

	bt	[system_flags],sf_voc_playing		;finished?
	jc	speech_wait				;play anim until it is

;	set up the standing - this code is taken from FN_set_to_stand

clean_up_speech:	movzx	eax,(cpt[esi]).c_get_to_flag
	mov	(cpt[esi]).c_frame,ax
	mov	(cpt[esi]).c_grafix_prog,0
	jmp	past_speech_anim

not_time_to_stop:	movzx	eax,wpt 4[ebx]
	add	ax,(cpt[esi]).c_offset
	mov	(cpt[esi]).c_frame,ax
	add	ebx,6
	mov	(cpt[esi]).c_grafix_prog,ebx

past_speech_anim:	sub	(cpt[esi]).c_sp_time,1
	jne	return

;	ok, speech has finished

	bt	[system_flags],sf_voc_playing		;finished?
	jc	speech_wait				;play anim until it is

text_die:	mov	ax,(cpt[esi]).c_sp_text_id			;get text id to kill
	jife	ax,no_text				;only kill text if it existed
	fetch_compact edi

	mov	(cpt[edi]).c_status,0			;kill the text
no_text:	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

speech_wait:	add	(cpt[esi]).c_sp_time,1
	ret

logic_talk	endp




logic_alt	proc

;	change the current script	S2(7Sep92tw)
;	we do it this way because the alternate script
;	is initiated by a script - but a script can't change
;	itself to another script & keep running in the same cycle

	mov	(cpt[esi]).c_logic,l_script
	movzx	ebx,(cpt[esi]).c_mode
	movzx	edx,(cpt[esi]).c_alt
	mov	c_base_sub[esi+ebx],edx
	jmp	logic_script

logic_alt	endp




logic_stopped	proc

;	waiting for another mega to move or give-up trying
;	c_waiting_for is target	S2(21Sep92tw)
;	check also for idle - if the players re-routing but
;	actually has no further to go then he'll drop down to idle

;	this mode will always be set up from a special script
;	that will be one level higher than the script we
;	would wish to restart from

	movzx	eax,(cpt[esi]).c_waiting_for
	fetch_compact edi

	test	(cpt[edi]).c_mood,-1
	jne	we_are_free

	call	collide_xx
	je	return

we_are_free:	;we are free, continue processing the script

;	we are currently one layer above the script which
;	needs to be restarted - the current stop script
;	should continue to its natural conclusion & drop
;	down to the script below - which will restart

;	*the only reason so far for continuing with the
;	stop script is that the players (std_player_stop)
;	script needs to add the mouse buttons back again

	movzx	eax,(cpt[esi]).c_mode
	sub	eax,4
	mov	wpt c_base_sub+2[esi+eax],0

	mov	(cpt[esi]).c_waiting_for,-1		;ignore first zero zero

	mov	(cpt[esi]).c_logic,l_script
	jmp	logic_script

logic_stopped	endp




logic_choose	proc

;	Remain in this mode until player selects some text

	test	[the_chosen_one],-1
	je	return

	call	fn_no_human				;kill mouse again

	btr	[system_flags],sf_choosing			;restore save/restore

	mov	(cpt[esi]).c_logic,l_script		;and continue script
	jmp	logic_script

logic_choose	endp




end32code

	end
