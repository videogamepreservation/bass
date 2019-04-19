include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_flags	equ	1
include_keyboard_codes equ 1

	include include.asm


;	1a		cars to small sky screen
;	1b		to big sky screen
;	1c		between sky screen fade up and fade off
;	1d		fade off sky screen
;	1e		cars to scrolling bit


intro_text_width	equ	128

fn_a_pal	equ	60080
fn_1a_log	equ	60081
fn_1a	equ	60082
fn_1b	equ	60083
fn_1c	equ	60084
fn_1d	equ	60085
fn_1e	equ	60086
fn_4a	equ	60087
fn_4b_log	equ	60088
fn_4b	equ	60089
fn_4c_log	equ	60090
fn_4c	equ	60091
fn_5_pal	equ	60092
fn_5_log	equ	60093
fn_5	equ	60094
fn_6_pal	equ	60095
fn_6_log	equ	60096
fn_6a	equ	60097
fn_6b	equ	60098

ifdef short_intro_start

virgin_time_1	equ	3
virgin_time_2	equ	3
rev_time	equ	8
gibb_time	equ	6

else

virgin_time_1	equ	3*50
virgin_time_2	equ	3*50+8
rev_time	equ	8*50+8
gibb_time	equ	6*50+8

endif


wait_sequence	macro	lab

wait_seq_&lab&:	call	check_commands

ifdef debug_42
	call	debug_loop
endif

ifdef no_timer
	call	do_timer_sequence
	call	stabilise
endif

	call	fetch_key
	jne	key_pressed_eax
	test	[tseq_frames],-1
	jne	wait_seq_&lab&

endm



start32data
	public	temp_pal
	public	work_screen

	extrn	_skip_intro:dword

ifdef with_replay
	extrn	_do_a_replay:dword
endif

temp_pal	dd	0					;pointer to temporary palettes
seq1a_data	dd	0					;pointer to sequence data
seq1b_data	dd	0
seq1c_data	dd	0
seq1d_data	dd	0
seq1e_data	dd	0
seq4a_data	dd	0
seq4b_data	dd	0
seq4c_data	dd	0
seq5_data	dd	0
seq6a_data	dd	0
seq6b_data	dd	0

vga_data	dd	0
diff_data	dd	0

work_base	dd	0
work_screen	dd	?
work_screen_end	dd	?

intro_text_space	dd	0					;space for storuing text messages
intro_text_save	dd	0					;save screen data here

vga_pointer	dd	?					;working pointers
diff_pointer	dd	?

no_frames	dd	?					;no of frames in scrolling intro
frame_counter	dd	?

command_pointer	dd	offset zero_commands

;	Sequence commands

ic_prepare_text	equ	0
ic_show_text	equ	1
ic_remove_text	equ	2
ic_make_sound	equ	3
ic_fx_volume	equ	4

command_routines	dd	offset prepare_text
	dd	offset show_intro_text
	dd	offset remove_text
	dd	offset intro_fx
	dd	offset intro_vol

cockpit_commands	dd	1000					;do straight away
	dd	ic_prepare_text
	dd	77

	dd	220
	dd	ic_show_text				;Radar detects a jamming signal
	dd	20
	dd	160

	dd	105
	dd	ic_remove_text

	dd	105
	dd	ic_prepare_text
	dd	81

	dd	105
	dd	ic_show_text				;well switch to override you fool
	dd	170
	dd	86

	dd	35
	dd	ic_remove_text

	dd	35
	dd	ic_prepare_text
	dd	477

	dd	35
	dd	ic_show_text
	dd	30
	dd	160

	dd	3
	dd	ic_remove_text

zero_commands	dd	0

anim5_commands	dd	31
	dd	ic_make_sound
	dd	2
	dd	127

	dd	0


anim4a_commands	dd	136
	dd	ic_make_sound
	dd	1
	dd	70

	dd	90
	dd	ic_fx_volume
	dd	80

	dd	50
	dd	ic_fx_volume
	dd	90

	dd	5
	dd	ic_fx_volume
	dd	100

	dd	0

