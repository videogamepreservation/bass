include_macros	equ	1
include_deb_mac	equ	1
include_flags	equ	1
include_struc	equ	1
include_error_codes equ	1
	include include.asm


c2_cancel_pressed	equ	100					;save cancel key pressed
c2_name_2_short	equ	101					;game name too short
c2_game_saved	equ	102
c2_shifted	equ	103
c2_toggled	equ	104
c2_restarted	equ	105
c2_game_restored	equ	106
c2_restore_failed	equ	107
c2_no_disk_space	equ	108
c2_speed_changed	equ	109

yes_mask	equ	0
no_mask	equ	1


max_save_games	equ	999					;no of games in total
max_text_len	equ	80					;max no of characters (multiple of 4 please)
pan_line_width	equ	184					;width of save game line (pixels)

pan_char_height	equ	12					;character set height

mpnl_x	equ	60
mpnl_y	equ	10

spnl_x	equ	20
spnl_y	equ	20

;	save panel dimensions

sp_height	equ	149
sp_top_gap	equ	12
sp_bot_gap	equ	27

game_name_x	equ	(spnl_x+18)					;x coordinate of game names
game_name_y	equ	(spnl_y+sp_top_gap)				;start y coord of game names
max_on_screen	equ	((sp_height-sp_top_gap-sp_bot_gap)/pan_char_height)	;no of save games on screen


cp_panel	equ	60400					;main panel sprite


c_spr	struc			;structure of a button

sp_add	dd	?					;pointer to pointer to sprite
no_spr	dd	?					;no of sprites in file
c_spr	dd	?					;current sprite
x	dd	?					;x address
y	dd	?					;y address
text	dd	?					;text to display
routine	dd	?					;routine to call if button pressed

c_spr	ends

m_draw_sprite	macro number

;	draw sprite esi with frame number

	mov	(c_spr ptr[esi]).c_spr,number
	push	esi
	clear	ebp
	call	c2_draw_control_sprite2
	pop	esi
endm
	

start32data
	extrn	text_buffer:byte				;data for text mouse pointer
ifdef cmd_options
	extrn	_ignore_saved_game_version:dword
endif


;	Main panel variables

c2_palette_data	dd	?					;pointer to panel palette

;	sprites to load at start


no_init_sprites	equ	10
init_sprite_file	equ	60500

spp_control_panel	dd	?					;pointer to control panel sprite
spp_button	dd	?					;pointer to panel button
spp_dn_btn	dd	?					;pointer to save panel down button
spp_save_panel	dd	?					;pointer to save restore panel sprite
spp_yes_no	dd	?					;pointer to yes/no sprite
spp_slide	dd	?					;pointer to slider sprite
spp_slode	dd	?					;pointer to slider sprite (hd)
spp_slod2	dd	?					;pointer to slider sprite (cd)
spp_slid2	dd	?					;pointer to slider sprite (cd)
spp_music_bdg	dd	?					;sprite to put over music symbol on cd version


sp_control_panel	c_spr	<offset spp_control_panel,1,0,mpnl_x,mpnl_y,0,0>				;the main control panel
sp_exit_btn	c_spr	<offset spp_button,3,0,mpnl_x+16,mpnl_y+125,7000h+50,offset r_exit>		;the exit button
sp_slide	c_spr	<offset spp_slide,1,0,mpnl_x+19,mpnl_y+68,7000h+95,offset c2_slide>		;the speed slider
sp_slid2	c_spr	<offset spp_slid2,1,0,mpnl_x+19,mpnl_y+50+6,7000h+14,offset c2_slide2>		;the music vol slider
sp_slode	c_spr	<offset spp_slode,1,0,mpnl_x+9 ,mpnl_y+49,0,0>

sp_rest_pan_btn	c_spr	<offset spp_button,3,0,mpnl_x+58,mpnl_y+19,7000h+51,offset c2_rest_game_panel>	;the restore button
sp_save_pan_btn	c_spr	<offset spp_button,3,0,mpnl_x+58,mpnl_y+39,7000h+48,offset c2_save_game_panel>	;the save button
sp_dos_pan_btn	c_spr	<offset spp_button,3,0,mpnl_x+58,mpnl_y+59,7000h+93,offset c2_quit_to_dos>	;the quit button
sp_restart_pan_btn	c_spr	<offset spp_button,3,0,mpnl_x+58,mpnl_y+79,7000h+94,offset c2_restart>		;the restart button
sp_fx_pan_btn	c_spr	<offset spp_button,3,2,mpnl_x+58,mpnl_y+99,7000h+90,offset toggle_fx>		;the fx button
sp_ms_pan_btn	c_spr	<offset spp_button,3,2,mpnl_x+58,mpnl_y+119,7000h+91,offset toggle_ms>		;the music button

sp_bodge	c_spr	<offset spp_music_bdg,2,0,mpnl_x+98,mpnl_y+115,0,0>				;the music bodge


sp_yes_no	c_spr	<offset spp_yes_no,1,0,mpnl_x-2,mpnl_y+40,0,0>				;yes / no panel

sp_ctext	c_spr	<offset spp_ctext,1,0,mpnl_x+15,mpnl_y+137,0,0>				;Some text
spp_ctext	dd	0

;	list of sprites to check for mouse over / mouse click, main panel

cp_look_list_no	equ	8

cp_look_list	dd	offset sp_exit_btn
	dd	offset sp_rest_pan_btn
	dd	offset sp_save_pan_btn
	dd	offset sp_dos_pan_btn
	dd	offset sp_restart_pan_btn
	dd	offset sp_fx_pan_btn
	dd	offset sp_ms_pan_btn
	dd	offset sp_slide
	dd	offset sp_slid2


;	save game variables


sp_save_panel	c_spr	<offset spp_save_panel,1,0,spnl_x,spnl_y,0,0>	;the save panel sprite

sp_look_list_no	equ	6					;buttons to check

sp_look_list	dd	offset sp_save_btn	;\ save panel
rp_look_list	dd	offset sp_dn_btn		;| \ restore panel
	dd	offset sp_dn_btn2		;| |
	dd	offset sp_up_btn		;| |
	dd	offset sp_up_btn2		;| |
	dd	offset sp_quit_btn	;/ :
	dd	offset sp_rest_btn	;  /

sp_save_btn	c_spr	<offset spp_button,3,0,spnl_x+29,spnl_y+129,7000h+48,c2_save_a_game>	;save a real game

sp_dn_btn	c_spr	<offset spp_dn_btn,1,0,spnl_x+212,spnl_y+104,0,c2_shift_down_fast>	;shift games down
sp_dn_btn2	c_spr	<offset spp_dn_btn,1,0,spnl_x+212,spnl_y+114,0,c2_shift_down_slow>	;shift games down
sp_up_btn	c_spr	<offset spp_dn_btn,1,0,spnl_x+212,spnl_y+21,0,c2_shift_up_fast>	;shift games up
sp_up_btn2	c_spr	<offset spp_dn_btn,1,0,spnl_x+212,spnl_y+10,0,c2_shift_up_slow>	;shift games up

sp_quit_btn	c_spr	<offset spp_button,3,0,spnl_x+72,spnl_y+129,7000h+49,offset c2_sp_cancel>

sp_rest_btn	c_spr	<offset spp_button,3,0,spnl_x+29,spnl_y+129,7000h+51,c2_restore_a_game>	;restore a real game

init_text	dd	0

restore_fx_flag	dd	?			;set this if we want to restart fx when we leave the panel

character_list	db	" ,().='-&  +!?"		;list of valid characters
	db	'"',0

	align 4


;	Slider variables

panel_int	dd	0			;set this when panel first run

sl_sp_top_y	dd	(mpnl_y + 52)		;speed slider top y
sl_sp_bot_y	dd	(mpnl_y + 92)		;speed slider bottom y
sl_sp_range	dd	(mpnl_y + 92)-(mpnl_y + 52)
sl_sp_devidor	dd	4			;step size

