include_macros	equ	1
include_deb_mac	equ	1
include_flags	equ	1
include_keyboard_codes equ 1
include_error_codes equ	1
include_language_codes equ 1
	include include.asm



start32data
	align 4

	public	game_50hz_count
	public	code16_seg
	public	int8_vector
	public	int9_vector
	public	int24_vector

	extrn __x386_zero_base_selector:word	;data selector

stabilise_count	dd	4			;no of 1/50 seconds to wait


timer_data_start	dd	?

int8_vector	dd	?			;original protected mode offset
	dd	?			;original protected mode cs value
	dd	?			;original real mode vector

int9_vector	dd	?			;original protected mode offset
	dd	?			;original protected mode cs value
	dd	?			;original real mode vector

int24_vector	dd	?			;original protected mode offset
	dd	?			;original protected mode cs value
	dd	?			;original real mode vector


ds_val	dw	?			;storage for handler ds
code16_seg	dw	?			;16 bit code segment

ifndef with_replay
random	dd	12345678h
endif

timer_stack	db	1000 dup (?)
timer_stack_end	dd	0

music_command_return_value dd 0

game_50hz_count	dd	?			;needs renaming
relative_50hz_count dd	?

ifdef with_screen_saver
sssss_count	dd	?			;screen saver counter
endif

small_count	db	3			;convert 50Hz - 18.2 Hz
big_count	db	0
cur_mus_cmd	db	?			;the command music_command is processing

	align	4

tseq_frames	dd	0
tseq_data	dd	0
tseq_counter	dd	0

ifdef intro_halt
intro_halted	dd	0
endif

;	Keyboard control

ifndef no_keyboard	;if no keyboard then key equates > 255, won't fit int a byte

key_status	dw	0			;bit 0:	shift down

ks_shift	equ	0
ks_control	equ	1
ks_alt	equ	2

key_buffer	db	key_buffer_size dup (0)	;buffer for key presses / releases
	align 4

key_buffer_start	dd	key_buffer
key_buffer_end	dd	key_buffer

key_table2	db	128 dup (0)		;key table, which keys are down or up

;	my conversion table

;	{key} , shift {key} , cntrl {key} , alt {key}

my_asctab	db	0,0,0,0
	db	27,27,27,27
	db	'1','!',0,key_alt_1
	db	'2','"',0,key_alt_2
	db	'3','œ',0,key_alt_3
	db	'4','$',0,0
	db	'5','%',0,0
	db	'6','^',0,0
	db	'7','&',0,0
	db	'8','*',0,0

	db	'9','(',0,0			;10
	db	'0',')',0,0
	db	'-','_',0,0
	db	'=','+',0,0
	db	8,8,8,8
	db	9,9,9,9
	db	'q','Q',17,0
	db	'w','W',23,0
	db	'e','E',5,0
	db	'r','R',18,0

;	20

	db	't','T',20,0
	db	'y','Y',25,0
	db	'u','U',21,0
	db	'i','I',9,0
	db	'o','O',15,0
	db	'p','P',16,0
	db	'[','{',0,0
	db	']','}',0,0
	db	13,13,13,13
	db	0,0,0,0			;control

	db	'a','A',1,0			;30
	db	's','S',19,0
	db	'd','D',4,0
	db	'f','F',6,0
	db	'g','G',7,0
	db	'h','H',8,0
	db	'j','J',10,0
	db	'k','K',11,0
	db	'l','L',12,0
	db	';',':',0,0

;	40

	db	"'",'@',0,0
	db	'`','ª',0,0
	db	0,0,0,0		;left shift
	db	'#','~',0,0
	db	'z','Z',26,0
	db	'x','X',24,0
	db	'c','C',3,0
	db	'v','V',22,0
	db	'b','B',2,0
	db	'n','N',14,0

