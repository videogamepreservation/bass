include_macros	equ	1
include_deb_mac	equ	1
include_flags	equ	1
include_scripts	equ	1
include_struc	equ	1
include_error_codes equ	1
include_keyboard_codes equ 1
	include include.asm



start32data
	extrn	past_intro:dword

end32data


start32code
	extrn	int_09_off:dword
	extrn	halve_palette:near
	extrn	double_palette:near


check_keyboard	proc

	call	fetch_key
	je	no_char
ifdef with_screen_saver
	mov	[sssss_count],0
endif
;	If pointer_pen == 42 then we have finished the credits and any key will quit to dos

	cmp	[pointer_pen],42
	jne	not_end_of_credits

kb_game_over:	program_error em_game_over

not_end_of_credits: call	check_cheats
	je	no_char

;--------------------------------------------------------------------------------------------------p - pause

	cmp	ax,'p'
	je	pause
	cmp	ax,'P'
	jne	not_pause

;	pause until we get another key

pause:	call	fn_pause_fx
	call	halve_palette
pause2:	call	fetch_key
	je	pause2
	call	double_palette
ifdef with_screen_saver
	mov	[sssss_count],0
endif
	mov	[bmouse_b],0
	call	fn_un_pause_fx
	jmp	no_char

not_pause:

;--------------------------------------------------------------------------------------------------scroll_lock

	cmp	ax,key_scroll_lock
	jne	not_scroll_lock

	btc	[system_flags],sf_no_scroll
	jmp	no_char


not_scroll_lock:
;--------------------------------------------------------------------------------------------------F - toggle fx_off

	cmp	al,'F'
	jne	not_tog_fx

	call	toggle_fx_kbd

;	btc	[system_flags],sf_fx_off
;	jc	no_char
;
;	clear	eax
;	call	fn_stop_fx
;	mov	eax,1
;	call	fn_stop_fx

	jmp	no_char

not_tog_fx:	cmp	al,'M'
	jne	not_tog_mus
	call	toggle_ms_kbd
	jmp	no_char

not_tog_mus:
;--------------------------------------------------------------------------------------------------escape
	cmp	ax,27
	jne	not_escape

	test	[past_intro],-1
	je	do_restart

	cmp	[screen],85
	je	kb_game_over

ifdef no_keyboard
	program_error em_game_over
endif

	jmp	no_char

do_restart:	call	force_restart
	jmp	no_char

not_escape:	cmp	ax,key_f5
	jne	not_control

;	can't call up control panel when choosing

	bt	[system_flags],sf_choosing
	jc	no_char

	cmp	[screen],82				;don't allow it in final rooms
	jc	control_ok
	cmp	[screen],85
	je	control_ok
	cmp	[screen],90
	jc	no_char
	cmp	[screen],101				;can't save in link terminal as text gets lost
	jnc	no_char
control_ok:

ifdef with_replay
	call	switch_replay_to_record
endif
	call	control_panel
	jmp	no_char

not_control:

ifdef with_replay
	cmp	ax,key_f12				;save mid replay
	jne	not_save_mid_replay

	call	control_panel
	jmp	no_char

not_save_mid_replay:
	cmp	ax,key_f11
	jne	not_replay_restart

	call	force_restart
	jmp	no_char
not_replay_restart:
endif

;--------------------------------------------------------------------------------------------------0-9 (speed keys)

ifndef debug_42
	bt	[system_flags],sf_speed
	jnc	not_speed
endif

	cmp	al,'0'
	jc	not_speed
	cmp	al,'9'+1
	jnc	not_speed

	sub	al,'0'
	movzx	eax,al
	call	set_stabilise
	jmp	no_char

not_speed:

;--------------------------------------------------------------------------------------------------d (debug)
ifdef debug_42

	cmp	ax,key_alt_1							;<alt> 1-0
	jc	not_debug
	cmp	ax,key_alt_3+1		;<alt> 1 = debug walkgrid
	jnc	not_debug		;<alt> 2 = debug scripts
					;<alt> 3 = show walk grid
	sub	ax,key_alt_1
	mov	cl,al
	mov	ebx,1
	shl	ebx,cl
	xor	[_debug_flag],ebx
	jmp	no_char

;--------------------------------------------------------------------------------------------------<alt><F1-12> (debug)
not_debug:	cmp	ax,'m'
	jne	not_marker
	printf "------MARKER-----"
	jmp	no_char

not_marker:	cmp	ax,'t'
	jne	not_tdebug

	call	fn_stop_voc
	jmp	no_char