sl_ms_top_y	dd	(mpnl_y + 49)		;volume slider top y
sl_ms_bot_y	dd	(mpnl_y + 81)		;volume slider bottom y
sl_ms_range	dd	(mpnl_y + 81)-(mpnl_y + 49)

music_volume	dd	27	;31			;music volume multiplier

end32data


start32save_data

saved_char_set	dd	?

save_mouse_type	dd	0
save_m_off_x	dd	0
save_m_off_y	dd	0

end32save_data


start32code


control_panel	proc

ifdef s1_demo
	ret
endif


	test	[panel_int],-1				;only do this once
	jne	not_sb

;	Change some things for the cd/sblaster version

	bt	[system_flags],sf_sblaster	;sblaster only
	jnc	not_sb

	mov	(c_spr ptr[sp_slode]).sp_add,offset spp_slod2
	mov	(c_spr ptr[sp_slide]).sp_add,offset spp_slid2

	mov	(c_spr ptr[sp_slide]).y,(mpnl_y + 99)
	mov	[sl_sp_top_y],(mpnl_y + 95)		;speed slider top y
	mov	[sl_sp_bot_y],(mpnl_y + 105)		;speed slider bottom y
	mov	[sl_sp_range],(mpnl_y + 105)-(mpnl_y + 95)
	mov	[sl_sp_devidor],1

	test	[_cd_version],-1
	je	not_cd

	mov	(c_spr ptr[sp_ms_pan_btn]).c_spr,0
	mov	(c_spr ptr[sp_ms_pan_btn]).text,35+7000h
	mov	(c_spr ptr[sp_bodge]).c_spr,1

not_cd:	mov	[panel_int],1

not_sb:	call	set_up_control_panel_data

;	Now print out the main control panel

new_control_panel:	call	flush_key_buffer
	call	remove_mouse
	call	clear_screen

	mov	esi,offset sp_control_panel
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_exit_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_save_pan_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_rest_pan_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_dos_pan_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_restart_pan_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_fx_pan_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_ms_pan_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_slode
	mov	ebp,yes_mask
	printf "1"
	call	c2_draw_control_sprite2
	mov	esi,offset sp_slide
	mov	ebp,yes_mask
	printf "2"
	call	c2_draw_control_sprite2
	mov	esi,offset sp_bodge
	mov	ebp,yes_mask
	printf "3"
	call	c2_draw_control_sprite2
	printf "4"

	bt	[system_flags],sf_sblaster	;sblaster only
	jnc	not_cd2

	mov	esi,offset sp_slid2
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2

not_cd2:	mov	eax,[init_text]
	jife	eax,no_init_text

	call	control_text
	mov	[init_text],0

no_init_text:	btr	[mouse_flag],mf_no_update
	call	fn_normal_mouse

;	Loop round looking for something to do

control_loop:	mov	esi,offset cp_look_list
	mov	ecx,cp_look_list_no

	;test	[_cd_version],-1				;xtra slide in cd + sblaster combination
	;je	look_loop
	bt	[system_flags],sf_sblaster
	jnc	look_loop

	inc	ecx

look_loop:	push	esi
	mov	esi,[esi]
	call	c2_check_for_hit
	pop	esi
	je	btn_hit
	lea	esi,4[esi]
	loop	look_loop

;	No buttons

	call	c2_restore_button_screen			;restore screen under button text
	mov	[bmouse_b],0

control_key:	call	fetch_key
	je	control_loop

	cmp	ax,27
	je	r_exit2
	cmp	ax,13
	je	r_exit2

	jmp	control_loop

btn_hit:	;The mouse is over a button, we must print up some text

	mov	esi,[esi]
	call	c2_button_control
	test	[mouse_b],-1
	je	control_key

	call	c2_kill_button

	call	(c_spr ptr[esi]).routine

;	Check return value

	cmp	eax,c2_cancel_pressed
	je	new_control_panel

	cmp	eax,c2_toggled
	je	control_loop

	cmp	eax,c2_speed_changed
	je	control_loop

	cmp	eax,c2_game_saved
	je	r_exit2

	cmp	eax,c2_game_restored
	je	r_exit2

	cmp	eax,c2_restarted
	je	r_exit2

	jmp	new_control_panel


;	End control panel

r_exit::	pop	eax				;trash return address

	m_draw_sprite 2				;press button
	mov	(c_spr ptr[esi]).c_spr,0

r_exit2:	call	disinstall_control_panel

;	Check if we must restart any sound fx

	test	[restore_fx_flag],-1
	je	no_rst_fx
	
	call	restore_saved_effects_0		;restore any constant sound fx

no_rst_fx:	ret

control_panel	endp




toggle_fx_kbd	proc

;	Called from keyboard so no control data has been set up

	mov	esi,offset sp_fx_pan_btn
	xor	(c_spr ptr[esi]).c_spr,2

	btc	[system_flags],sf_fx_off
	jc	was_off

	clear	eax
	call	fn_suspend_fx
	mov	eax,1
	call	fn_suspend_fx

	ret

was_off:	call	restore_saved_effects_0		;restore any constant sound fx
	call	restore_saved_effects_1		;restore any constant sound fx
	ret

toggle_fx_kbd	endp



toggle_fx	proc

	push	esi

	call	remove_mouse

	pop	esi
	xor	(c_spr ptr[esi]).c_spr,2
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	btc	[system_flags],sf_fx_off
	jc	was_off

;	Turn fx off

	clear	eax
	call	fn_suspend_fx
	mov	eax,1
	call	fn_suspend_fx

	mov	[restore_fx_flag],0			;don't restart them when we leave

	mov	eax,7000h+87				;text for fx off
	jmp	was_on

was_off:	mov	[restore_fx_flag],1			;restart fx when we leave
	mov	eax,7000h+86				;text for fx on

was_on:	call	control_text


	call	restore_mouse

	call	wait_mouse_not_pressed

	mov	eax,c2_toggled
	ret

toggle_fx	endp





toggle_ms_kbd	proc

;	Called from keyboard so no control data has been set up

	mov	esi,offset sp_ms_pan_btn
	xor	(c_spr ptr[esi]).c_spr,2

	btc	[system_flags],sf_mus_off
	jc	was_off

	call	stop_music
	ret

was_off:	call	restart_current_music
	ret

toggle_ms_kbd	endp





toggle_ms	proc

	test	[_cd_version],-1
	je	not_cd

;	flip between text, speech and text&speech
;	35	21	52

ifndef american_cd
	cmp	(c_spr ptr[esi]).text,35+7000h
	je	was_text_only
endif
	cmp	(c_spr ptr[esi]).text,21+7000h
	je	was_speech_only

;	text only to text and speech to speech only

	bts	[system_flags],sf_allow_speech
	mov	eax,21+7000h
	jmp	cgot

was_text_only:	;speech only to text only to speech and text

	bts	[system_flags],sf_allow_text
	btr	[system_flags],sf_allow_speech
	mov	eax,52+7000h
	jmp	cgot

was_speech_only:	;text and speech to speech only to text only

	btr	[system_flags],sf_allow_text
	mov	eax,35+7000h

cgot:	xchg	(c_spr ptr[esi]).text,eax

	push	esi
	call	control_text
	pop	esi
	call	c2_depress_button_2			;wait until mouse released

	mov	eax,c2_toggled
	ret

cdun:	mov	(c_spr ptr[esi]).text,eax

not_cd:	push	esi

	call	remove_mouse

	btc	[system_flags],sf_mus_off
	jc	was_off
	call	stop_music
	mov	eax,7000h+89
	jmp	was_on
was_off:	call	restart_current_music
	mov	eax,7000h+88

was_on:	call	control_text
	pop	esi

	xor	(c_spr ptr[esi]).c_spr,2
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	call	restore_mouse

	call	wait_mouse_not_pressed

	mov	eax,c2_toggled
	ret