;	50

	db	'm','M',13,0
	db	',','<',0,0
	db	'.','>',0,0
	db	'/','?',0,0
	db	0,0,0,0		;right shift
	db	'*','*',0,0
	db	0,0,0,0		;alt
	db	' ',' ',' ',' '
	db	0,0,0,0			;caps lock
	db	key_f1,key_f1,key_f1,key_f1	;59

;	60

	db	key_f2,key_f2,key_f2,key_f2
	db	key_f3,key_f3,key_f3,key_f3
	db	key_f4,key_f4,key_f4,key_f4
	db	key_f5,key_f5,key_f5,key_f5
	db	key_f6,key_f6,key_f6,key_f6
	db	key_f7,key_f7,key_f7,key_f7
	db	key_f8,key_f8,key_f8,key_f8
	db	key_f9,key_f9,key_f9,key_f9
	db	key_f10,key_f10,key_f10,key_f10
	db	0,0,0,0		;num lock

;	70

	db	key_scroll_lock,key_scroll_lock,key_scroll_lock,key_scroll_lock
	db	0,0,0,0		;home
	db	0,0,0,0		;up arrow
	db	0,0,0,0		;page up
	db	'-','-',0,0
	db	0,0,0,0		;left arrow
	db	0,0,0,0		;middle of key pad
	db	0,0,0,0		;right arrow
	db	'+','+',0,0
	db	0,0,0,0		;end

;	80

	db	0,0,0,0		;down arrow
	db	0,0,0,0		;page down
	db	0,0,0,0		;insert
	db	key_delete,key_delete,key_delete,key_delete		;delete
	db	0,0,0,0
	db	0,0,0,0
	db	'\','|',0,0
	db	key_f11,key_f11,key_f11,key_f11
	db	key_f12,key_f12,key_f12,key_f12
	db	0,0,0,0
endif

sec_code	macro		a,b,c,d,e,f

	db	f,e,d,c,b,a
endm

security_codes	db	0 dup (0)
	sec_code	7,0,4,7,2,3
	sec_code	5,2,0,2,2,8
	sec_code	2,9,3,9,4,4
	sec_code	2,9,3,8,5,2
	sec_code	2,5,7,3,0,3
	sec_code	1,1,3,3,2,2
	sec_code	1,1,3,6,6,8
	sec_code	1,2,7,8,1,3
	sec_code	4,9,2,1,3,2
	sec_code	1,8,0,4,0,0
	sec_code	5,2,0,3,9,4
	sec_code	1,2,7,1,7,4
	sec_code	3,0,5,6,6,2
	sec_code	3,8,6,2,5,3
	sec_code	7,0,4,4,1,7
	sec_code	2,8,4,7,6,4
	sec_code	3,8,6,6,5,1
	sec_code	8,1,5,9,3,1
	sec_code	2,8,4,2,9,1
	sec_code	2,5,7,9,2,5


	align 4

timer_data_end	dd	?


end32data


ifdef with_replay
start32save_data
random	dd	12345678h
end32save_data
endif


start32code


start_timer_sequence	proc

;	Start off a timer sequence

;	esi points to sequence data

	movzx	eax,bpt[esi]			;get no of frames
	inc	esi
	;dec	eax
	mov	[tseq_data],esi
	mov	[tseq_counter],sequence_count
	mov	[tseq_frames],eax

	ret

start_timer_sequence	endp




do_timer_sequence	proc

;	Do a timer sequence frame

	test	[tseq_frames],-1			;is there a sequence
	je	no_seq

ifdef intro_halt
	test	[intro_halted],-1
	jne	no_seq
endif

	dec	[tseq_counter]
	jne	no_seq
	mov	[tseq_counter],sequence_count

	push	es
	mov	es,[screen_segment]

	clear	edi
	clear	ecx
	clear	eax
	mov	esi,[tseq_data]

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

	pop	es	

	mov	[tseq_data],esi
	dec	[tseq_frames]

no_seq:	ret

do_timer_sequence	endp


stabilise	proc

ifndef no_timer	;Real timing loop

	mov	eax,[stabilise_count]
