include_macros	equ	1
include_deb_mac	equ	1
include_flags	equ	1
	include include.asm


erm	macro label,text
label	db	text,".",10,13,"$"
endm

start32data
	extrn	int8_vector:dword
	extrn	int9_vector:dword
	extrn	int24_vector:dword

	align 4

no_of_error_messages	equ	11

error_messages	dd	en_int_error			;english
	dd	en_game_over
	dd	en_no_vga_card
	dd	en_invalid_dos
	dd	en_no_dnr_file
	dd	en_disk_read_error
	dd	en_dsk_f_err
	dd	en_no_memory
	dd	en_dnr_f_err
	dd	en_save_game_error
	dd	en_no_mouse_error

	dd	gm_int_error			;german
	dd	gm_game_over
	dd	gm_no_vga_card
	dd	gm_invalid_dos
	dd	gm_no_dnr_file
	dd	gm_disk_read_error
	dd	gm_dsk_f_err
	dd	gm_no_memory
	dd	gm_dnr_f_err
	dd	gm_save_game_error
	dd	gm_no_mouse_error

	dd	fr_int_error			;french
	dd	fr_game_over
	dd	fr_no_vga_card
	dd	fr_invalid_dos
	dd	fr_no_dnr_file
	dd	fr_disk_read_error
	dd	fr_dsk_f_err
	dd	fr_no_memory
	dd	fr_dnr_f_err
	dd	fr_save_game_error
	dd	fr_no_mouse_error

	dd	us_int_error			;us
	dd	us_game_over
	dd	us_no_vga_card
	dd	us_invalid_dos
	dd	us_no_dnr_file
	dd	us_disk_read_error
	dd	us_dsk_f_err
	dd	us_no_memory
	dd	us_dnr_f_err
	dd	us_save_game_error
	dd	us_no_mouse_error

	dd	sw_int_error			;sw
	dd	sw_game_over
	dd	sw_no_vga_card
	dd	sw_invalid_dos
	dd	sw_no_dnr_file
	dd	sw_disk_read_error
	dd	sw_dsk_f_err
	dd	sw_no_memory
	dd	sw_dnr_f_err
	dd	sw_save_game_error
	dd	sw_no_mouse_error

	dd	it_int_error			;sw
	dd	it_game_over
	dd	it_no_vga_card
	dd	it_invalid_dos
	dd	it_no_dnr_file
	dd	it_disk_read_error
	dd	it_dsk_f_err
	dd	it_no_memory
	dd	it_dnr_f_err
	dd	it_save_game_error
	dd	it_no_mouse_error

	dd	pt_int_error			;sw
	dd	pt_game_over
	dd	pt_no_vga_card
	dd	pt_invalid_dos
	dd	pt_no_dnr_file
	dd	pt_disk_read_error
	dd	pt_dsk_f_err
	dd	pt_no_memory
	dd	pt_dnr_f_err
	dd	pt_save_game_error
	dd	pt_no_mouse_error

	dd	es_int_error			;sw
	dd	es_game_over
	dd	es_no_vga_card
	dd	es_invalid_dos
	dd	es_no_dnr_file
	dd	es_disk_read_error
	dd	es_dsk_f_err
	dd	es_no_memory
	dd	es_dnr_f_err
	dd	es_save_game_error
	dd	es_no_mouse_error

;--------------------------------------------------------------------------------------------------

;	English errors

	erm	en_int_error,"Internal program error"
ifdef s1_demo
en_game_over	db	"Thank you for playing 'Beneath A Steel Sky'.",10,13,"Coming soon from Virgin",10,13,"$"
else ;s1_demo
en_game_over	db	"Game over player one.",10,13,"BE VIGILANT",10,13,"$"
endif ;s1_demo
	erm	en_no_vga_card,"Game needs VGA/SVGA graphics card"
	erm	en_no_dnr_file,"Could not find SKY.DNR"
	erm	en_invalid_dos,"Game needs DOS 2.0 or later"
	erm	en_disk_read_error,"Error reading data disk"
	erm	en_dsk_f_err,"Could not find SKY.DSK"
	erm	en_no_memory,"Insufficient memory or hard disk space to play the game"
	erm	en_dnr_f_err,"Invalid sky.dnr"
	erm	en_save_game_error,"Invalid save game version"
	erm	en_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------

;	German errors

	erm	gm_int_error,"Internal program error"
ifdef s1_demo
gm_game_over	db	"Vielen Dank fÅr das Spielen von 'Beneath A Steel Sky'.",10,13,"DemnÑchst erhÑltlich von Virgin",10,13,"$"
else ;s1_demo
gm_game_over	db	"Das Spiel ist aus.",10,13,"SEI WACHSAM",10,13,"$"
endif ;s1_demo
	erm	gm_no_vga_card,"Dieses Spiel erfordert eine VGA/SVGA-Grafikkarte"
	erm	gm_no_dnr_file,"Kann SKY.DNR nicht finden"
	erm	gm_invalid_dos,"Spiel benotigt DOS 2.0 oder hoher"
	erm	gm_disk_read_error,"Datendiskette fehlerhaft"
	erm	gm_dsk_f_err,"Kann SKY.DSK nicht finden"
	erm	gm_no_memory,"Zuwenig Speicher oder freie Festplattenkapazitat vorhanden, um zu spielen"
	erm	gm_dnr_f_err,"sky.dnr fehlerhaft"
	erm	gm_save_game_error,"Fehlerhaft Spielstand"
	erm	gm_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------