toggle_ms	endp




control_text	proc

;	Draw up some text on the screen
;	Do text eax

	push	eax
	mov	eax,[spp_ctext]
	jife	eax,no_free
	call	my_free
no_free:	pop	eax

;	Now do the text

	call	get_text

	mov	dl,-1
	mov	ecx,140
	clear	ebx
	mov	esi,offset text_buffer
	mov	ebp,1

	call	display_text
	mov	[spp_ctext],eax

	push	es
	mov	es,[screen_segment]

	mov	edi,163*320 + 66
	lea	esi,SIZE s[eax]

	movzx	ebx,(s ptr[eax]).s_width
	movzx	edx,(s ptr[eax]).s_height

	add	esi,ebx
	sub	edx,2

ct_ylop:	mov	ecx,ebx
	push	edi
ct_xlop:	lodsb
	jifne	al,not0
	mov	al,34
not0:	stosb
	floop	ecx,ct_xlop
	pop	edi
	lea	edi,320[edi]
	floop	edx,ct_ylop

	pop	es

	ret

control_text	endp




set_up_control_panel_data proc

;	First save the current mouse status

	call	fn_pause_fx

	mov	eax,[mouse_type2]
	mov	[save_mouse_type],eax
	mov	eax,[mouse_offset_x]
	mov	[save_m_off_x],eax
	mov	eax,[mouse_offset_y]
	mov	[save_m_off_y],eax

	call	fn_disk_mouse

	mov	eax,60510				;load in the palette
	clear	edx
	call	load_file
	mov	[c2_palette_data],eax

	mov	eax,[cur_char_set]				;save current character set
	mov	[saved_char_set],eax

;	load in the character set

	mov	eax,2
	call	fn_set_font

;	Load in the essential sprites

	mov	eax,init_sprite_file
	mov	ecx,no_init_sprites
	mov	edi,offset spp_control_panel

init_load_loop:	push	eax
	push	ecx
	push	edi
	clear	edx
	call	load_file
	pop	edi
	stosd
	pop	ecx
	pop	eax
	inc	eax
	loop	init_load_loop

	call	remove_mouse
	call	clear_screen

	mov	esi,[c2_palette_data]
	call	set_palette

;	Set up some memory locations

	mov	eax,max_save_games*max_text_len
	call	my_malloc
	mov	[c2_save_game_texts],eax

	ret

set_up_control_panel_data endp




disinstall_control_panel	proc

;	free up the memory we used

	call	remove_mouse

r_exit2:	mov	eax,[c2_palette_data]
	call	my_free
ifdef mem_check
	mov	[c2_palette_data],0
endif

	mov	esi,offset spp_control_panel			;free panel sprites
	mov	ecx,no_init_sprites
free_loop1:	lodsd
ifdef mem_check
	mov	dpt[esi-4],0
endif
	push	esi
	push	ecx
	call	my_free
	pop	ecx
	pop	esi
	loop	free_loop1

	mov	eax,[c2_save_game_texts]
	call	my_free
ifdef mem_check
	mov	[c2_save_game_texts],0				;for checking it was freed]
endif

	mov	esi,offset c2_text_sprites				;free saved game sprites
	mov	ecx,max_on_screen
free_loop91:	clear	eax
	xchg	eax,[esi]
	jife	eax,no_91
	push	esi
	push	ecx
	call	my_free
	pop	ecx
	pop	esi
	lea	esi,4[esi]
no_91:	loop	free_loop91

	mov	eax,[c2_edit_sprite]
	jife	eax,no_espr
	call	my_free
	mov	[c2_edit_sprite],0

no_espr:	call	fn_force_refresh
	mov	[bmouse_b],0

	mov	eax,[saved_char_set]
	call	fn_set_font

	call	wait_mouse_not_pressed
	call	clear_screen

	mov	eax,[current_palette]
	call	fn_set_palette

	call	restore_mouse

;	restore mouse data

	mov	eax,[save_mouse_type]

	mov	ebx,[save_m_off_x]
	mov	[mouse_offset_x],ebx
	mov	ecx,[save_m_off_y]
	mov	[mouse_offset_y],ecx

;	If mouse type == 0 we have an object fing

	jife	eax,obj_mouse
	call	sprite_mouse
	jmp	mouse_done
obj_mouse:	call	fn_close_hand
mouse_done:

	call	flush_key_buffer

	call	fn_un_pause_fx

	ret

disinstall_control_panel	endp



restore_a_game_from_disk	proc

;	edx points to name of file to load

	push	edx
	call	_open_for_read__Npc
	or	eax,eax
	js	no_restore

;	mov	ax,3d00h					;open the file
;	clear	ecx
;	dos_int
;	jc	no_restore

;	cause an error if versions changed

	push	eax
	clear	eax
	call	fn_stop_fx
	mov	eax,1
	call	fn_stop_fx
	call	fn_flush_buffers
	pop	ebx

	mov	edx,offset start_of_save_data		;read the data length
	mov	ecx,4
	mov	ah,3fh
	int	21h
	jc	restore_error

	mov	edx,offset start_of_save_data + 4		;read the data
	mov	ecx,[start_of_save_data]

	mov	eax,offset end_of_save_data		;check sizes are the same
	sub	eax,offset start_of_save_data
	cmp	eax,ecx
	je	gamok

	program_error em_invalid_save

gamok:	sub	ecx,4
	mov	ah,3fh
	int	21h
	jc	restore_error

;	Now read the saved games replay data
ifdef with_replay
	bt	[system_flags],sf_replay_rst
	jc	no_rep_lod

	mov	edx,offset start_of_save_data		;read the data length
	mov	ecx,4
	mov	ah,3fh
	int	21h
	jc	restore_error

	mov	eax,[start_of_save_data]
	mov	[replay_data_len],eax
	mov	[replay_data_ptr],eax
	push	ebx
	add	eax,40					;play safe
	call	my_malloc
	pop	ebx

	mov	[replay_data],eax
	mov	edx,eax
	mov	ecx,[start_of_save_data]
	mov	ah,3fh
	int	21h
no_rep_lod:
endif
	mov	ah,3eh					;and close the file
	int	21h

ifdef with_replay
	bt	[system_flags],sf_replay_rst
	jc	no_rep_lod2
	call	rewrite_replay_file			;new replay file
no_rep_lod2:
endif

	call	load_grids			;reload fresh grids

	call	restore_file_lists

	call	fn_text_kill2

ifndef s1_demo
	mov	eax,[current_section]
	call	fn_leave_section
endif

	mov	eax,[save_current_section]
	call	fn_enter_section

	mov	eax,[saved_current_music]
	call	fn_start_music

	call	restore_saved_effects_0		;restore any constant sound fx
	call	restore_saved_effects_1		;restore any constant sound fx

	mov	eax,c2_game_restored

	bts	[system_flags],sf_game_restored

	ret

no_restore:	mov	eax,c2_restore_failed
	ret

restore_error:	program_error em_disk_rd_error

restore_a_game_from_disk	endp




force_restart	proc

	bts	[system_flags],sf_replay_rst

	call	fn_fade_down

	mov	edx,[restart_name_p]
	call	restore_a_game_from_disk
	call	fn_force_refresh
	call	re_create
	call	sprite_engine
	call	flip

	clear	eax				;ensure module 0 and 1 in
	call	check_module_loaded
	mov	eax,1
	call	check_module_loaded

	mov	eax,[current_palette]
	call	fn_fade_up

	bts	[system_flags],sf_game_restored
	btr	[system_flags],sf_replay_rst

	ret

force_restart	endp




fn_restore_game	proc

ifdef s1_demo
	ret
endif

	call	set_up_control_panel_data
	call	fn_normal_mouse
	clear	esi					;no button to push
	call	c2_rest_game_panel
	call	disinstall_control_panel

	clear	eax
	ret