stabilise_loop:	cmp	eax,[game_50hz_count]
	jnbe	stabilise_loop
	mov	[game_50hz_count],0

else
	mov	eax,[stabilise_count]
	sub	eax,1
	jbe	stab_dun
stab_loop:	push	eax
	call	frame
	pop	eax
	floop	eax,stab_loop
stab_dun:

endif

	ret

stabilise	endp




wait_50hz	proc

;	loop until a timer interupt occurs

ifndef no_timer
	btr	[system_flags],sf_timer_tick
	jnc	wait_50hz
endif
	ret

wait_50hz	endp




wait_relative	proc

;	wait until relative_50hz_count exceeds eax, then reset it

;	Return if escape pressed

	push	eax
	call	fetch_key
	je	no_key
	cmp	ax,27
	je	escape
	cmp	ax,key_f5
	je	escape
no_key:	pop	eax

ifndef no_timer
	cmp	[relative_50hz_count],eax
	jc	wait_relative
endif
	mov	[relative_50hz_count],0			;keep on for a minimum time

	clc
	ret

escape:	mov	ebx,eax
	pop	eax
	stc
	ret

wait_relative	endp






set_stabilise	proc

;	eax is stabilise count

	mov	[stabilise_count],eax
	ret

set_stabilise	endp


init_timer	proc

	push	es

	mov	[ds_val],ds				;save default ds

ifndef no_timer
	push	cs
	pop	es					;lock timer handler memory
	mov	ax,252bh
	mov	bx,501h
	mov	ecx,offset DGROUP:timer_handler
	mov	edx,offset DGROUP:timer_handler_end
	sub	edx,ecx
	int	21h
	jc	it_error

	push	ds
	pop	es					;lock timer handler data
	mov	ax,252bh
	mov	bx,501h
	mov	ecx,offset DGROUP:timer_data_start
	mov	edx,offset DGROUP:timer_data_end
	sub	edx,ecx
	int	21h
	jc	it_error

	mov	ax,2502h					;get protected mode vector
	mov	cl,8
	int	21h
	mov	int8_vector[0],ebx
	mov	int8_vector[4],es
	mov	ax,2503h					;get real mode pointer
	int	21h
	mov	int8_vector[8],ebx

	mov	ax,2506h					;hook real and protected mode interrupt
	push	ds
	push	cs
	pop	ds
	mov	edx,offset timer_handler
	int	21h
	pop	ds

;--------------------------------------------------------------------------------------------------

;	What the #@$! is this!!!!

	mov	cx,23864					;set pc clock to give 50hz interrupts

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

	bts	[system_flags],sf_timer

endif

ifndef no_keyboard
;	Hook the keyboard interupt while we are at it

	mov	ax,2502h					;get protected mode vector
	mov	cl,9
	int	21h
	mov	int9_vector[0],ebx
	mov	int9_vector[4],es
	mov	ax,2503h					;get real mode pointer
	int	21h
	mov	int9_vector[8],ebx

	mov	ax,2506h					;hook real and protected mode interrupt
	push	ds
	push	cs
	pop	ds
	mov	edx,offset keyboard_handler
	int	21h
	pop	ds

	bts	[system_flags],sf_keyboard

;	Swap z and y for german version

	cmp	[_language],german_code
	jne	not_germ

	mov	bpt (44*4)[my_asctab],'y'
	mov	bpt (44*4+1)[my_asctab],'Y'
	mov	bpt (21*4)[my_asctab],'z'
	mov	bpt (21*4+1)[my_asctab],'Z'
not_germ:

endif

;	Hook the critical error interupt while we are at it

	mov	ax,2502h					;get protected mode vector
	mov	cl,24h
	int	21h
	mov	int24_vector[0],ebx
	mov	int24_vector[4],es
	mov	ax,2503h					;get real mode pointer
	int	21h
	mov	int24_vector[8],ebx

	mov	ax,2506h					;hook real and protected mode interrupt
	push	ds
	push	cs
	pop	ds
	mov	edx,offset crit_err_handler
	int	21h
	pop	ds

	bts	[system_flags],sf_crit_err

	pop	es
	ret

