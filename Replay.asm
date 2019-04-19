include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_flags	equ	1
	include include.asm

ifdef with_replay

;	These routines control the recording and replaying of replay files


rp_mem_block	equ	2000				;size of allocation chumks
mouse_event_size	equ	16				;size of mouse event data

rfn_recording	equ	0				;set when recording
rfn_replaying	equ	1				;set when replaying
rfn_replay_skip_scr equ	2				;skip until next screen change
rfn_replay_skip_cmd equ	3				;skip till next event
rfn_replay_skip_all equ	4				;skip forever
rfn_replay_skip_ms	equ	5				;skip until mouse returns (fn_add_human)

xrfn_skip_mask	equ	3ch

else

rfn_replay_skip_ms	equ	0				;skip until mouse returns (fn_add_human)

xrfn_skip_mask	equ	1h

endif

start32data

replay_flagn	dd	0

ifdef with_replay

replay_f_name	db	"sky.rpl",0
	align	4

replay_handle	dd	0				;handle for replay file

replay_data	dd	0				;pointer to replay data
replay_data_len	dd	?				;amount of data allocated for replay
replay_data_ptr	dd	?				;pointer into data

db_next_cycle	dd	?				;copy of next game cycle for replaying

endif

end32data




start32code

check_replay_skip	proc

ifndef with_replay

	test	[replay_flagn],xrfn_skip_mask
	je	not_skipping

	push	esi
	mov	esi,offset foster
	test	(cpt[esi]).c_logic,-1
	je	stop_skippp
	cmp	[screen],101
	je	stop_skippp
	test	[look_through],-1
	jne	stop_skippp
	cmp	(cpt[esi]).c_logic,12
	jne	not_still
stop_skippp:	btr	[replay_flagn],rfn_replay_skip_ms
not_still:	pop	esi
endif

;	return carry set if we are supposed to be skipping

	test	[replay_flagn],xrfn_skip_mask
	jne	skipping

not_skipping:	clc
	ret

skipping:	stc
	ret

check_replay_skip	endp


check_replay_key	proc

;	space moves on to next event, tab to next room change and '=' until end of replay file
;	'`' stops fast replay

ifdef with_replay
	cmp	al,9
	jne	not_tab
	bts	[replay_flagn],rfn_replay_skip_scr		;skip until next screen change
	jmp	done
not_tab:	cmp	ax,' '
	jne	not_space
	bts	[replay_flagn],rfn_replay_skip_cmd		;skip until next replayed mouse command
	jmp	done
not_space:	cmp	ax,'='
	jne	not_equaals
	bts	[replay_flagn],rfn_replay_skip_all		;skip until further notice
	jmp	done
not_equaals:

else
	bt	[system_flags],sf_allow_quick
	jnc	not_valid
endif

	cmp	ax,96
	jne	not_untab
	and	[replay_flagn],NOT xrfn_skip_mask		;cancel all skips
	jmp	done

not_untab:	cmp	ax,'q'
	jne	not_valid
	bts	[replay_flagn],rfn_replay_skip_ms		;skip until foster is not doing anything or choosing text
	
done:	clc
	ret

not_valid:	stc
	ret

check_replay_key	endp



ifdef with_replay
	extrn	replay_mouse:near


switch_replay_to_record	proc

;	If we are replaying a replay file then switch over to recording

	bt	[replay_flagn],rfn_replaying
	jnc	no_replaying

;	Take the data replayed and rewrite it for record

	push	offset replay_f_name
	call	_open_for_write__Npc

;	mov	ah,3ch					;create a new file
;	clear	ecx
;	mov	edx,offset replay_f_name
;	int	21h
;	jnc	op_ok
;	mov	eax,-1
;op_ok:
	mov	[replay_handle],eax

;	Write out data

	mov	edx,[replay_data]
	mov	ecx,[replay_data_ptr]
	mov	ebx,eax
	mov	ah,40h
	int	21h

	btr	[replay_flagn],rfn_replaying
	bts	[replay_flagn],rfn_recording

	call	increase_replay_space

no_replaying:	ret