fn_restore_game	endp




fn_restart_game	proc

	call	force_restart
	clear	eax
	ret

fn_restart_game	endp


end32code

;--------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------


start32data

c2_save_game_texts	dd	?				;Pointer to game numbers and text stored here
c2_text_sprites	dd	max_on_screen dup (0)		;pointers to the text sprites
c2_text_c_spr	c_spr	<0,1,0,game_name_x,0>		;c_spr for displaying texts

c2_desc_file	dd	?				;file handle of description files
c2_desc_temp	dd	?				;temporary store for loading description file
c2_desc_size	dd	?				;size of desc file

c2_cur_button	dd	?				;mouse is over this button
c2_cur_but_textn	dd	0				;text for current button
c2_cur_but_text_sp	dd	0				;pointer to button text sprite
c2_button_screen	c_spr	<offset c2_cur_but_text_sp,1,0,0,0>

c2_button_save_dat	dd	?
c2_button_save_adr	dd	?
c2_button_save_wid	dd	?
c2_button_save_hig	dd	?

c2_game_on_top	dd	0				;game number on top of list

c2_edit_game	dd	0				;no of game selected
c2_edit_text	db	max_text_len dup (?)		;text being edited
c2_edit_cursor	dd	?				;location of cursor
c2_edit_sprite	dd	0				;pointer to text being edited
c2_edit_width	dd	?				;width of line in editor buffer (pixels)
c2_allow_edit	dd	?				;set if we can edit text


end32data

start32code

c2_load_save_descriptions proc


;	Set up blank numbers for the save game texts
	
	mov	ecx,max_save_games
	mov	ebx,312020h			;convoluted game counter

	mov	eax,[c2_save_game_texts]

aloc_loop:	mov	[eax],ebx			;put game number in, followed by
	mov	dpt 3[eax],203ah			; ': '

;	Increment counter

	add	ebx,10000h			;units
	cmp	ebx,3a0000h
	jc	count_inced

	and	ebx,0ffffh
	cmp	bh,' '				;tens
	jne	not_ten_sp
	mov	bh,'0'
not_ten_sp:	add	ebx,300100h
	cmp	bh,'9'+1
	jc	count_inced

	cmp	bl,' '				;hundreds
	jne	not_ton_sp
	mov	bl,'0'
not_ton_sp:	mov	bh,'0'
	inc	bl

count_inced:	add	eax,max_text_len
	loop	aloc_loop

;	Load in the file containing the file descriptions

	push	[save_game_text_file]
	call	_open_for_read__Npc
	or	eax,eax
	js	no_file

;	mov	ax,3d00h
;	mov	edx,[save_game_text_file3]
;	int	21h
;	jc	no_file

;	The file exists so load it all in

	mov	[c2_desc_file],eax		;save file handle

	clear	edx				;get file size
	clear	ecx
	mov	ebx,eax
	mov	ax,4202h
	dos_int

	shl	edx,16				;allocate memory
	movzx	eax,ax
	or	eax,edx
	mov	[c2_desc_size],eax
	call	my_malloc
	mov	[c2_desc_temp],eax

	mov	ax,4200h				;return file to beginning
	mov	ebx,[c2_desc_file]
	clear	ecx
	clear	edx
	dos_int

	mov	ah,3fh				;read in the data
	mov	ecx,[c2_desc_size]
	mov	edx,[c2_desc_temp]
	dos_int

	mov	ah,3eh				;and close the file
	dos_int

;	Convert the data into a more useable form

	mov	esi,[c2_desc_temp]

	lodsd					;check the versions are ok
ifdef cmd_options
	test	[_ignore_saved_game_version],-1	;command line flag
	jne	sg_ver_ok
endif
	cmp	eax,dpt[replay_version]
	jne	invalid_save_data

sg_ver_ok:	mov	edi,[c2_save_game_texts]
	lea	edi,5[edi]			;skip numbers
	mov	ecx,max_save_games

tran_loop2:	push	edi
tran_loop:	lodsb
	stosb
	jifne	al,tran_loop
	pop	edi
	lea	edi,max_text_len[edi]
	loop	tran_loop2

;	Savegame details present and correct, Sah!

invalid_save_data:	mov	eax,[c2_desc_temp]
	call	my_free

no_file:	ret

c2_load_save_descriptions endp




c2_button_control	proc

;	Mouse is over button esi, handle any text that is needed

	push	esi

	mov	[c2_cur_button],esi

	mov	eax,(c_spr ptr[esi]).text			;get button text
	jife	eax,no_new_stuff				;are we going to print any?
	cmp	eax,[c2_cur_but_textn]			;is it same as last lot
	je	just_move

no_new_stuff:	test	[c2_cur_but_textn],-1			;have we old stuff that needs removing
	je	no_old_stuff
	push	esi
	call	c2_restore_button_screen			;restore screen under button text
	mov	eax,[c2_cur_but_text_sp]
	call	my_free
	mov	[c2_cur_but_text_sp],0
	pop	esi

no_old_stuff:	mov	eax,(c_spr ptr[esi]).text			;get button text
	mov	[c2_cur_but_textn],eax
	jife	eax,no_button_text

	call	get_text
	mov	dl,-1
	mov	ecx,pan_line_width
	clear	ebx
	mov	esi,offset text_buffer
	clear	ebp					;no centering
	call	display_text
	mov	[c2_cur_but_text_sp],eax

	jmp	draw_first_button

just_move:	;see if the button wants moving

	mov	eax,[amouse_x]
	add	eax,12
	cmp	eax,[c2_button_screen.x]
	jne	yes_move

	mov	eax,[amouse_y]
	sub	eax,16
	cmp	eax,[c2_button_screen.y]
	je	no_move

yes_move:	call	c2_restore_button_screen

draw_first_button:	mov	eax,[amouse_x]
	add	eax,12
	mov	[c2_button_screen.x],eax
	mov	eax,[amouse_y]
	sub	eax,16
	mov	[c2_button_screen.y],eax

	call	c2_save_button_screen

	mov	esi,offset c2_button_screen
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2

no_move:
no_button_text:	pop	esi
	ret


c2_button_control	endp



c2_kill_button	proc

;	Text for a button has been finished with

	push	esi

	mov	eax,[c2_cur_but_text_sp]
	jife	eax,no_bspr
	call	my_free
	mov	[c2_cur_but_text_sp],0

no_bspr:	mov	[c2_cur_but_textn],0

	call	c2_restore_button_screen			;restore screen under button text

	pop	esi

	ret

c2_kill_button	endp



c2_save_button_screen	proc

;	Save the screen data under the button text

	call	remove_mouse

	mov	esi,offset c2_button_screen		;set up save sprite
	mov	ebx,(c_spr ptr[esi]).sp_add
	mov	ebx,[ebx]

	mov	eax,(c_spr ptr[esi]).y
	imul	eax,320
	add	eax,(c_spr ptr[esi]).x
	mov	[c2_button_save_adr],eax

	movzx	eax,(s ptr[ebx]).s_width
	mov	[c2_button_save_wid],eax
	movzx	ecx,(s ptr[ebx]).s_height
	mov	[c2_button_save_hig],ecx
	imul	eax,ecx
	call	my_malloc
	mov	[c2_button_save_dat],eax

;	Save the data

	mov	edi,eax
	mov	esi,[c2_button_save_adr]
	mov	ebx,[c2_button_save_wid]
	mov	edx,[c2_button_save_hig]

	push	ds
	mov	ds,[screen_segment]

save_loop_y:	push	esi
	mov	ecx,ebx
	rep	movsb
	pop	esi
	lea	esi,320[esi]
	floop	edx,save_loop_y

	pop	ds

	call	restore_mouse

	ret

c2_save_button_screen	endp


c2_restore_button_screen	proc