;	French errors

	erm	fr_int_error,"Erreur interne du programme"
ifdef s1_demo


fr_game_over	db	"Merci d'avoir jouÇ Ö "
	db	'"Beneath a Steel Sky".',10,13,"Bientìt distribuÇ par Virgin",10,13,"$"
else ;s1_demo
fr_game_over	db	"Game over joueur 1.",10,13,"SOYEZ VIGILANTS",10,13,"$"
endif ;s1_demo
	erm	fr_no_vga_card,"Carte graphique VGA/SVGA nÇcessaire"
	erm	fr_no_dnr_file,"Fichier SKY.DNR absent"
	erm	fr_invalid_dos,"DOS 2.0 ou plus nÇcessaire"
	erm	fr_disk_read_error,"Erreur de lecture"
	erm	fr_dsk_f_err,"SKY.DSK non trouvÇ"
	erm	fr_no_memory,"MÇmoire ou place sur le disque dur insuffisante"
	erm	fr_dnr_f_err,"Fichier SKY.DRN invalide"
	erm	fr_save_game_error,"Version de sauvegarde invalide"
	erm	fr_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------
;	US errors

	erm	us_int_error,"Internal program error"
ifdef s1_demo
us_game_over	db	"Vielen Dank fÅr das Spielen von 'Beneath A Steel Sky'.",10,13,"DemnÑchst erhÑltlich von Virgin",10,13,"$"
else ;s1_demo
us_game_over	db	"Game over player one.",10,13,"BE VIGILANT",10,13,"$"
endif ;s1_demo
	erm	us_no_vga_card,"Game needs VGA/SVGA graphics card"
	erm	us_no_dnr_file,"Could not find SKY.DNR"
	erm	us_invalid_dos,"Game needs DOS 2.0 or later"
	erm	us_disk_read_error,"Error reading data disk"
	erm	us_dsk_f_err,"Could not find SKY.DSK"
	erm	us_no_memory,"Insufficient memory or hard disk space to play the game"
	erm	us_dnr_f_err,"Invalid sky.dnr"
	erm	us_save_game_error,"Invalid save game version"
	erm	us_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------


;	Swedish errors

	erm	sw_int_error,"Internal program error"
ifdef s1_demo
sw_game_over	db	"Vielen Dank fÅr das Spielen von 'Beneath A Steel Sky'.",10,13,"DemnÑchst erhÑltlich von Virgin",10,13,"$"
else ;s1_demo
sw_game_over	db	"SPELET ",142,"R SLUT, Agent 1.",10,13,"VAR VAKSAM",10,13,"$"
endif ;s1_demo
	erm	sw_no_vga_card,"Game needs VGA/SVGA graphics card"
	erm	sw_no_dnr_file,"Could not find SKY.DNR"
	erm	sw_invalid_dos,"Game needs DOS 2.0 or later"
	erm	sw_disk_read_error,"Error reading data disk"
	erm	sw_dsk_f_err,"Could not find SKY.DSK"
	erm	sw_no_memory,"Insufficient memory or hard disk space to play the game"
	erm	sw_dnr_f_err,"Invalid sky.dnr"
	erm	sw_save_game_error,"Invalid save game version"
	erm	sw_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------
;	Italian errors

	erm	it_int_error,"Internal program error"
ifdef s1_demo
it_game_over	db	"Vielen Dank fÅr das Spielen von 'Beneath A Steel Sky'.",10,13,"DemnÑchst erhÑltlich von Virgin",10,13,"$"
else ;s1_demo
it_game_over	db	"Game over giocatore 1.",10,13,"SIATE VIGILANTI",10,13,"$"
endif ;s1_demo
	erm	it_no_vga_card,"Game needs VGA/SVGA graphics card"
	erm	it_no_dnr_file,"Could not find SKY.DNR"
	erm	it_invalid_dos,"Game needs DOS 2.0 or later"
	erm	it_disk_read_error,"Error reading data disk"
	erm	it_dsk_f_err,"Could not find SKY.DSK"
	erm	it_no_memory,"Insufficient memory or hard disk space to play the game"
	erm	it_dnr_f_err,"Invalid sky.dnr"
	erm	it_save_game_error,"Invalid save game version"
	erm	it_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------
;	Portuguese errors

	erm	pt_int_error,"Erro interno do programa"
