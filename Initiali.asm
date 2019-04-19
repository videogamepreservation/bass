include_macros	equ	1
include_deb_mac	equ	1
include_error_codes equ	1
	include include.asm

start32data
	align 4

system_flags	dd	0				;Lots of lovely flags

computer_speed	dd	0				;computer speed indicator

end32data


start32code
	public	int_08_off
	public	int_09_off

	extrn	timer_handler:far
	extrn	init_mouse:near
	extrn	initialise_disk:near
	extrn	init_script:near
	extrn	initialise_memory:near
	extrn	initialise_screen:near
	extrn	initialise_grids:near
	extrn	initialise_router:near
	extrn	initialise_text:near
	extrn	init_music:near
	extrn	init_timer:near
	extrn	load_fixed_items:near


int_08_off	dw	?	;Original interrupt 8 offset
int_08_seg	dw	?	;Original interrupt 8 segment

int_09_off	dw	?	;Original interrupt 09 offset
int_09_seg	dw	?	;Original interrupt 09 segment

int_24_off	dw	?	;Original interrupt 24 offset
int_24_seg	dw	?	;Original interrupt 24 segment



_initialise__Nv	proc

;	Called at the very beginning of the program.

	call	check_vga_dos				;check for a vga card and dos 2.0+
	call	initialise_memory				;Set up memory control (mem_check set only)
	call	init_timer				;initialise timer and keyboard interrupts

ifndef final_version
;	Announce any conditional assembly

	inform_debug	no_timer,"Timer disabled"
	inform_debug	no_music,"Music disabled"
	inform_debug	no_keyboard,"Keyboard intercept disabled"
	inform_debug	mem_check,"Memory check enabled"
	inform_debug	clicking_optional,"Text clicking optional"

	inform_debug	debug_42,"Debugging on"
	inform_debug	cmd_options,"Debug command options enabled"
	inform_debug	with_voc_editor,"VOC editor installed"
	inform_debug	file_order_chk,"File order checking on"
	inform_debug	dont_check_rlnd,"Roland not supported"
	inform_debug	ar_debug,"Ar debug"
	inform_debug	selective_intro,"Selective cd intro"
	inform_debug	language_testing,"LANGUAGE TESTING ONLY"

ifdef inform_debug_on
	inform_debug	current_version_text2,"%s",offset current_version
	inform_debug	inform_debug_on,"Press any key..."
	extrn	fetch_key:near
idb_wait:	call	fetch_key
	je	idb_wait
	cherror ax,e,27,em_game_over
yo_ho_ho	equ	1
	inform_debug	yo_ho_ho,"Loading..."
endif ;inform_debug_on

endif ;final_version

ifdef debug_42
	bts	[_debug_flag],31				;If escape not pressed we can start the debug file
endif

;	Set up anything and everything

;	Music allocates dos memory (16 bit) so allocate it
;	before anything else uses it all up

	call	init_music
	call	initialise_screen
	call	initialise_disk				;Check the data disk exists and load in some things

	call	init_virgin				;Bring on virgin screen

	call	init_mouse				;Set up the mouse

	call	init_script				;load in the script files

	call	initialise_grids				;Load in the grids

	call	initialise_router				;set router info

	call	initialise_text				;load in character set

	;call	init_music

	call	load_fixed_items
ifdef with_replay
	call	start_up_replay_file
endif

;	Do a simple count to give an idea of how fast the computer is

ifndef no_timer
	mov	[game_50hz_count],0	;wait for start of intrpt
wait_start:	test	[game_50hz_count],-1
	je	wait_start

	mov	[game_50hz_count],0	;wait for next intrpt
	clear	eax
wait_next:	inc	eax
	test	[game_50hz_count],-1
	je	wait_next

;	eax is the count

	mov	[computer_speed],eax
else
	mov	[computer_speed],100000
endif


	ret

_initialise__Nv	endp




;critical_error_handler proc private
;
;	iret
;
;critical_error_handler	endp




check_vga_dos	proc private

;	Check for a vga card
	mov	ax,1a00h
	screen_int
	cmp	al,1ah					;1a means vga card
	jne	monitor_nok

;	Check for dos version 2 or upwards
	mov	ah,30h
	dos_int
	cmp	al,2					;need dos 2.0 or greater
	jc	dos_nok
	ret

monitor_nok:	program_error	em_no_vga
dos_nok:	program_error	em_inv_dos

check_vga_dos	endp

end32code


	end