;	Restore the data under the button text

	test	[c2_button_save_dat],-1
	je	nowt_2_rest

	push	esi

	call	remove_mouse

	mov	es,[screen_segment]
	mov	esi,[c2_button_save_dat]
	mov	edi,[c2_button_save_adr]
	mov	ebx,[c2_button_save_wid]
	mov	edx,[c2_button_save_hig]

rb_loop:	push	edi
	mov	ecx,ebx
	rep	movsb
	pop	edi
	lea	edi,320[edi]
	floop	edx,rb_loop

	push	ds
	pop	es

	call	restore_mouse

	mov	eax,[c2_button_save_dat]
	call	my_free
	mov	[c2_button_save_dat],0

	pop	esi

nowt_2_rest:	ret

c2_restore_button_screen	endp




c2_check_for_hit	proc

;	check if the mouse is over a sprite
;	Return z=1 for hit, z=0 for no hit

;	esi points to sprite structure

	push	ecx

	mov	edi,(c_spr ptr[esi]).sp_add		;get pointer to sprite data
	mov	edi,[edi]

	mov	eax,(c_spr ptr[esi]).x			;check x
	cmp	[amouse_x],eax
	jc	no_hit

	add	ax,(s ptr[edi]).s_width
	cmp	eax,[amouse_x]
	jc	no_hit

	mov	eax,(c_spr ptr[esi]).y			;check y
	cmp	[amouse_y],eax
	jc	no_hit

	add	ax,(s ptr[edi]).s_height
	cmp	eax,[amouse_y]
	jc	no_hit

;	we have a hit

	clear	eax
	pop	ecx
	ret

no_hit:	or	al,1
	pop	ecx
	ret

c2_check_for_hit	endp




c2_draw_control_sprite2	proc

;	Draw a control sprite to the screen

;	esi points to the sprite information
;	ebp = 0	Mask sprite over current screen
;	ebp = 1	Overwrite screen contents

	push	es
	mov	es,[screen_segment]

	mov	edi,(c_spr ptr[esi]).y			;calculate screen position
	imul	edi,full_screen_width
	add	edi,(c_spr ptr[esi]).x

	mov	eax,(c_spr ptr[esi]).c_spr			;get current sprite number

	mov	esi,(c_spr ptr[esi]).sp_add		;get pointer to sprite data
	mov	esi,[esi]

	movzx	ebx,(s ptr[esi]).s_width			;get sprite dimensions
	movzx	edx,(s ptr[esi]).s_height

	movzx	ecx,(s ptr[esi]).s_sp_size			;now point to appropriate sprite
	imul	eax,ecx
	lea	esi,SIZE s[esi]
	add	esi,eax

	jifne	ebp,stamp_on_it

draw_loop:	push	edi
	mov	ecx,ebx
pix_lop:	lodsb
	jife	al,no_pix
	mov	es:[edi],al
no_pix:	inc	edi
	loop	pix_lop
	pop	edi
	add	edi,full_screen_width
	floop	edx,draw_loop

	pop	es
	ret						;done

stamp_on_it:	push	edi
	mov	ecx,ebx
	rep	movsb
	pop	edi
	add	edi,full_screen_width
	floop	edx,stamp_on_it

	pop	es
	ret						;done


c2_draw_control_sprite2	endp




c2_depress_button_2	proc

;	depress button sprite esi until mouse button released

	m_draw_sprite 2
	call	wait_mouse_not_pressed
	m_draw_sprite 0

	ret

c2_depress_button_2	endp




c2_save_game_panel	proc

;	Switch to the save game screen
;	called from main panel loop

	mov	[c2_allow_edit],1				;allow texts to be edited

	call	c2_save_restore_panel

	cmp	eax,c2_no_disk_space
	jne	got_room

	mov	[init_text],7000h + 54

got_room:	ret

c2_save_game_panel	endp


c2_rest_game_panel	proc

	mov	[c2_allow_edit],0				;texts can't be edited

	call	c2_save_restore_panel

	ret

c2_rest_game_panel	endp


c2_save_restore_panel proc

	jife	esi,no_pbut
	call	c2_depress_button_2			;wait until mouse released

no_pbut:	call	remove_mouse

	mov	esi,offset sp_save_panel			;print the sprites
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	mov	esi,offset sp_quit_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	call	c2_load_save_descriptions			;load in the save descriptions

	call	c2_init_edit_game

	call	c2_set_edit_sprite

	call	c2_set_up_game_sprites			;set up the game text sprites

	call	c2_display_game_sprites			;and display them

;	Hang around for a key press or a mouse press

rest_fail:	mov	esi,offset sp_save_btn
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	call	restore_mouse

wait_loop:	mov	esi,offset sp_look_list			;check for some buttons
	test	[c2_allow_edit],-1
	jne	is_save
	mov	esi,offset rp_look_list			;check for some buttons
is_save:	mov	ecx,sp_look_list_no
look_loop:	push	esi
	mov	esi,[esi]
	call	c2_check_for_hit
	pop	esi
	je	btn_hit
	lea	esi,4[esi]
	loop	look_loop

	call	c2_restore_button_screen			;restore screen under button text

;	Check for a change of game

	test	[mouse_b],-1
	je	no_new_game

	mov	eax,[amouse_x]
	cmp	eax,game_name_x
	jc	no_new_game
	cmp	eax,game_name_x+pan_line_width
	jnc	no_new_game

	mov	eax,[amouse_y]
	cmp	eax,game_name_y
	jc	no_new_game
	cmp	eax,game_name_y + max_on_screen * pan_char_height
	jnc	no_new_game

;	We have a new game

	sub	eax,game_name_y
	mov	ebx,pan_char_height
	clear	edx
	idiv	ebx
	add	eax,[c2_game_on_top]

;	eax is new game

	cmp	eax,[c2_edit_game]
	je	check_keys

	mov	[c2_edit_game],eax

	call	c2_init_edit_game
	call	c2_set_edit_sprite
	call	remove_mouse
	call	c2_display_game_sprites		;and display them
	call	restore_mouse

no_new_game:	jmp	check_keys


btn_hit:	;A button has been hit

	mov	esi,[esi]
	call	c2_button_control
	test	[mouse_b],-1
	je	check_keys
	call	c2_kill_button

;	A button has been pressed, go to it

	call	(c_spr ptr[esi]).routine

;	Check the return values

	cmp	eax,c2_cancel_pressed
	je	sp_cancel

	cmp	eax,c2_game_saved
	je	sp_cancel

	cmp	eax,c2_game_restored
	je	sp_cancel

	cmp	eax,c2_restore_failed
	je	rest_fail

	cmp	eax,c2_no_disk_space
	je	sp_cancel

	jmp	wait_loop

sp_cancel:	ret


check_keys:	;Check for a key press

	call	fetch_key
	je	wait_loop

	cmp	ax,13
	je	save_by_key_press

	cmp	ax,27
	je	c2_sp_cancel

	test	[c2_allow_edit],-1			;in restore game edit not allowed
	je	wait_loop

	cmp	ax,8					;delete?
	je	backspace

;	Is char 0-9, a-z or A-Z

	cmp	ax,'0'					;check for 0-9
	jc	check_list
	cmp	ax,'9'+1
	jc	is_char
	cmp	ax,'A'					;check for A-Z
	jc	check_list
	cmp	ax,'Z'+1
	jc	is_char
	cmp	ax,'a'					;check for a-z
	jc	check_list
	cmp	ax,'z'+1
	jc	is_char

check_list:	;Check through a list to see if this character is allowed

	mov	esi,offset character_list
chk_ch_lop:	test	bpt[esi],-1
	je	wait_loop
	cmp	al,[esi]
	je	is_char
	inc	esi
	jmp	chk_ch_lop

is_char:	;We have a character. Is there room for it

	cmp	[c2_edit_width],pan_line_width-6
	jnc	wait_loop

	cmp	[c2_edit_cursor],max_text_len
	jnc	wait_loop

	mov	ebx,[c2_edit_cursor]				;put the character in
	mov	esi,offset c2_edit_text
	mov	ds:[esi+ebx],al
	mov	wpt ds:[esi+ebx+1],5fh			;and terminate it
	inc	[c2_edit_cursor]