it_error:	cherror al,e,al,em_internal_error

init_timer	endp



timer_handler	proc

	pushf
	push	eax
	push	es

	;mov	ax,ss
	;mov	es,ax
	;mov	eax,esp
	;
	;mov	ss,cs:[ds_val]				;use cs to load ss
	;mov	esp,offset timer_stack_end

	push_all
	cld

	mov	ds,cs:[ds_val]				;use cs to load ds

	bts	[system_flags],sf_timer_tick

;--------------------------------------------------------------------------------------------------
;	Poll music driver

	mov	eax,300h
	call	music_command
;--------------------------------------------------------------------------------------------------
;	Game timing

	inc	[game_50hz_count]				;absolute count (stabilise)
	inc	[relative_50hz_count]			;relative count (intro)
ifdef with_screen_saver
	inc	[sssss_count]
endif

;--------------------------------------------------------------------------------------------------


no_security:	call	do_timer_sequence

;--------------------------------------------------------------------------------------------------

;	change 50Hz to 18.2 Hz
;	This worked in Lure, I think

	sub	[small_count],1
	jne	no_timmy

	mov	al,2

	cmp	[big_count],68
	jnc	ni_timmy

	add	al,1

ni_timmy:	mov	[small_count],al
	add	[big_count],1

	cmp	[big_count],91
	jc	nu_timmy

	mov	[big_count],0

nu_timmy:
ifndef with_replay
	call	do_random
endif

	pop_all

	;mov	esp,eax
	;mov	ax,es
	;mov	ss,ax

	pop	es
	pop	eax
	popf

	jmp	fword ptr cs:int8_vector		;do system bits & things

no_timmy:	mov	al,20h	;Hmmmmm?????
	out	20h,al

na_timmy:	pop_all

	;mov	esp,eax
	;mov	ax,es
	;mov	ss,ax

	pop	es
	pop	eax
	popf

	iretd

timer_handler	endp




do_random	proc

	mov	eax,[random]
	imul	eax,eax,41c64e6dh
	add	eax,3039h
	mov	[random],eax
	ret

do_random	endp




music_command	proc

;	only works when driver is initialised

	push_all

;ifdef debug_42
;	cmp	ah,3
;	je	jjjj
;	printf2 "music command %x %x %x %x",eax,ebx,ecx,edx
;jjjj:
;endif

	bt	[system_flags],sf_music_bin
	jnc	no_driver

ifdef with_replay	;don't do sounds if speed replaying

	cmp	ah,5
	jne	do_up

	call	check_replay_skip
	jc	no_driver

do_up:
endif
	sti

	mov	[cur_mus_cmd],ah			;save command so that music_command_return_val stays clean

	movzx	esi,[code16_seg]			;pass data
	shl	esi,4				;absolute address
	mov	es,__x386_zero_base_selector	;point to base memory

	mov	es:mc_ax[esi],ax
	mov	es:mc_bx[esi],bx
	mov	es:mc_cx[esi],cx
	mov	es:mc_dx[esi],dx

	mov	bx,[code16_seg]			;now call driver init code
	shl	ebx,16
	mov	bx,offset music_command_16
	clear	ecx				;no parameters
	mov	ax,250eh
	int	21h

	cmp	[cur_mus_cmd],0ch			;only permit return values for check fx channel
	jne	no_driver

	mov	[wpt music_command_return_value],ax
	;printf "ret %x",eax

no_driver:	pop_all

	ret

music_command	endp


ifndef no_keyboard	;if no keyboard then tables and fing not defined

keyboard_handler	proc

	push	ds
	mov	ds,cs:[ds_val]				;use cs to load ds
	push	eax
	push	ebx
	push	ecx
ifdef with_screen_saver
	mov	[sssss_count],0