not_tdebug:

endif ;debug_42

;--------------------------------------------------------------------------------------------------tab + ' ' (replay)
	call	check_replay_key
	jnc	no_char
;not_eq:

;--------------------------------------------------------------------------------------------------v voc control

ifdef with_voc_editor

	bt	[system_flags],sf_sblaster
	jnc	not_voc
	cmp	ax,'v'
	jne	not_voc

	call	_voc_editor__Nv
	jmp	no_char

not_voc:
endif


no_char:	ret


check_keyboard	endp


end32code
start32data

chch	macro char

ifnb <char>
	db	char + 1 - 'a'
else
	db	0
endif
endm

no_cheats	equ	9

cheat_list	dd	version_ch
	dd	speed_ch
	dd	finger_ch
	dd	jammer_ch
	dd	dump_ch
	dd	debug_ch
	dd	room_access_ch
	dd	quick_ch
	dd	testvoice_ch

cheat_pointer	dd	0

;	Cheat texts in alphabetical order
;	NOTE first letter MUST be different for each one


debug_ch	db	0 dup (0)

	chch	'd'
	chch	'e'
	chch	'b'
	chch	'u'
	chch	'g'
	chch
	dd	offset do_debug_show


finger_ch	db	0 dup (0)
	chch	'f'
	chch	'i'
	chch	'n'
	chch	'g'
	chch	'e'
	chch	'r'
	chch
	dd	offset show_fingerprint

dump_ch	db	0 dup (0)
	chch	'g'
	chch	'r'
	chch	'a'
	chch	'b'
	chch	's'
	chch	'c'
	chch	'r'
	chch	'e'
	chch	'e'
	chch	'n'
	chch
	dd	offset do_screen_dump

jammer_ch	db	0 dup (0)
	chch	'j'
	chch	'a'
	chch	'm'
	chch	'm'
	chch	'e'
	chch	'r'
	chch
	dd	offset get_jammer

quick_ch	db	0 dup (0)
	chch	'q'
	chch	'u'
	chch	'i'
	chch	'c'
	chch	'k'
	chch	'c'
	chch	'h'
	chch	'e'
	chch	'a'
	chch	't'
	chch
	dd	offset do_quick_cheat

room_access_ch	db	0 dup (0)
	chch	'r'
	chch	'o'
	chch	'o'
	chch	'm'
	chch	'a'
	chch	'c'
	chch	'c'
	chch	'e'
	chch	's'
	chch	's'
	chch
	dd	offset access_room

speed_ch	db	0 dup (0)
	chch	's'
	chch	'p'
	chch	'e'
	chch	'e'
	chch	'd'
	chch
	dd	offset take_speed

testvoice_ch	db	0 dup (0)
	chch	't'
	chch	'e'
	chch	's'
	chch	't'
	chch	'v'
	chch	'o'
	chch	'i'
	chch	'c'
	chch	'e'
	chch
	dd	offset test_voices


version_ch	db	0 dup (0)
	chch	'v'
	chch	'e'
	chch	'r'
	chch	's'
	chch	'i'
	chch	'o'
	chch	'n'
	chch
	dd	offset show_version


version_sprite	dd	0			;pointer to version or fingerprint sprite (0 if none exists)

version_compact	dw	0,0,0,0,0,0,0
version_x	dw	130
version_y	dw	150
	dw	0
version_v	dw	0

end32data
start32code

check_cheats	proc

;	Check for various cheat modes

	cmp	ax,27
	jnc	no_cheat

	test	[cheat_pointer],-1
	jne	in_cheat

;	Look for a new cheat

	mov	esi,offset cheat_list
	mov	ecx,no_cheats

cheat_loop:	mov	edi,[esi]
	cmp	al,[edi]
	je	start_cheat
	lea	esi,4[esi]
	loop	cheat_loop
	jmp	no_cheat

start_cheat:	;we have the start of a cheat

	inc	edi
	mov	[cheat_pointer],edi
	clear	ax
	ret

in_cheat:	;in the middle of a cheat

	mov	esi,[cheat_pointer]
	cmp	al,[esi]
	jne	no_cheat
	test	bpt 1[esi],-1
	je	got_cheat
	inc	[cheat_pointer]
	clear	al
	ret

got_cheat:	lea	esi,2[esi]
	call	dpt[esi]

no_cheat:	mov	[cheat_pointer],0
	or	al,al
	ret

check_cheats	endp




show_version	proc

;	Show the game version

	mov	esi,offset current_version
	jmp	show_text