redraw_text:	call	c2_set_edit_sprite

	call	remove_mouse
	call	c2_display_game_sprites		;and display them
	call	restore_mouse

	jmp	wait_loop

backspace:	;delete a character

	cmp	[c2_edit_cursor],6
	jc	wait_loop
	dec	[c2_edit_cursor]
	mov	esi,offset c2_edit_text
	mov	eax,[c2_edit_cursor]
	mov	wpt [esi+eax],5fh
	jmp	redraw_text


save_by_key_press:	call	c2_kill_button

	test	[c2_allow_edit],-1
	je	rest_by_key_press
	
	call	c2_save_a_game

	cmp	eax,c2_name_2_short
	je	wait_loop

	ret

rest_by_key_press:	call	c2_restore_a_game

	cmp	eax,c2_restore_failed
	je	rest_fail

	ret


;try_and_save:	call	save_game
;	jc	wait_loop
;	stc
;	ret
;



;	call	c2_restore_button_screen			;restore screen under button text
;
;	test	[bmouse_b],-1				;only do something with save games if a button is pressed
;	je	check_key
;	mov	[bmouse_b],0
;
;	mov	esi,[display_c_spr]			;check if we have clicked on a new game
;	mov	ecx,max_on_screen
;chk_gam_lop:	push	esi
;	push	ecx
;	call	check_for_hit
;	pop	ecx
;	pop	esi
;	je	new_game
;	add	esi,SIZE c_spr
;	loop	chk_gam_lop
;
;check_key:	call	fetch_key				;get a key
;	je	wait_loop
;
;
;
;	mov	esi,[esi]
;ifdef new_control
;	call	c2_button_control
;	test	[mouse_b],-1
;	je	wait_loop
;	call	c2_kill_button
;else
;	call	button_control
;	jne	wait_loop
;endif
;
;;	a button has been pressed, go to it my lads
;
;	call	(c_spr ptr[esi]).routine
;	jc	wait_loop
;	stc
;	ret
;
;
;new_game:	;user has selected a line on the screen
;
;	mov	eax,max_on_screen			;calculate which one
;	sub	eax,ecx
;	add	eax,[start_game]
;
;	cmp	eax,[edit_game_no]		;check we haven't reselected the current sprite
;	je	wait_loop
;
;	push	eax				;save game no
;	call	remove_mouse			;stop the mouse awhile
;
;	pop	esi
;	xchg	esi,[edit_game_no]		;restore original text data
;	sub	esi,[start_game]
;	imul	esi,SIZE c_spr
;	add	esi,[display_c_spr]
;	mov	ebp,1
;	call	c2_draw_control_sprite
;	
;	jmp	edit_game_text
;
;
;finish_save:
;;	mov	esi,[display_spr]
;;	mov	ecx,max_on_screen
;;ds_fr_lop:	lodsd
;;	push	esi
;;	push	ecx
;;	call	my_free
;;	pop	ecx
;;	pop	esi
;;	loop	ds_fr_lop
;
;	stc						;force new control panel
;	ret
;
;
;;	The text has been done, save the game
;

;shift_down_1::	;move the display list down
;
;	test	[bmouse_b],-1				;only one at a time
;	je	no_shift
;
;shift_down_fast::	mov	[bmouse_b],0
;	mov	eax,[start_game]				;check we can scroll down
;	cmp	eax,max_save_games-max_on_screen-1
;	jnc	no_shift
;
;	inc	[start_game]
;
;	mov	esi,[display_spr]				;free the first one and shift the others up
;	push	esi
;	lodsd
;	push	esi
;	call	my_free
;	pop	esi
;	pop	edi
;	mov	ecx,max_on_screen-1
;	rep	movsd
;	push	edi
;
;	mov	esi,[start_game]				;fetch new game
;	add	esi,max_on_screen-1
;	imul	esi,max_text_len
;	add	esi,[c2_save_game_texts]
;	mov	dl,-1
;	mov	ecx,pan_line_width
;	clear	ebx
;	clear	ebp					;no centering
;	call	display_text
;	pop	edi
;	stosd
;
;	sub	(c_spr ptr[sp_save_text]).y,pan_char_height
;
;;	now redraw the sprites, including highlit one
;
;	call	remove_mouse
;
;	mov	esi,[display_c_spr]
;	mov	ecx,max_on_screen
;	mov	eax,[start_game]
;
;redraw_loop:	push	ecx
;	push	esi
;	push	eax
;
;	cmp	eax,[edit_game_no]			;check for highlit game
;	jne	norma
;
;	mov	esi,offset sp_save_text
;
;norma:	mov	ebp,1
;	call	c2_draw_control_sprite
;
;	pop	eax
;	inc	eax
;	pop	esi
;	lea	esi,SIZE c_spr[esi]
;	pop	ecx
;	loop	redraw_loop
;
;;	check if current game has been shifted off the top
;
;	mov	eax,[start_game]
;	cmp	eax,[edit_game_no]
;	jbe	no_ngam
;
;	mov	[edit_game_no],eax
;	call	[highlight_current_game]
;
;no_ngam:	call	restore_mouse
;
;no_shift:	stc
;	ret
;
;
;shift_up_1::	;move the display list up
;
;	test	[bmouse_b],-1				;only one at a time
;	je	no_shift
;
;shift_up_fast::	mov	[bmouse_b],0
;	test	[start_game],-1				;check we can scroll up
;	je	no_shift
;
;	dec	[start_game]
;
;	mov	esi,[display_spr]				;free the first one and shift the others up
;	add	esi,(max_on_screen-1)*4
;	push	esi
;	mov	eax,[esi]
;	call	my_free
;	pop	edi
;	mov	esi,edi
;	lea	esi,[edi-4]
;	mov	ecx,max_on_screen-1
;	std
;	rep	movsd
;	cld
;	push	edi
;
;	mov	esi,[start_game]				;fetch new game
;	imul	esi,max_text_len
;	add	esi,[c2_save_game_texts]
;	mov	dl,-1
;	mov	ecx,pan_line_width
;	clear	ebx
;	clear	ebp					;no centering
;	call	display_text
;	pop	edi
;	mov	[edi],eax
;
;	add	(c_spr ptr[sp_save_text]).y,pan_char_height
;
;;	now redraw the sprites, including highlit one
;
;	call	remove_mouse
;
;	mov	esi,[display_c_spr]
;	mov	ecx,max_on_screen
;	mov	eax,[start_game]
;
;redraw_loop2:	push	ecx
;	push	esi
;	push	eax
;
;	cmp	eax,[edit_game_no]			;check for highlit game
;	jne	norma2
;
;	mov	esi,offset sp_save_text
;
;norma2:	mov	ebp,1
;	call	c2_draw_control_sprite
;
;	pop	eax
;	inc	eax
;	pop	esi
;	lea	esi,SIZE c_spr[esi]
;	pop	ecx
;	loop	redraw_loop2
;
;;	check if current game has been shifted off the bottom
;
;	mov	eax,[start_game]
;	add	eax,max_on_screen-1
;	cmp	eax,[edit_game_no]
;	jnc	no_ngam2
;
;	mov	[edit_game_no],eax
;	call	[highlight_current_game]
;
;no_ngam2:	call	restore_mouse
;	stc
;	ret

c2_save_restore_panel endp




c2_set_up_game_sprites	proc

;	Set up the sprites for save/restore games

	mov	esi,[c2_game_on_top]
	imul	esi,max_text_len
	add	esi,[c2_save_game_texts]			;point to the first one
	mov	edi,offset c2_text_sprites			;store addresses here
	mov	ecx,max_on_screen