endif
	in	al,60h		; keyboard data
	mov	bl,al
	in	al,61h		; keyboard control
	mov	ah,al
	or	al,80h
	out	61h,al
	xchg	ah,al
	out	61h,al		; keyboard has been reset
	mov	al,bl
	movzx	eax,al

;	Move the pressed/released flag into ah and invert it

	shl	eax,1
	shr	al,1
	xor	ah,1

;	update the key indicator

	movzx	ebx,al
	mov	bpt [offset key_table2+ebx],ah

;	ebx is key, ah = 1 for pressed, 0 for released

;	Check for the shift keys

	cmp	bl,42		;r shift
	je	status_change
	cmp	bl,54
	je	status_change
	cmp	bl,29		;control
	je	status_change
	cmp	bl,56		;alt
	je	status_change

	jmp	norm_key

status_change:	;check shift

	btr	[key_status],ks_shift			;clear shift
	test	bpt 42[key_table2],-1			;and check keys
	jne	shift_down
	test	bpt 54[key_table2],-1
	je	no_shift
shift_down:	bts	[key_status],ks_shift			;set shift

no_shift:	;check control key

	btr	[key_status],ks_control
	test	bpt 29[key_table2],-1			;and check keys
	je	no_control
	bts	[key_status],ks_control

ifdef intro_halt
	mov	[intro_halted],1
endif

no_control:	;check alt key

	btr	[key_status],ks_alt
	test	bpt 56[key_table2],-1			;ans check keys
	je	no_alt
	bts	[key_status],ks_alt

ifdef intro_halt
	mov	[intro_halted],0
endif

no_alt:	jmp	send_ekoi

norm_key:	;don't do anything if the key was released

	jife	ah,send_ekoi

;	put key into buffer with status

	mov	ah,bpt[key_status]

	mov	ebx,[key_buffer_end]			;key goes here
	mov	ecx,ebx					;calculate next position
	add	ecx,2
	cmp	ecx,offset key_buffer+key_buffer_size	;check for overflow
	jc	noovf
	mov	ecx,offset key_buffer
noovf:	cmp	ecx,[key_buffer_start]			;have we filled the buffer
	je	buffer_full

	mov	[ebx],ax					;if not put key in
	mov	[key_buffer_end],ecx			;and update end position

buffer_full:

send_ekoi:	mov	al,61h
	out	20h,al

	pop	ecx
	pop	ebx
	pop	eax
	pop	ds
	iretd

keyboard_handler	endp

endif

timer_handler_end::

fetch_key	proc

ifndef no_keyboard

	push	ebx

;	check the keyboard handler and calculate keys

	mov	ebx,[key_buffer_start]
	cmp	ebx,[key_buffer_end]
	je	no_key

	mov	ax,[ebx]
	add	ebx,2
	cmp	ebx,offset key_buffer+key_buffer_size
	jc	noovf
	mov	ebx,offset key_buffer
noovf:	mov	[key_buffer_start],ebx

;	al holds key, ah holds key status

	movzx	ebx,ah
	movzx	eax,al

	shl	eax,2

;	Check the key status, shift then control then alt

	bt	ebx,ks_shift
	jnc	no_shift
	inc	eax
	jmp	status_done

no_shift:	bt	ebx,ks_control
	jnc	no_cntrl
	add	eax,2
	jmp	status_done

no_cntrl:	bt	ebx,ks_alt
	jnc	status_done
	add	eax,3

status_done:	;check for a conversion

	test	bpt[offset my_asctab+eax],-1
	je	no_conversion

	movzx	eax,bpt [offset my_asctab+eax]		;get the key

;	check here for cntrl alt delete

	cmp	al,key_delete
	jne	not_cad

	and	bl,6
	cmp	bl,6
	jne	not_cad

	program_error em_game_over

not_cad:	or	al,al					;clear z flag
	jmp	fetch_key_end

no_conversion:	;key is a funny one

	shr	eax,2