anim4c_commands	dd	1000
	dd	ic_fx_volume
	dd	100

	dd	25
	dd	ic_fx_volume
	dd	110

	dd	15
	dd	ic_fx_volume
	dd	120

	dd	4
	dd	ic_fx_volume
	dd	127

	dd	0

anim6a_commands	dd	1000
	dd	ic_prepare_text
	dd	478

	dd	13
	dd	ic_show_text
	dd	175
	dd	155

	dd	0

anim6b_commands	dd	131
	dd	ic_remove_text

	dd	131
	dd	ic_prepare_text
	dd	479

	dd	74
	dd	ic_show_text
	dd	175
	dd	155

	dd	45
	dd	ic_remove_text

	dd	45
	dd	ic_prepare_text
	dd	162

	dd	44
	dd	ic_show_text
	dd	175
	dd	155

	dd	4
	dd	ic_remove_text

	dd	0

end32data




start32code
	public	show_screen

	extrn	force_restart:near
	extrn	fade_up_esi:near
	extrn	do_the_cd_intro:near


init_virgin	proc

;	Bring on the virgin screen

	load_to 60111,[temp_pal]			;virgin palette
	mov	esi,eax				;set virgin palette
	call	set_palette

	load_to 60110,[work_screen]		;load virgin screen

	call	show_screen			;show virgin screen
	mov	[relative_50hz_count],0

	free_clr2 [work_screen]
	free_clr2 [temp_pal]
	ret

init_virgin	endp


_intro__Nv	proc

ifndef cd_version_prot
ifdef s1_demo
	jmp	load_base_0
endif
endif

;	call	flush_key_buffer

ifdef with_replay	;If replaying don't play intro, leave as though intro played

	test	[_do_a_replay],-1
	jne	load_base_0
endif

	test	[_skip_intro],-1
	jne	load_base_0

;	While virgin on screen load revolution screen

	load_to 60112,[work_screen]
	load_to 60113,[temp_pal]

	mov	eax,0				;load music
	call	load_section_music

;	Ensure virgin up for minimum time (should never underrun in reality)

	mov	eax,virgin_time_1
	call	wait_relative
	jc	key_pressed

;	mov	[relative_50hz_count],0

;	bt	[system_flags],sf_allow_text
;	jc	yes_imus

	test	[_cd_version],-1
	jne	no_imus

yes_imus:	mov	eax,1
	call	fn_start_music

no_imus:	mov	eax,virgin_time_2
	call	wait_relative
	jc	key_pressed

	call	fn_fade_down			;Remove virgin

;--------------------------------------------------------------------------------------------------

;	TIMING STARTS HERE

	mov	[relative_50hz_count],0		;keep this in 'cos it kinda works

;	Fade up revolution screen

	call	show_screen
	mov	esi,[temp_pal]
	call	fade_up_esi
	free_clr2 [temp_pal]
	free_clr2 [work_screen]

;	While revolution is up load gibbo's screen

	load_to 60114,[work_screen]
	load_to 60115,[temp_pal]

;	Do some bits and pieces

	mov	eax,3
ifdef no_timer
	mov	eax,2
endif
	call	set_stabilise

	mov	eax,10000				;allocate space for text fings
	call	my_malloc
	mov	[intro_text_space],eax
	mov	eax,10000
	call	my_malloc
	mov	[intro_text_save],eax

	mov	eax,77					;ensure text file is loaded
	call	get_text

;	Keep revolution up for a bit

	mov	eax,rev_time				;revolution up for 4 seconds
	call	wait_relative
	jc	key_pressed				;vga data has been loaded
;	mov	[relative_50hz_count],0

;	Load and fade up gibbo's screen

	call	fn_fade_down
	call	show_screen
	mov	esi,[temp_pal]
	call	fade_up_esi
	free_clr2 [temp_pal]
	free_clr2 [work_screen]

;	CD and hard disk version seperate here

	test	[_cd_version],-1
	je	hard_disk_version

;--------------------------------------------------------------------------------------------------

	bt	[system_flags],sf_sblaster			;can only do it on blaster
	jnc	hard_disk_version

;	bt	[system_flags],sf_allow_text		;On foreign versions dont use cd intro
;	jc	hard_disk_version

	call	do_the_cd_intro

	jifne	ebx,key_pressed
	call	remove_intro2
	jmp	load_base_0