sups_lop:	push	esi
	push	edi
	push	ecx

	mov	dl,37
	mov	cx,pan_line_width
	mov	ebx,[edi]				;use old data if there is any
	clear	ebp					;no centering
	call	display_text

	pop	ecx
	pop	edi
	pop	esi

	stosd
	lea	esi,max_text_len[esi]
	loop	sups_lop

	ret

c2_set_up_game_sprites	endp




c2_display_game_sprites	proc


;	Display the game texts

	mov	esi,offset c2_text_sprites
	mov	ebx,game_name_y
	mov	ecx,max_on_screen
	mov	edx,[c2_game_on_top]

dgs_loop:	push	esi
	push	ebx
	push	ecx
	push	edx

	cmp	edx,[c2_edit_game]
	jne	not_edit
	mov	esi,offset c2_edit_sprite

not_edit:	mov	(c_spr ptr[c2_text_c_spr]).sp_add,esi
	mov	(c_spr ptr[c2_text_c_spr]).y,ebx

	mov	esi,offset c2_text_c_spr
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	pop	edx
	pop	ecx
	pop	ebx
	pop	esi

	add	ebx,pan_char_height
	inc	edx
	lea	esi,4[esi]
	loop	dgs_loop

	ret

c2_display_game_sprites	endp




c2_sp_cancel	proc

;	Save / restore cancel pressed

	call	c2_kill_button

	mov	eax,c2_cancel_pressed
	ret

c2_sp_cancel	endp




c2_save_game_to_disk	proc

;	save game to file, edx points to name

	mov	eax,[current_music]
	mov	[saved_current_music],eax

	push	edx
	call	_open_for_write__Npc
	or	eax,eax
	js	save_error

;	mov	ah,3ch					;create a new file
;	clear	ecx
;	dos_int
;	jc	save_error

	mov	edx,offset start_of_save_data		;write the savedata data
	mov	ecx,offset end_of_save_data
	sub	ecx,edx
	mov	[start_of_save_data],ecx
	mov	ebx,eax
	mov	ah,40h
	dos_int
	jc	save_error

;	Save the replay data for this file

ifdef with_replay
	mov	edx,offset replay_data_ptr			;first write data length
	mov	ecx,4
	mov	ah,40h
	int	21h

	mov	edx,[replay_data]				;then data
	mov	ecx,[replay_data_ptr]
	mov	ah,40h
	int	21h
endif
	mov	ah,3eh					;and close the file
	dos_int

	ret

save_error:	program_error em_disk_rd_error

c2_save_game_to_disk	endp



c2_save_a_game	proc

;	Save the game


	cmp	[c2_edit_cursor],6				;only save if some text has gone in
	jnc	ok_2_save

	mov	eax,c2_name_2_short
	ret

ok_2_save:	call	remove_mouse

	mov	ah,19h					;get default drive
	int	21h

	test	[_cd_version],-1
	je	not_cd99

	mov	al,2

not_cd99:	mov	ah,36h					;get free disk space
	mov	dl,al
	inc	dl
	int	21h

	cmp	ax,-1					;no drive?
	je	insuff_disk_space

	movzx	eax,ax
	movzx	ebx,bx
	movzx	ecx,cx

	imul	eax,ebx
	imul	eax,ecx

	mov	ebx,offset end_of_save_data
	sub	ebx,offset start_of_save_data
	add	ebx,10000

	cmp	eax,ebx
	jc	insuff_disk_space

	mov	esi,offset sp_save_btn			;depress the button
	m_draw_sprite 2
	mov	(c_spr ptr[esi]).c_spr,0

	mov	esi,offset c2_edit_text			;transfer the name over
	mov	eax,[c2_edit_cursor]				;trash '_'

	mov	bpt[esi+eax],0

	mov	edi,[c2_edit_game]			;put data into the slot
	imul	edi,max_text_len
	add	edi,[c2_save_game_texts]
	mov	ecx,max_text_len/4
	rep	movsd

;	Save the saved game texts

	push	[save_game_text_file]
	call	_open_for_write__Npc
	or	eax,eax
	js	save_error

;	mov	ah,3ch
;	clear	ecx
;	mov	edx,[save_game_text_file3]
;	dos_int
;	jc	save_error

	mov	ebx,eax

	mov	ah,40h				;write version no
	mov	ecx,4
	mov	edx,offset replay_version
	dos_int

;	Shuffle the data down, removing the gaps

	mov	ecx,max_save_games			;write out all text descriptions
	mov	esi,[c2_save_game_texts]
	mov	edi,esi

shuffle_text:	push	esi
	lea	esi,5[esi]				;skip game number
char_loop:	lodsb
	stosb
	jifne	al,char_loop

	pop	esi					;next line
	lea	esi,max_text_len[esi]
	loop	shuffle_text

	mov	ah,40h					;write out text data
	mov	ecx,edi
	mov	edx,[c2_save_game_texts]
	sub	ecx,edx
	dos_int

	mov	ah,3eh					;and close the file
	int	21h

;	Save the game data

	mov	eax,[c2_edit_game]
	inc	eax
	mov	bx,10
	clear	edx
	idiv	bx					;my kingdom for a srintf
	add	dl,'0'
	mov	esi,[save_game_name]
	mov	[esi+11],dl
	clear	edx
	idiv	bx
	add	dl,'0'
	mov	[esi+10],dl
	clear	edx
	idiv	bx
	add	dl,'0'
	mov	[esi+9],dl

ifdef with_replay
	mov	eax,-1
	clear	ebx
	clear	ecx
	call	replay_record_event			;flag game save
endif

	mov	edx,[save_game_name]
	call	c2_save_game_to_disk

	call	restore_mouse

	mov	eax,c2_game_saved
	ret

insuff_disk_space:	mov	eax,c2_no_disk_space
	ret

save_error:	program_error em_disk_rd_error

c2_save_a_game	endp




c2_init_edit_game	proc

	mov	esi,[c2_edit_game]
	imul	esi,max_text_len
	add	esi,[c2_save_game_texts]
	mov	edi,offset c2_edit_text

tran_gm:	lodsb
	jife	al,trand_gm
	stosb
	jmp	tran_gm

trand_gm:	test	[c2_allow_edit],-1
	je	no_edit

	mov	ax,'_'

no_edit:	stosw
	sub	edi,offset c2_edit_text+2
	mov	[c2_edit_cursor],edi

	ret

c2_init_edit_game	endp




c2_set_edit_sprite	proc

	mov	dl,-1
	mov	cx,pan_line_width
	mov	ebx,[c2_edit_sprite]
	clear	ebp					;no centering
	mov	esi,offset c2_edit_text
	call	display_text
	mov	[c2_edit_sprite],eax
	mov	[c2_edit_width],ebx

	ret

c2_set_edit_sprite	endp




c2_shift_down_fast	proc

;	Shift the games down one

	mov	eax,[c2_game_on_top]		;can we do it?
	cmp	eax,max_save_games - max_on_screen
	jnc	no_shift

	inc	[c2_game_on_top]

	mov	esi,offset c2_text_sprites
	mov	edi,esi

	lodsd					;this one goes off top
	mov	ecx,max_on_screen-1
	rep	movsd
	push	edi

;	mov	ebx,eax				;move one in from bottom
	call	my_free

	clear	ebx
	mov	esi,[c2_game_on_top]
	add	esi,max_on_screen-1
	imul	esi,max_text_len
	add	esi,[c2_save_game_texts]
	mov	dl,37
	mov	cx,pan_line_width
	clear	ebp					;no centering
	call	display_text

	pop	edi
	stosd
	mov	eax,[c2_edit_game]		;check for selected game scrolling off top
	cmp	eax,[c2_game_on_top]
	jnc	no_scrofftop

	mov	eax,[c2_game_on_top]
	mov	[c2_edit_game],eax
	call	c2_init_edit_game
	call	c2_set_edit_sprite