no_key:	clear	eax

fetch_key_end:	pop	ebx
	ret


else ;no_keyboard

;	fetch a key press from the keyboard

	push	esi

	mov	ah,6
	mov	dl,-1
	dos_int
	je	no_key

	and	eax,0ffh				;  0 means another key waiting
	jne	no_key				;!=0 means ordinary key

	mov	ah,6
	mov	dl,-1
	dos_int
	movzx	eax,al				;add 256 making sure zero flag is clear
	or	ah,1

no_key:	pop	esi
	ret

endif

fetch_key	endp




flush_key_buffer	proc

ifndef no_keyboard
	mov	[key_buffer_start],offset key_buffer
	mov	[key_buffer_end],offset key_buffer
	ret

else ;no_keyboard

	call	fetch_key
	jne	flush_key_buffer
	ret

endif

flush_key_buffer	endp




crit_err_handler	proc

	clear	eax
	iretd

crit_err_handler	endp




noitcetorp_kcehc	proc


;	Check Security code

	mov	eax,[enter_digits]			;are we entering digits?
	jife	eax,no_security

ifndef cd_version_prot
	test	[linc_digit_6],-1
	je	no_security
endif
	cmp	[console_type],5
	je	reactor_code

ifdef cd_version_prot
	jmp	cd_fix
endif

;	eax holds the number of the code we are looking for + 1
	dec	eax

	mov	esi,6
	imul	esi,eax
	add	esi,offset security_codes
	mov	edi,offset linc_digit_1
	mov	ecx,6

sec_check:	lodsb
	clear	ah
	add	ax,141h
	cmp	ax,[edi]
	jne	not_ok
	lea	edi,4[edi]
	loop	sec_check

cd_fix:	mov	[fs_command],337
	jmp	sec_don

reactor_code:	mov	[fs_command],379
	jmp	sec_don

not_ok:	mov	[fs_command],240

sec_don:	mov	[enter_digits],0

no_security:	ret

noitcetorp_kcehc	endp

end32code




start16code
	public	music_driver
	public	music_bin_seg

music_driver	dw	0				;offset and
music_bin_seg	dw	0				;segment of binary code

sound	db	0
channel	db	0

voc_seg	dw	0
voc_fx_seg	dw	0

mc_ax	dw	0				;music command parameters
mc_bx	dw	0
mc_cx	dw	0
mc_dx	dw	0

music_command_16	proc

;	Additional commands

;	ah = 100	mc_bx holds segment of voc data
;	ah = 101	play voc data
;	ah = 102	mc_bx holds segment of voc fx data
;	ah = 103	play voc fx data

	mov	ax,cs:[mc_ax]
	mov	bx,cs:[mc_bx]
	mov	cx,cs:[mc_cx]
	mov	dx,cs:[mc_dx]

	cmp	ah,100
	jc	no_extra
	je	set_voc_seg
	cmp	ah,102
	jc	play_voc
	je	set_voc_fx_seg
	cmp	ah,104
	jc	play_voc_fx

	jmp	no_extra


set_voc_seg:	;mc_bx holds segment of voc data

	mov	ax,cs:[mc_bx]
	mov	cs:[voc_seg],ax
	clear	ax
	retf

play_voc:	;play voc data

	mov	ax,5ffh
	mov	bx,cs:[voc_seg]
	mov	es,bx
	clear	bx
	mov	cx,07fh

	jmp	no_extra

set_voc_fx_seg:	;mc_bx holds segment of voc data

	mov	ax,cs:[mc_bx]
	mov	cs:[voc_fx_seg],ax
	clear	ax
	retf

play_voc_fx:	;play voc data

	mov	ax,5feh
	mov	bx,cs:[voc_fx_seg]
	mov	es,bx
	clear	bx
	mov	cx,17fh

	jmp	no_extra

no_extra:	call	dword ptr cs:[music_driver]

command_end:	retf

music_command_16	endp

end16code

	end