ifdef s1_demo
pt_game_over	db	"Obrigado por ter jogado 'Beneath A Steel Sky'.",10,13,"Distribu°do por Virgin.",10,13,"$"
else ;s1_demo
pt_game_over	db	"Fim de jogo para o jogador um.",10,13,"BE VIGILANT",10,13,"$"
endif ;s1_demo
	erm	pt_no_vga_card,"O jogo necessita de uma placa gr†fica VGA/SVGA"
	erm	pt_no_dnr_file,"Ficheiro SKY.DNR ausente"
	erm	pt_invalid_dos,"O Jogo necessita do DOS 2.0 ou superior"
	erm	pt_disk_read_error,"Erro na leitura da disquete"
	erm	pt_dsk_f_err,"Ficheiro SKY.DSK ausente"
	erm	pt_no_memory,"Insuficiente mem¢ria ou espaáo em disco"
	erm	pt_dnr_f_err,"Ficheiro SKY.DRN inv†lido"
	erm	pt_save_game_error,"VersÑo inv†lida do jogo gravado"
	erm	pt_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------

;	Spanish errors

	erm	es_int_error,"Internal program error"
ifdef s1_demo
es_game_over	db	"Gracias por jugar 'Beneath A Steel Sky'.",10,13,"$"
else ;s1_demo
es_game_over	db	"Game over player one.",10,13,"BE VIGILANT",10,13,"$"
endif ;s1_demo
	erm	es_no_vga_card,"Game needs VGA/SVGA graphics card"
	erm	es_no_dnr_file,"Could not find SKY.DNR"
	erm	es_invalid_dos,"Game needs DOS 2.0 or later"
	erm	es_disk_read_error,"Error reading data disk"
	erm	es_dsk_f_err,"Could not find SKY.DSK"
	erm	es_no_memory,"Insufficient memory or hard disk space to play the game"
	erm	es_dnr_f_err,"Invalid sky.dnr"
	erm	es_save_game_error,"Invalid save game version"
	erm	es_no_mouse_error,"Mouse Driver not found"

;--------------------------------------------------------------------------------------------------


	align 4

ifdef debug_42
error_check	dd	0
endif

end32data


start32code

	extrn	load_file:near
	extrn	stabilise:near
ifdef mem_check
	extrn	check_mem:near
endif


error_routine	proc

;	Print an error on to the screen

;	eax is error number

ifdef  debug_42
	pop	ecx				;get return address into ebx
	push	ecx				;and replace it
	printf "----error: routine address 0x%x ----",ecx

	test	[error_check],-1			;stop recursive errors
	jne	stop_error
	mov	[error_check],1
endif

;	Restore the pc status, print the error and quit

	call	restore_pc_status

	mov	ebx,[_language]			;offset into language
	imul	ebx,ebx,no_of_error_messages
	add	eax,ebx

	shl	eax,2
	add	eax,offset error_messages
	mov	edx,[eax]

ifdef debug_42	;put error in file
	push	edx
endif

	mov	ah,9
	dos_int

ifdef debug_42
	pop	esi
	mov	edi,esi
sch_lop:	cmp	bpt[esi],10
	je	got_dllr
	inc	esi
	jmp	sch_lop
got_dllr:	mov	bpt[esi],0
	printf "%s",edi
endif

ifdef mem_check
	call	check_mem
endif
stop_error:	mov	ax,4c01h
	int	21h

error_routine	endp




proc_start	_pc_restore__Nv

;	Quit to dos after intercept

	call	restore_pc_status

proc_end	_pc_restore__Nv




restore_pc_status	proc	private

	cld

	push	eax

	bt	[system_flags],sf_music_bin
	jnc	no_music_set

	mov	ah,6
	call	music_command
	mov	ah,3
	call	music_command

	mov	ax,100h
	call	music_command
	mov	ah,3
	call	music_command

no_music_set:	;Check if the timer interrupt has been redirected

	btr	[system_flags],sf_timer
	jnc	timer_not_set

	mov	ebx,int8_vector[8]			;reset timer interrupt
	push	ds
	lds	edx,fword ptr int8_vector[0]
	mov	cl,8
	mov	ax,2507h
	int	21h
	pop	ds

;	Restore the timer to its correct speed

;	What the #@$! is this!!!!

	mov	cx,-1

	mov	al,36h
	out	43h,al

	jmp	short f1
f1:	jmp	short f2
f2:	mov	al,cl
	out	40h,al
	jmp	short f3
f3:	jmp	short f4
f4:	mov	al,ch
	out	40h,al


timer_not_set:	;Check if keyboard has been redirected

	btr	[system_flags],sf_keyboard
	jnc	keyboard_not_set

	mov	ebx,int9_vector[8]			;reset timer interrupt
	push	ds
	lds	edx,fword ptr int9_vector[0]
	mov	cl,9
	mov	ax,2507h
	int	21h
	pop	ds

keyboard_not_set:	;Check if critical error has been redirected

	btr	[system_flags],sf_crit_err
	jnc	crit_err_not_set

	mov	ebx,int24_vector[8]			;reset timer interrupt
	push	ds
	lds	edx,fword ptr int24_vector[0]
	mov	cl,24h
	mov	ax,2507h
	int	21h
	pop	ds

crit_err_not_set:	;check if the screen mode has been changed

	btr	[system_flags],sf_graphics
	jnc	no_graphics

	mov	al,[original_screen_mode]
	xor	ah,ah
	screen_int

no_graphics:	;reset the mouse regardless

	mouse_int 0

	pop	eax

	ret

restore_pc_status	endp


end32code

	end