no_scrofftop:	call	c2_display_game_sprites
no_shift:	mov	eax,c2_shifted
	ret

c2_shift_down_fast	endp




c2_shift_down_slow	proc

	call	c2_shift_down_fast
	call	wait_mouse_not_pressed

	mov	eax,c2_shifted
	ret

c2_shift_down_slow	endp




c2_shift_up_fast	proc

;	Shift the games down one

	test	[c2_game_on_top],-1			;can we do it?
	je	no_shift

	dec	[c2_game_on_top]

	mov	esi,offset c2_text_sprites + ( (max_on_screen-1) * 4)
	mov	edi,esi

	std

	lodsd					;this one goes off top

	mov	ecx,max_on_screen-1
	rep	movsd
	cld

	push	edi

	mov	ebx,eax				;move one in from bottom
	mov	esi,[c2_game_on_top]
	imul	esi,max_text_len
	add	esi,[c2_save_game_texts]
	mov	dl,37
	mov	cx,pan_line_width
	clear	ebp					;no centering
	call	display_text

	pop	edi
	stosd

	mov	eax,[c2_game_on_top]
	add	eax,max_on_screen-1
	cmp	eax,[c2_edit_game]
	jnc	no_scrofftop

	mov	eax,[c2_game_on_top]
	add	eax,max_on_screen-1
	mov	[c2_edit_game],eax

	call	c2_init_edit_game
	call	c2_set_edit_sprite

no_scrofftop:	call	c2_display_game_sprites

no_shift:	mov	eax,c2_shifted
	ret

c2_shift_up_fast	endp




c2_shift_up_slow	proc

	call	c2_shift_up_fast
	call	wait_mouse_not_pressed

	mov	eax,c2_shifted
	ret

c2_shift_up_slow	endp



c2_restore_a_game	proc

;	Restore the game data

	call	remove_mouse

	mov	esi,offset sp_rest_btn
	m_draw_sprite 2

	mov	eax,[c2_edit_game]
	inc	eax
	mov	bx,10
	clear	edx
	idiv	bx					;my kingdom for a srintf
	add	dl,'0'
	mov	esi,[save_game_name]
	mov	[esi+11],dl
	clear	edx
	idiv	bx
	add	dl,'0'
	mov	[esi+10],dl
	clear	edx
	idiv	bx
	add	dl,'0'
	mov	[esi+9],dl

	mov	edx,[save_game_name]
	call	restore_a_game_from_disk

	push	eax

	call	wait_mouse_not_pressed
	mov	esi,offset sp_rest_btn
	m_draw_sprite 2

	pop	eax

	ret

restore_error:	program_error em_disk_rd_error

c2_restore_a_game	endp




c2_get_yes_no	proc

;	Print the yes / no sprite and get a response

	call	remove_mouse
	mov	esi,offset sp_yes_no
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2
	call	restore_mouse

	call	wait_mouse_not_pressed

	clear	edx				;set edx for when mouse is normal

not_but:	jifne	edx,check_loop
	call	fn_normal_mouse
	inc	edx

check_loop:	cmp	[amouse_y],83			;check y
	jc	not_but
	cmp	[amouse_y],110
	jnc	not_but

	cmp	[amouse_x],77			;now x
	jc	not_but
	cmp	[amouse_x],114
	jc	on_yes

	cmp	[amouse_x],156			;now x
	jc	not_but
	cmp	[amouse_x],193
	jnc	not_but

;	Over the no

	jife	edx,is_cross1
	call	do_cross_mouse
	clear	edx

is_cross1:	test	[mouse_b],-1
	je	check_loop

	ret					;return with z = 0

on_yes:	;over the yes

	jife	edx,is_cross2
	call	do_cross_mouse
	clear	edx

is_cross2:	test	[mouse_b],-1
	je	check_loop

	clear	eax

	ret					;return with z = 1

c2_get_yes_no	endp




c2_quit_to_dos	proc

;	Quit to dos, maybe

	call	c2_get_yes_no
	jne	not_really

	program_error em_game_over

not_really:	ret

c2_quit_to_dos	endp




c2_restart	proc

;	Restart, maybe

	call	c2_get_yes_no
	mov	eax,0
	jne	not_really

	;call	force_restart

	call	fn_disk_mouse

	mov	edx,[restart_name_p]
	call	restore_a_game_from_disk

	call	remove_mouse

	mov	eax,c2_restarted

not_really:	ret

c2_restart	endp




c2_slide	proc

;	control the slider

max_speed	equ	9

;c2_top_y	equ	(mpnl_y + 52)
;c2_bot_y	equ	(mpnl_y + 92)

	call	remove_mouse

slide_loop:	mov	eax,[amouse_y]				;calculate new speed
	sub	eax,2
	jc	yes_uflow
	sub	eax,[sl_sp_top_y]
	jnc	no_uflow
yes_uflow:	clear	eax
no_uflow:	cmp	eax,[sl_sp_range]
	jc	no_oflow
	mov	eax,[sl_sp_range]

no_oflow:	mov	ebx,[sl_sp_devidor]	;(c2_bot_y - c2_top_y + max_speed - 1) / max_speed
	clear	edx
	idiv	ebx

;	eax should be new number

	jifne	eax,speed_fudge
	inc	eax
speed_fudge:

	cmp	eax,[stabilise_count]
	je	same_count

	mov	[stabilise_count],eax

	imul	eax,[sl_sp_devidor]	;(c2_bot_y - c2_top_y + max_speed - 1) / max_speed
	add	eax,[sl_sp_top_y]
	mov	esi,offset sp_slide
	mov	(c_spr ptr[esi]).y,eax

	push	esi
	mov	esi,offset sp_slode
	mov	ebp,no_mask
	call	c2_draw_control_sprite2

	;test	[_cd_version],-1
	;je	not_cd
	bt	[system_flags],sf_sblaster	;sblaster only
	jnc	not_cd

	mov	esi,offset sp_slid2
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2

not_cd:	pop	esi
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2

same_count:	call	debug_loop
	test	[mouse_b],-1
	jne	slide_loop

	call	restore_mouse
	inc	[stabilise_count]

	mov	eax,c2_speed_changed

	ret

c2_slide	endp



c2_slide2	proc

;	control the slider

max_speed	equ	9

;c2_top_y	equ	(mpnl_y + 52)
;c2_bot_y	equ	(mpnl_y + 92)

	call	remove_mouse

slide_loop:	mov	eax,[amouse_y]				;calculate new speed
	sub	eax,2
	jc	yes_uflow
	sub	eax,[sl_ms_top_y]
	jnc	no_uflow
yes_uflow:	clear	eax
no_uflow:	cmp	eax,[sl_ms_range]
	jc	no_oflow
	mov	eax,[sl_ms_range]

no_oflow:	;mov	ebx,4	;(c2_bot_y - c2_top_y + max_speed - 1) / max_speed
	;clear	edx
	;idiv	ebx

	mov	ebx,32
	sub	ebx,eax

;	ebx should be new number

	cmp	ebx,[music_volume]
	je	same_count

	mov	[music_volume],ebx

	;imul	eax,4	;(c2_bot_y - c2_top_y + max_speed - 1) / max_speed
	add	eax,[sl_ms_top_y]
	mov	esi,offset sp_slid2
	mov	(c_spr ptr[esi]).y,eax

	push	esi
	mov	esi,offset sp_slode
	mov	ebp,no_mask
	call	c2_draw_control_sprite2
	mov	esi,offset sp_slide
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2
	pop	esi
	mov	ebp,yes_mask
	call	c2_draw_control_sprite2

	mov	ecx,[music_volume]		;0-32
	shl	ecx,3				;0-256
	mov	ah,13
	call	music_command

same_count:	call	debug_loop
	test	[mouse_b],-1
	jne	slide_loop

	call	restore_mouse

	mov	eax,c2_speed_changed

	ret

c2_slide2	endp


end32code

	end