show_version	endp




show_fingerprint	proc

	mov	esi,offset finger_print
	jmp	show_text

show_fingerprint	endp




show_text	proc

	test	[version_sprite],-1
	jne	trash_ver

	mov	dl,-1
	mov	cx,100
	clear	ebx
	mov	ebp,1
	call	display_text
	mov	[version_sprite],eax
	mov	[version_v],0

	ret

trash_ver:	mov	eax,[version_sprite]
	call	my_free
	mov	[version_sprite],0
	ret

show_text	endp


cut_off	equ	319	;316

print_version	proc

	test	[version_sprite],-1
	je	no_sprite

	cmp	[version_y],cut_off-1
	jc	falling
	test	[version_v],-1
	je	still

falling:	mov	ax,[version_v]
	add	[version_y],ax
	add	[version_v],1
	cmp	[version_y],cut_off
	jc	still

	mov	ax,cut_off
	sub	ax,[version_y]
	add	ax,cut_off
	mov	[version_y],ax

	movzx	eax,ax

	mov	ax,[version_v]
	shr	ax,1
	neg	ax
	mov	[version_v],ax

still:	movzx	eax,[version_y]
	movzx	eax,[version_v]

	mov	esi,offset version_compact
	mov	edi,[version_sprite]
	call	draw_sprite
	mov	bl,81h
	call	vector_to_game

no_sprite:	ret

print_version	endp




take_speed	proc

	bts	[system_flags],sf_speed
	ret

take_speed	endp




get_jammer	proc

	mov	[got_jammer],42
	mov	[got_sponsor],69
	ret

get_jammer	endp




do_debug_show	proc

	xor	[show_debug_vars],1
	ret

do_debug_show	endp




access_room	proc

;	Alter flags so we have access to certain rooms

	clear	ebx				;room number fingy
	push	ebx

no_char:	call	fetch_key
	je	no_char

	cmp	ax,13				;return accepts
	je	got_room

	pop	ebx
	sub	ax,'0'

	imul	ebx,ebx,10
	add	bx,ax
	push	ebx
	jmp	no_char

got_room:	pop	ebx				;room to get to

	cmp	ebx,11
	je	get_to_computer_room
	cmp	ebx,14
	je	get_to_reactor_section
	cmp	ebx,16
	je	get_to_reactor_section
	cmp	ebx,17
	je	get_to_reactor_section

	cmp	ebx,27
	je	get_to_burke

	ret

get_to_reactor_section:
	mov	[foreman_friend],42		;stop potts from stopping you

	mov	eax,8484				;send sync 1 to rad-suit (put in locker)
	mov	ebx,1
	call	fn_send_sync

	mov	eax,id_anita_spy			;stop anita from getting to you
	call	fn_kill_id

	ret

get_to_burke:	mov	[knows_port],42
	ret

get_to_computer_room:
	mov	[card_status],2
	mov	[card_fix],1
	ret

access_room	endp




do_quick_cheat	proc

	bts	[system_flags],sf_allow_quick
	ret

do_quick_cheat	endp




test_voices	proc

	bt	[system_flags],sf_play_vocs		;check we are able to play voices
	jnc	no_test

	mov	eax,50000				;run through them all

voice_loop:
;ifdef debug_42
;	push	eax
;	call	fn_printf
;	pop	eax
;endif

	push	eax

	bts	[system_flags],sf_speech_file		;enable a load fail
	clear	edx
	call	load_file
	btr	[system_flags],sf_speech_file

	jife	eax,sp_file_missing			;if eax = 0 then no file

	pop	ebx
	push	ebx
	printf "playing %d",ebx

	movzx	ecx,(s ptr[eax]).s_tot_size

	push	eax
	push	ecx
	push	0

	call	_play_voc_data__Npcii
	bts	[system_flags],sf_voc_playing

	call	wait_50hz
	call	wait_50hz
	call	wait_50hz
	call	wait_50hz
	call	wait_50hz
	call	wait_50hz
	call	wait_50hz
	call	wait_50hz

voc_wait:	mov	al,-1
	call	voc_progress_report2
	call	check_keyboard
	call	debug_loop
	bt	[system_flags],sf_voc_playing
	jc	voc_wait

zz:	test	[mouse_b],-1
	je	zz
	call	wait_mouse_not_pressed

sp_file_missing:	pop	eax

	inc	eax
	cmp	eax,60000
	jc	voice_loop

no_test:	ret

test_voices	endp


end32code

	end
