include_macros	equ	1
include_deb_mac	equ	1
include_flags	equ	1
include_struc	equ	1
	include include.asm


start32data

;	Header as I thought it was

;head_data	db	"Creative Voice File",1ah
;	dw	1ah
;	dw	10ah
;	dw	1129h

;	Header for sound driver

head_size	equ	22

head_data	db	20 dup (?)
	dw	head_size	;pointer to start of data

	align 4

voc_progress	dd	0

end32data


start32code

proc_start	_play_voc_data__Npcii

pvd_data	equ	16
pvd_size	equ	12
pvd_chan	equ	8


;	make the header

	push	es
	push	ds
	pop	es

	mov	esi,offset head_data

	mov	edi,pvd_chan[ebp]

	mov	edi,[offset voc_work_space + edi*4]
	mov	ecx,head_size
	rep	movsb

	mov	eax,pvd_size[ebp]			;make up header and size
	inc	eax
	inc	eax
	shl	eax,8
	mov	al,1
	stosd

	mov	ax,0aah
	stosw

	mov	esi,pvd_data[ebp]
	mov	ecx,pvd_size[ebp]

	rep	movsb

	mov	ax,504h
	mov	cx,7fh

	mov	ah,101

	add	ah,pvd_chan[ebp]
	add	ah,pvd_chan[ebp]

	clear	ch

;	Wait until a timer interrupt has occured to prevent any conflicts which may or may not happen

ifndef no_timer
	btr	[system_flags],sf_timer_tick
pv_wait:	btr	[system_flags],sf_timer_tick
	jnc	pv_wait
endif
	call	music_command

	pop	es

ifdef with_voc_editor
	mov	eax,[voc_work_space]
endif

proc_end	_play_voc_data__Npcii,12




voc_progress_report2	proc

;	check if a voc file is playing and if it has finished

;	al holds channel no to check

	bt	[system_flags],sf_voc_playing
	jnc	not_playing

	push	eax
	mov	ah,0ch
	;mov	ax,0cffh
	call	music_command

ifdef debug_42
	mov	eax,[music_command_return_value]
	mov	[voc_progress],eax
endif

	pop	ebx
	mov	eax,[music_command_return_value]		;try it twice, save first one
	push	eax

	mov	al,bl
	mov	ah,0ch
	;mov	ax,0cffh
	call	music_command

	pop	eax
	jifne	eax,still_playing

	test	[music_command_return_value],-1		;0 when it is all over
	jne	still_playing

	btr	[system_flags],sf_voc_playing

ifdef with_replay
	mov	eax,-4
	call	replay_record_event
endif

still_playing:
not_playing:	ret

voc_progress_report2	endp



end32code


;--------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------


ifdef with_voc_editor

max_no_lines	equ	10

start32data

text_data	dd	max_no_lines dup (0)

;voc_data_end	dd	0				;used to clear ends of old messages

end32data




start32code
	public	_redisplay_line__Nipc


proc_start	_redisplay_line__Nipc

rl_line	equ	12
rl_data	equ	8

	mov	edi,rl_line[ebp]

not_there:	mov	dl,-1
	mov	cx,255
	mov	ebx,[offset text_data + edi*4]
	mov	esi,rl_data[ebp]
	push	ebp
	push	edi
	clear	ebp
	call	display_text
	pop	edi
	mov	[offset text_data + edi*4],eax
	pop	ebp

proc_end	_redisplay_line__Nipc,8




proc_start	_display_lines__Nv


;	put the lines on to the screen

	mov	ecx,max_no_lines
	mov	esi,offset text_data
	push	es
	mov	es,[screen_segment]
	mov	edi,20*full_screen_width+20

line_loop:	lodsd					;address of data
	jife	eax,no_line

	push	ecx
	push	esi
	push	edi

	movzx	ebx,(s ptr[eax]).s_width
	movzx	edx,(s ptr[eax]).s_height
	lea	esi,SIZE s[eax]

pix_loop:	push	edi
	mov	ecx,ebx
	rep	movsb
	pop	edi
	lea	edi,full_screen_width[edi]
	floop	edx,pix_loop

	pop	edi
	pop	esi
	lea	edi,(12*full_screen_width)[edi]
	pop	ecx

no_line:	loop	line_loop

	pop	es

proc_end	_display_lines__Nv


proc_start	_bincpy__Npvpvi		;(char *to, char *from, int count)

bcz_to	equ	16
bcz_from	equ	12
bcz_count	equ	8

	mov	esi,bcz_from[ebp]
	mov	edi,bcz_to[ebp]
	mov	ecx,bcz_count[ebp]

	cmp	esi,edi			;check direction
	je	moved
	jc	upz

;	move down in memory

	rep	movsb
	jmp	moved

;	move up in memory so do opposite direction

upz:	add	esi,ecx
	dec	esi
	add	edi,ecx
	dec	edi
	std
	rep	movsb
	cld

moved:

proc_end	_bincpy__Npvpvi,12

end32code

endif
	end