switch_replay_to_record	endp




start_up_replay_file	proc

;	Control the replay start up status

	test	[_do_a_replay],-1			;replay or record
	jne	do_replay

;	Open a new replay file for recording
;	If a file is already open we must have loaded a saved game, even if this is just the restart file

	test	[replay_handle],-1
	jne	alrdy_open

	push	offset replay_f_name
	call	_open_for_write__Npc

;	mov	ah,3ch
;	clear	ecx
;	mov	edx,offset replay_f_name
;	int	21h
;	jnc	op_ok
;	mov	eax,-1
;op_ok:
	mov	[replay_handle],eax

;	Allocate data for recording

	mov	eax,rp_mem_block
	call	my_malloc
	mov	[replay_data],eax
	mov	[replay_data_len],rp_mem_block
	mov	[replay_data_ptr],0

alrdy_open:	bts	[replay_flagn],rfn_recording

	ret

do_replay:	;first check if we want to start from a save game

;	push	[replay_flagn]
;	call	control_panel
;	pop	[replay_flagn]

;	open up the replay file, read the data and put it after any loaded from a save game

	push	offset replay_f_name
	call	_open_for_read__Npc

;	mov	ax,3d00h
;	mov	edx,offset replay_f_name
;	int	21h
;	jnc	fopen
;	cherror al,e,al,em_internal_error
;fopen:
	cherror eax,nc,200,em_internal_error
	mov	[replay_handle],eax

;	Find the size of this file

	clear	edx
	clear	ecx
	mov	ebx,eax
	mov	ax,4202h
	int	21h

;	Make room for this file

	add	eax,[replay_data_len]
	push	eax
	call	my_malloc

	mov	esi,[replay_data]
	mov	edi,eax
	mov	[replay_data],eax
	mov	ecx,[replay_data_len]
	rep	movsb
	pop	eax
	xchg	[replay_data_len],eax
	push	eax

;	so load the data

	clear	edx				;file pointer back to 0
	clear	ecx
	mov	ebx,[replay_handle]
	mov	ax,4200h
	int	21h

	mov	edx,[replay_data]
	pop	eax
	add	edx,eax
	mov	ecx,-1
	mov	ah,3fh
	int	21h

	mov	[replay_data_ptr],0		;start from the beginning

	bts	[replay_flagn],rfn_replaying

	ret

start_up_replay_file	endp




replay_changed_screen	proc

;	We have changed screen so stop `skip till change screen'

	btr	[replay_flagn],rfn_replay_skip_scr
	ret

replay_changed_screen	endp




replay_say_something	proc

;	We have changed screen so stop `skip till change screen'

	bt	[replay_flagn],rfn_replay_skip_ms
	ret

replay_say_something	endp




replay_record_event	proc

;	A mouse event has occured, record it

;	eax = mouse x
;	ebx = mouse y
;	ecx = mouse b

	bt	[replay_flagn],rfn_replaying	;no record if in replay
	jc	still_room

	mov	edx,[replay_data]
	add	edx,[replay_data_ptr]		;point to where data is going

	mov	4[edx],eax
	mov	8[edx],ebx
	mov	12[edx],ecx

	mov	eax,[game_cycle]
	mov	[edx],eax

	add	[replay_data_ptr],mouse_event_size

;	write data to file

	mov	ecx,mouse_event_size
	mov	ebx,[replay_handle]
	mov	ah,40h
	int	21h

;	Now check there is room for more events

	mov	eax,[replay_data_ptr]
	add	eax,mouse_event_size
	cmp	eax,[replay_data_len]
	jc	still_room

	call	increase_replay_space

still_room:	ret

replay_record_event	endp




check_replay_mouse	proc

;	We maybe skipping up until foster is waiting or choosing

	mov	esi,offset foster
	test	(cpt[esi]).c_logic,-1
	je	stop_skippp
	cmp	[screen],101
	je	stop_skippp
	test	[look_through],-1
	jne	stop_skippp
	cmp	(cpt[esi]).c_logic,12
	jne	not_still
stop_skippp:	btr	[replay_flagn],rfn_replay_skip_ms
not_still:

;	check if a new mouse state is waiting

	bt	[replay_flagn],rfn_replaying	;no replay if in record
	jnc	no_replay

	mov	edx,[replay_data]			;point to next data
	add	edx,[replay_data_ptr]

	mov	eax,[edx]
	mov	[db_next_cycle],eax

	mov	eax,[game_cycle]			;do we need a new fing
	cmp	eax,[edx]
	jc	no_replay

	mov	eax,4[edx]			;get mouse x

	cmp	eax,-1				;-1 for do control panel
	je	do_control

	cmp	eax,-2				;-2 for get joey coordinates
	je	do_joey

	cmp	eax,-3				;-3 for check random
	je	do_randomm

	cmp	eax,-4
	je	do_stop_voc

	jmp	normal_event

do_control:	;Call up control panel

	mov	ax,96
	call	check_replay_key

	call	control_panel
	jmp	next_event

do_joey:	;set mega coordinates

	mov	eax,8[edx]			;screen
	shr	eax,16
	fetch_compact
	mov	eax,8[edx]			;screen
	mov	(cpt[esi]).c_screen,ax
	mov	eax,12[edx]			;x and y
	mov	(cpt[esi]).c_ycood,ax
	shr	eax,16
	mov	(cpt[esi]).c_xcood,ax
	jmp	spec_done

do_randomm:	mov	eax,8[edx]			;random value
	;cherror eax,ne,[random],em_internal_error
	jmp	spec_done

do_stop_voc:	;voc stopped here

	call	fn_stop_voc
	add	[replay_data_ptr],mouse_event_size

spec_done:	;check we haven't overrun

	add	[replay_data_ptr],mouse_event_size

	mov	edx,[replay_data_ptr]			;check there are more
	cmp	edx,[replay_data_len]
	jnc	replay_fini

	jmp	check_replay_mouse

normal_event:	mov	[tmousex],eax
	sub	eax,top_left_x
	cherror eax,nc,320,em_internal_error
	mov	[amouse_x],eax

	mov	ebx,8[edx]
	mov	[tmousey],ebx
	sub	ebx,top_left_y
	cherror ebx,nc,192,em_internal_error
	mov	[amouse_y],ebx

	mov	ecx,12[edx]
	mov	[emouse_b],ecx

	call	replay_mouse

next_event:	btr	[replay_flagn],rfn_replay_skip_cmd
	add	[replay_data_ptr],mouse_event_size

	mov	edx,[replay_data_ptr]			;check there are more
	cmp	edx,[replay_data_len]
	jc	still_replay

;	Replay file has ended

replay_fini:	call	switch_replay_to_record

	and	[replay_flagn],NOT xrfn_skip_mask		;cancel all skips

	call	control_panel

still_replay:	;mov	eax,[next_mouse_cycle]
	;mov	ebx,7
ifdef debug_42
	;call	status_int
endif

no_replay:	ret

check_replay_mouse	endp




increase_replay_space	proc

;	Do a manual realloc

	add	[replay_data_len],rp_mem_block
	mov	eax,[replay_data_len]
	call	my_malloc

	mov	esi,[replay_data]
	mov	edi,eax
	xchg	[replay_data],eax
	mov	ecx,[replay_data_ptr]
	rep	movsb
	call	my_free

	ret

increase_replay_space	endp




rewrite_replay_file	proc

;	A saved game has been loaded and with it the replay data. Rewrite a new sky.rpl

	mov	ebx,[replay_handle]		;open the file if it isn't already
	jifne	ebx,fopen

	push	offset replay_f_name
	call	_open_for_write__Npc

;	mov	ah,3ch
;	clear	ecx
;	mov	edx,offset replay_f_name
;	int	21h
	mov	[replay_handle],eax
	mov	ebx,eax

fopen:	mov	ax,4200h				;return file pointer to start
	clear	ecx
	clear	edx
	int	21h

	mov	edx,[replay_data]
	mov	ecx,[replay_data_len]
	mov	ah,40h
	int	21h

	ret

rewrite_replay_file	endp

endif

end32code
	end