;--------------------------------------------------------------------------------------------------


hard_disk_version:	;While gibbo is up load in the first sequence stuff

	load_to fn_a_pal,[temp_pal]
	load_to fn_1a_log,[work_screen]
	load_to fn_1a,[seq1a_data]

	mov	eax,gibb_time				;keep gibbo up for 2 seconds
	call	wait_relative
	jc	key_pressed
;	mov	[relative_50hz_count],0

;	Fade in and start the first sequence					seq 1

	call	fn_fade_down
	call	show_screen
	mov	esi,[temp_pal]
	call	fade_up_esi

	mov	esi,[seq1a_data]
	call	start_timer_sequence			;start off sequence 1

	free_clr2 [work_screen]
	free_clr2 [temp_pal]
	load_to fn_1b,[seq1b_data]			;load seq 1b while 1a playing
	load_to fn_1c,[seq1c_data]			;load 1c while 1a playing

	wait_sequence 1a

	mov	[stabilise_count],3
	call	stabilise
	mov	esi,[seq1b_data]				;start 1b		seq 1b
	call	anim_sequence

	mov	esi,[seq1c_data]				;start 1c
	call	start_timer_sequence

	free_clr2 [seq1a_data]
	free_clr2 [seq1b_data]
	load_to fn_1d,[seq1d_data]			;load 1d while 1c playing
	load_to fn_1e,[seq1e_data]			;load 1e while 1c playing

	wait_sequence 1c

	mov	[stabilise_count],3
	call	stabilise
	mov	esi,[seq1d_data]				;start 1d
	call	anim_sequence

	mov	esi,[seq1e_data]				;start 1e
	call	start_timer_sequence

	free_clr2 [seq1c_data]
	free_clr2 [seq1d_data]

	load_to 60100,[vga_data]			;load scrolling bit while waiting
	mov	[vga_pointer],eax
	load_to 60101,[diff_data]

	movzx	ebx,wpt[eax]			;get no frames
	mov	[no_frames],ebx
	add	eax,2
	mov	[diff_pointer],eax

	load_to fn_4a,[seq4a_data]

;	Set up the scrolling intro

	mov	eax,game_screen_width*game_screen_height*2
	call	my_malloc
	mov	[work_base],eax

	add	eax,game_screen_width*game_screen_height
	mov	[work_screen],eax

	add	eax,game_screen_width*game_screen_height
	mov	[work_screen_end],eax

	mov	edi,[work_base]				;clear work base
	mov	ecx,game_screen_width*game_screen_height/4
	clear	eax
	rep	stosd

	wait_sequence 1e

;	Put in first frame

	mov	edi,[work_screen]
	push	ds
	mov	ds,[screen_segment]
	clear	esi
	mov	ecx,game_screen_width*game_screen_height/4
	rep	movsd
	pop	ds

	mov	[frame_counter],1
	free_clr2 [seq1e_data]

	call	stabilise

;	Now do some more frames

frame_loop:	mov	eax,[frame_counter]
	cmp	eax,[no_frames]
	jnc	intro_done

	call	fetch_key
	je	no_key

	cmp	ax,27
	je	escape_pressed_in_intro
	cmp	ax,key_f5
	je	f5_pressed_in_intro

no_key:	call	stabilise

	mov	ebx,[diff_pointer]
	movzx	eax,bpt[ebx]			;get scrolling byte
	inc	[diff_pointer]

	jife	eax,no_scroll

;	scroll byte is used for some commands.
;	-1	fade in new palette

	imul	eax,game_screen_width
	sub	[work_screen],eax
	sub	[work_screen_end],eax

no_scroll:	;Non scrolling frame update

	call	intro_frame

	jmp	frame_loop


