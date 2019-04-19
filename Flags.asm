


;	Game two flags


;	system flags

sf_timer	equ	 0			;set if timer interrupt redirected
sf_graphics	equ	 1			;set if screen is in graphics mode
sf_mouse	equ	 2			;set if mouse handler installed
sf_keyboard	equ	 3			;set if keyboard interrupt redirected

sf_music_board	equ	 4			;set if a music board detected
sf_roland	equ	 5			;set if roland board present
sf_adlib	equ	 6			;set if adlib board present
sf_sblaster	equ	 7			;set if sblaster present
sf_tandy	equ	 8			;set if tandy present
sf_music_bin	equ	 9			;set if music driver is loaded
sf_plus_fx	equ	10			;set if extra fx module needed
sf_fx_off	equ	11 			;set if fx disabled
sf_mus_off	equ	12			;set if music disabled

sf_timer_tick	equ	13			;set every timer interupt

;	Status flags

sf_choosing	equ	14			;set when choosing text
sf_no_scroll	equ	15			;when set don't scroll

sf_speed	equ	16			;when set allow speed options
sf_game_restored	equ	17			;set when game restored or restarted

sf_replay_rst	equ	18			;set when loading restart data (used to stop rewriting of replay file)
sf_speech_file	equ	19			;set when loading speech file

sf_voc_playing	equ	20			;set when a voc file is playing
sf_play_vocs	equ	21			;set when we want speech instead of text

sf_crit_err	equ	22			;set when critical error routine trapped

sf_allow_speech	equ	23			;speech allowes on cd sblaster version
sf_allow_text	equ	24			;text allowed on cd sblaster version

sf_allow_quick	equ	25			;when set allow speed playing

sf_test_disk	equ	26			;set when loading files
sf_mouse_stopped	equ	27			;set if mouse handler skipped to prevent stack overflow

;	Mouse flags

mf_no_update	equ	0			;set to disable mouse updating
mf_in_int	equ	1			;set when in mouse interrupt
mf_saved	equ	2			;set when saved data is valid
mf_got_int	equ	3			;set when mouse interrupt received


mouse_normal	equ	1			;normal mouse
mouse_disk	equ	2			;disk mouse
mouse_down	equ	3			;
mouse_right	equ	4			;right pointer
mouse_left	equ	5			;left pointer
mouse_blank	equ	6			;blank mouse
mouse_cross	equ	7			;angry mouse
mouse_up	equ	8			;mouse up

;--------------------------------------------------------------------------------------------------

;	debug flags

ifdef debug_42	;don't shuffle these around, they are hard coded in the c files

df_ar	equ	0				;bit 0 set for show route
df_script	equ	1				;bit 1 set for show scripts
df_grid	equ	2				;bit 2 set for show grid
df_debug	equ	3				;bit 3 set to turn off debug_compact and printf

df_debug_on	equ	31				;when clear don't write a debug file

endif


;;	replay flags
;
;ifdef with_replay
;
;rf_replay_onn	equ	0			;set if replay
;rf_replay_endn	equ	1			;set when end of replay file reached
;rf_replay_skip_scrn equ	2			;set for skip screen display - to next file load
;rf_replay_skip_cmdn equ	3			;set for skip screen display - to next command
;rf_replay_skip_alln equ	4			;skip forever
;rf_replay_skip_sp	equ	5			;skip until next speech
;
;rf_skippingn	equ	3ch
;
;endif