intro_done:	;Ont to 4a, 4b, 5 and 6

	mov	esi,[seq4a_data]
	call	start_timer_sequence

	free_clr2 [vga_data]
	free_clr2 [diff_data]
	load_to fn_4b_log,[work_screen]
	load_to fn_4b,[seq4b_data]

	mov	[command_pointer],offset anim4a_commands
	wait_sequence 4a

	mov	[stabilise_count],3
	call	show_screen
	call	stabilise

	mov	[command_pointer],offset cockpit_commands

	mov	esi,[seq4b_data]
	call	start_timer_sequence

	call	check_commands
	call	check_commands
	free_clr2 [work_screen]
	free_clr2 [seq4a_data]

	load_to fn_4c_log,[work_screen]
	load_to fn_4c,[seq4c_data]

	wait_sequence 4b

	mov	[stabilise_count],3
	call	show_screen
	call	stabilise
	mov	esi,[seq4c_data]
	call	start_timer_sequence

	free_clr2 [work_screen]
	free_clr2 [seq4b_data]
	load_to fn_5_pal,[temp_pal]
	load_to fn_5_log,[work_screen]
	load_to fn_5,[seq5_data]

	mov	[command_pointer],offset anim4c_commands
	wait_sequence 4c

	call	fn_fade_down
	call	show_screen
	mov	esi,[temp_pal]
	call	fade_up_esi

	mov	esi,[seq5_data]
	call	start_timer_sequence

	free_clr2 [work_screen]
	free_clr2 [seq4c_data]
	free_clr2 [temp_pal]

	load_to fn_6_pal,[temp_pal]
	load_to fn_6_log,[work_screen]
	load_to fn_6a,[seq6a_data]

	mov	[command_pointer],offset anim5_commands
	wait_sequence 5

	call	fn_fade_down
	call	show_screen

	mov	eax,2
	call	fn_start_music

	mov	esi,[temp_pal]
	call	fade_up_esi

	mov	esi,[seq6a_data]
	call	start_timer_sequence

	free_clr2 [seq5_data]
	free_clr2 [temp_pal]
	free_clr2 [work_screen]

	load_to fn_6b,[seq6b_data]

	mov	[command_pointer],offset anim6a_commands
	wait_sequence 6a

	mov	esi,[seq6b_data]
	call	start_timer_sequence

	free_clr2 [seq6a_data]

	mov	[command_pointer],offset anim6b_commands
	wait_sequence 6b

	free_clr2 [seq6b_data]

	call	remove_intro2

load_base_0:	mov	eax,0				;Start music 2 from section 1
	call	fn_enter_section
	mov	eax,2
	call	fn_start_music
	call	load_grids
	ret

key_pressed_eax:	mov	ebx,eax
key_pressed:	cmp	ebx,27
	je	escape_pressed
	jmp	f5_pressed

f5_pressed_in_intro: mov [work_screen],0			;work_screen not malloced in scrolling intro
f5_pressed:	mov	[tseq_frames],0			;Stop any sequences
	call	remove_intro2
	call	fn_restore_game			;allow a game to be restored
;	call	control_panel
	call	flush_key_buffer

	bt	[system_flags],sf_game_restored	;If a game was not restored then restart the game
	jnc	restore_cancelled
	ret

escape_pressed_in_intro: mov [work_screen],0		;work_screen not malloced in scrolling intro
escape_pressed:	mov	[tseq_frames],0			;Stop any sequences
	call	remove_intro2
restore_cancelled:	call	force_restart
	call	flush_key_buffer
	ret


_intro__Nv	endp




remove_intro2	proc

	push	eax

	free_if_n0 vga_data
	free_if_n0 diff_data
	free_if_n0 work_base
	free_if_n0 temp_pal
	free_if_n0 seq1a_data
	free_if_n0 seq1b_data
	free_if_n0 seq1c_data
	free_if_n0 seq1d_data
	free_if_n0 seq1e_data
	free_if_n0 seq4a_data
	free_if_n0 seq4b_data
	free_if_n0 seq4c_data
	free_if_n0 seq5_data
	free_if_n0 seq6a_data
	free_if_n0 seq6b_data
	free_if_n0 intro_text_space
	free_if_n0 intro_text_save
	free_if_n0 work_screen

	mov	eax,4
	call	set_stabilise

	pop	eax

	ret

remove_intro2	endp




show_screen	proc

	push	es

	mov	ax,[screen_segment]
	mov	es,ax
	mov	esi,[work_screen]
	clear	edi
	mov	ecx,game_screen_width*game_screen_height/4
	rep	movsd

	pop	es
	ret

show_screen	endp




intro_frame	proc

	inc	[frame_counter]

	mov	ebx,[diff_pointer]
	mov	esi,[vga_pointer]
	mov	edi,[work_screen]

non_loop_same:	movzx	ecx,bpt[ebx]			;get same count
	inc	ebx
	add	edi,ecx
	cmp	cl,-1				;255 means keep going
	je	non_loop_same

non_loop_diff:	movzx	ecx,bpt[ebx]
	inc	ebx
	rep	movsb
	cmp	bpt[ebx-1],-1
	je	non_loop_diff

	cmp	edi,[work_screen_end]
	jc	non_loop_same

	mov	[diff_pointer],ebx
	mov	[vga_pointer],esi

	call	show_screen

	ret

intro_frame	endp




intro_fx	proc

;	Start an effect

	mov	eax,8[esi]
	mov	ecx,12[esi]
	push	esi
	mov	ah,5
	clear	ch
	call	music_command
	pop	esi
	lea	esi,16[esi]
	ret

intro_fx	endp




intro_vol	proc

	mov	ecx,8[esi]
	push	esi
	mov	ah,10
	clear	ch
	call	music_command
	pop	esi
	lea	esi,12[esi]
	ret

intro_vol	endp




check_commands	proc

;	Check for sequence commands
;	esi points to command data

	mov	esi,[command_pointer]
	mov	eax,[esi]			;next frame marker
	jife	eax,no_command

	cmp	eax,[tseq_frames]			;counting down
	jc	no_command

;	Do a command

	mov	eax,4[esi]
	call	[offset command_routines + eax*4]
	mov	[command_pointer],esi

no_command:	ret


check_commands	endp




prepare_text	proc

;	Prepare a text item for printing

	mov	eax,8[esi]
	push	esi
	call	get_text
	mov	dl,-1
	mov	cx,intro_text_width
	mov	ebx,[intro_text_space]
	mov	esi,offset text_buffer
	mov	ebp,1
	call	display_text
	pop	esi
	lea	esi,12[esi]
	ret

prepare_text	endp




show_intro_text	proc

;	Show prepared text on the screen

	mov	edx,full_screen_width			;calculate address
	imul	edx,dpt 12[esi]
	add	edx,8[esi]
	push	esi

;	First save the contents

	push	edx
	mov	esi,edx
	mov	ebx,[intro_text_space]
	mov	edi,[intro_text_save]
	movzx	edx,(s ptr[ebx]).s_width
	movzx	ebx,(s ptr[ebx]).s_height
	push	ebx

	mov	[edi],esi			;save address,width and height
	mov	4[edi],ebx
	mov	8[edi],edx
	lea	edi,12[edi]

	push	ds
	mov	ds,[screen_segment]

save_loop:	push	esi
	mov	ecx,edx
	rep	movsb
	pop	esi
	lea	esi,full_screen_width[esi]
	floop	ebx,save_loop
	pop	ds
	pop	ebx

;	Now print the text

	pop	edi
	mov	esi,[intro_text_space]
	add	esi,SIZE s
	push	es
	mov	es,[screen_segment]
draw_loop:	push	edi
	mov	ecx,edx
pix_loop:	lodsb
	jife	al,no_pix
	mov	es:[edi],al
no_pix:	inc	edi
	loop	pix_loop
	pop	edi
	lea	edi,full_screen_width[edi]
	floop	ebx,draw_loop
	pop	es

	pop	esi
	lea	esi,16[esi]

	ret

show_intro_text	endp




remove_text	proc

	push	esi

	mov	esi,[intro_text_save]
	mov	edi,[esi]
	mov	ebx,4[esi]
	mov	edx,8[esi]
	lea	esi,12[esi]
	push	es
	mov	es,[screen_segment]
remove_loop:	push	edi
	mov	ecx,edx
	rep	movsb
	pop	edi
	lea	edi,full_screen_width[edi]
	floop	ebx,remove_loop
	pop	es

	pop	esi
	lea	esi,8[esi]

	ret

remove_text	endp


end32code

	end
