include_macros	equ	1
include_deb_mac	equ	1
include_files	equ	1
include_struc	equ	1
include_flags	equ	1
include_logic	equ	1
include_error_codes equ	1
	include include.asm


first_text_sec	equ	77
no_of_text_sections equ	8		;8 sections per language
first_text_buffer	equ	274

text_buffer_size	equ	120

char_set_header	equ	128

text_mouse_width	equ	80h
fixed_text_width	equ	128


start32data

text_buffer	db	text_buffer_size dup (?) 
dt_col	db	0					;text colour

	align 4

set_font_data_size	equ	12

main_character_set	dd	?					;address of game character set
	dd	main_char_height				;char height
	dd	0

link_character_set	dd	?					;address of link character set
	dd	12
	dd	1

control_char_set	dd	?					;address of control character set
	dd	12
	dd	0

cur_char_set	dd	0

character_set	dd	?					;address of current character set
char_height	dd	?					;height of character set

;	display text variables

dt_line_width	dd	0					;width of a line in pixels
dt_lines	dd	0					;no of lines to do
dt_line_size	dd	0					;size of one line in bytes
dt_data	dd	0					;address for data
;dt_words2	dd	0					;no of words in message
dt_letters	dd	0					;no of chars in message
dt_text	dd	?					;pointer to text
dt_char_spacing	dd	0					;character seperation adjustment
dt_last_width	dd	0					;width of chars in last line (for editing)
dt_centre	dd	0					;set for centre text

mouse_text_data	dd	0					;space for the text mouse

low_text_width	dd	?					;variables for the pointer mouse
pm_offset_x	dd	?
pm_offset_y	dd	?

max_no_lines	equ	10

centre_table	dd	max_no_lines dup (0)			;table for centering text

speech_convert_table dd	0					;Text numbers to file numbers
	dd	600					; 553 lines in section 0
	dd	600+500					; 488 lines in section 1
	dd	600+500+1330				;1303 lines in section 2
	dd	600+500+1330+950				; 922 lines in section 3
	dd	600+500+1330+950+1150			;1140 lines in section 4
	dd	600+500+1330+950+1150+550			; 531 lines in section 5
	dd	600+500+1330+950+1150+550+150		; 150 lines in section 6

max_speech_items	equ	10					;How many we can have loaded at any one time

speech_items_list	dd	max_speech_items*2 dup (0)

pre_after_table_area dd	0					;location of preafter table

speech_text_no	dd	?
speech_file_no	dd	?

ifdef debug_42
last_speech_file	dd	0
last_speech_screen	dd	200
endif


end32data



start32code
	public	logic_cursor

	extrn	get_text_char:near

initialise_text	proc

	mov	eax,char_set_file
	clear	edx
	call	load_file
	mov	[main_character_set],eax

	clear	eax
	call	fn_set_font

ifndef s1_demo
	mov	eax,60520
	clear	edx
	call	load_file
	mov	[control_char_set],eax

	mov	eax,60521
	clear	edx
	call	load_file
	mov	[link_character_set],eax
endif

	test	[_cd_version],-1				;load preafter table for cd version
	je	no_pre_load

	mov	eax,60522
	clear	edx
	call	load_file
	mov	[pre_after_table_area],eax

no_pre_load:

ifdef do_text_dump
end32code
start32data

;	how much to jump by
td_line_jump	equ	10
max_speech_section	equ	7

dump_convert_table	dd	553					; 553 lines in section 0
	dd	484					; 488 lines in section 1
	dd	1303					;1303 lines in section 2
	dd	922					; 922 lines in section 3
	dd	1140					;1140 lines in section 4
	dd	531					; 531 lines in section 5
	dd	120					; 150 lines in section 6
end32data
start32code

;	Print out samples of the text files

	clear	ebx			;section counter

section_loop:	;find out how many messages in this file

	mov	ecx,[offset dump_convert_table + ebx*4]
	
	;printf "%d lines in section %d",ecx,ebx

	clear	edx			;text number counter

dtext_loop:	mov	esi,ebx			;calculate actual message number
	shl	esi,12
	add	esi,edx
	printf "section %d item %d number %d",ebx,edx,esi
	push	ebx
	push	ecx
	push	edx
	mov	eax,esi
	call	get_text
	pop	edx
	pop	ecx
	pop	ebx
	mov	esi,offset text_buffer
	printf "text %s",esi
	printf "-"
	add	edx,td_line_jump
	sub	ecx,td_line_jump
	jnc	dtext_loop

	;printf "ended s%d with m%d",ebx,edx

;	on to next section

	inc	ebx
	cmp	ebx,max_speech_section
	jc	section_loop
endif
	ret

initialise_text	endp




fn_set_font	proc

;	set font eax

	mov	[cur_char_set],eax

	imul	eax,set_font_data_size
	add	eax,offset main_character_set

	mov	ebx,[eax]
	mov	[character_set],ebx

	mov	ebx,4[eax]
	mov	[char_height],ebx

	mov	ebx,8[eax]
	mov	[dt_char_spacing],ebx

	ret

fn_set_font	endp





fn_speak_wait	proc

;	non player mega char speaks
;	player will wait for it to finish before continuing script processing

;	esi isplayer
;	eax is id to speak
;	ebx is message number
;	ecx is animation number

	mov	(cpt[esi]).c_flag,ax
	mov	(cpt[esi]).c_logic,l_listen
	jmp	fn_speak_me

fn_speak_wait	endp




FN_speak_wait_dir	proc

;	non player mega chr$ speaks	S2(20Jan93tw)
;	the player will wait for it to finish
;	before continuing script processing

;	this function sets the directional option whereby
;	the anim chosen is linked to c_dir -

;	esi is player
;	eax is id to speak (not us)
;	ebx is text message number
;	ecx is base of mini table within anim_talk_table

	mov	(cpt[esi]).c_flag,ax			;save id
	mov	(cpt[esi]).c_logic,l_listen
	fetch_compact edi

	jife	ecx,null_table				;0 means ignore anim / dir infi

	movzx	edx,(cpt[edi]).c_dir
	shl	edx,1
	add	ecx,edx

;	ok, got the animation number & a6 is correct

null_table:	call	std_speak

	clear	eax
	ret

FN_speak_wait_dir	endp




fn_speak_me_dir	proc

;	must be player so don't cause script to drop out
;	this function sets the directional option whereby
;	the anim chosen is linked to c_dir

;	esi is player
;	eax is target id
;	ebx is message number
;	ecx is animation

	mov	dx,(cpt[esi]).c_dir
	shl	dx,1				;2 sizes (large and small)
	add	cx,dx

fn_speak_me_dir	endp
;NOWT IN YERE
fn_speak_me	proc

;	Must be player

;	esi is player
;	eax is target id
;	ebx is message number
;	ecx is animation number

	fetch_compact edi
	call	std_speak
	clear	eax				;drop out of script
	ret

fn_speak_me	endp




std_speak	proc

;	edi is target
;	ebx is text number
;	ecx is animation number or -1 for directional
;	edx is optional base

;	first set the animation up
;	use the value in d2 as the actual anim number, except -
;	for each mega set add one more to the animation number

ifdef debug_42
	mov	ebx,4277
endif

ifdef with_screen_saver
	mov	[sssss_count],0
endif
	mov	[c_text_no],ebx

	mov	ax,(cpt[edi]).c_mega_set
	mov	dl,next_mega_set
	div	dl
	add	al,cl				;get correct anim no
	movzx	eax,al

	mov	edx,[offset anim_talk_table+eax*4]	;get animation address
	jife	edx,no_talk_file

	cmp	dx,-1				;flag for special type
	jne	old_address_type

	shr	edx,16				;id of a talk
	movzx	eax,dx
	fetch_compact edx

old_address_type:	flodsws ax,edx				;sprite offset
	mov	(cpt[edi]).c_offset,ax
	flodsws ax,edx
	mov	(cpt[edi]).c_get_to_flag,ax
no_talk_file:	mov	(cpt[edi]).c_grafix_prog,edx


;	now form the text sprite

;--------------------------------------------------------------------------------------------------

;	Try and say something

	push	ebx
	push	esi
	push	edi

ifdef clicking_optional
	jmp	no_speech
endif

	test	[_cd_version],-1
	je	no_speech
	bt	[system_flags],sf_play_vocs	;sblaster only
	jnc	no_speech
	bt	[system_flags],sf_allow_speech
	jnc	no_speech

	mov	[speech_text_no],ebx

	mov	eax,ebx				;work out section
	and	ebx,0f000h			;section no is top 4 bits
	and	eax,0fffh
	shr	ebx,10				;section no * 4
	add	eax,[offset speech_convert_table + ebx]

	mov	[speech_file_no],eax

ifdef debug_42
	test	[last_speech_file],-1
	je	nolsf

	mov	esi,[pre_after_table_area]
	test	wpt[esi + eax*2],-1
	jne	nolsf
	printf "after speech file %d comes %d in room %d",[last_speech_file],[speech_file_no],[last_speech_screen]
nolsf:	push	eax
	mov	eax,[speech_file_no]
	mov	[last_speech_file],eax
	mov	eax,[screen]
	mov	[last_speech_screen],eax
	pop	eax
endif

;	Search through the loaded speech table looking for this line or an empty space

	mov	esi,offset speech_items_list
	mov	ecx,max_speech_items
	clear	ebx
sp_lk_lop:	cmp	eax,[esi]
	je	found_sp
	test	dpt[esi],-1
	jne	not_empty
	mov	ebx,esi
not_empty:	lea	esi,8[esi]
	loop	sp_lk_lop

;	Item is not there, did we find an empty slot

	cherror ebx,e,0,em_internal_error

	;printf	"%d not pre loaded",eax

;	Load the data into this slot

	mov	esi,ebx
	mov	[esi],eax
	push	esi

	bts	[system_flags],sf_speech_file
	add	eax,50000
	clear	edx
	call	load_file
	btr	[system_flags],sf_speech_file

	pop	esi
ifdef cd_version_prot
	jife	eax,sp_file_missing2
else
	jife	eax,sp_file_missing
endif
	mov	4[esi],eax

found_sp:	;Transfer and play the speech

	push	esi
	mov	eax,4[esi]
	movzx	ecx,(s ptr[eax]).s_tot_size
	lea	eax,SIZE s[eax]

	push	eax
	push	ecx
	push	1

	call	_play_voc_data__Npcii
	bts	[system_flags],sf_voc_playing

	pop	esi				;get pointer to voc data
	mov	dpt[esi],0			;and kill it
	mov	eax,4[esi]
	call	my_free

;	Trash any loaded voc files as they obviously are not needed

	mov	esi,offset speech_items_list
	mov	ecx,max_speech_items
	clear	ebx
sp_lk_lopz:	test	dpt[esi],-1
	je	zz_slot_mt
	mov	dpt[esi],0
	mov	eax,4[esi]
	push	esi
	push	ecx
	call	my_free
	pop	ecx
	pop	esi
zz_slot_mt:	lea	esi,8[esi]
	loop	sp_lk_lopz

;	If this line is followed by another one then load it

	mov	eax,[speech_file_no]
	mov	esi,[pre_after_table_area]
	test	wpt[esi + eax*2],-1
	je	none_2lod

;	Search through the loaded speech table looking for empty slot

	mov	esi,offset speech_items_list
sp_lk_lop2:	test	dpt[esi],-1
	je	found_mt
	lea	esi,8[esi]
	jmp	sp_lk_lop2

found_mt:	mov	edx,[pre_after_table_area]
	movzx	eax,wpt[edx + eax*2]
	mov	[esi],eax
	push	esi
	bts	[system_flags],sf_speech_file
	add	eax,50000
	clear	edx
	call	load_file
	btr	[system_flags],sf_speech_file
	pop	esi
	mov	4[esi],eax
	jifne	eax,none_2lod
	mov	dpt[esi],0		;file was not there!!

none_2lod:	;Check if we are allowing text as well as speech

	bt	[system_flags],sf_allow_text
	jc	no_speech

	pop	edi
	pop	esi
	pop	ebx

	mov	(cpt[edi]).c_sp_text_id,-1		;So we know this is a voc file
	mov	(cpt[edi]).c_sp_time,10000000	;We test for end of voc so this doesn't matter
	mov	(cpt[edi]).c_logic,l_talk
	mov	[logic_talk_button_release],1	;reset button check
	ret

ifdef cd_version_prot

sp_file_missing2:	mov	dpt[esi],0
	pop	edi
	pop	esi
	pop	ebx
	ret
endif

sp_file_missing:	printf "missing speech file %d %d",[speech_text_no],[speech_file_no]
	mov	dpt[esi],0
	jmp	no_speech

no_speech:	pop	edi
	pop	esi
	pop	ebx


;--------------------------------------------------------------------------------------------------


	mov	eax,ebx
	mov	dl,bpt (cpt[edi]).c_sp_colour	;pen
;	movzx	ebx,(cpt[edi]).c_sp_width		;pixel width
	mov	ebx,fixed_text_width		;*******On PC make all speech 128 wide
	clear	ecx				;null logic
	push	edi
	mov	ebp,1				;centre the text
	call	low_text_manager
	pop	edi

;	esi is text item compact ( text_n )
;	edi is text sprite compact ( person saying )
;	ebx is text compact number
;	eax is text data (including sprite header)

	mov	(cpt[edi]).c_sp_text_id,bx		;So we know what text to kill
	mov	edx,eax

;	create the x coordinate for the speech text
;	we need the talkers sprite information

	movzx	eax,(cpt[edi]).c_screen		;put our screen in
	mov	(cpt[esi]).c_screen,ax

	cmp	eax,[screen]			;only use coordinates if we are on the current screen
	jne	talking_off_screen

	movzx	eax,(cpt[edi]).c_frame		;work out text address
	shr	eax,6
	fetch_item ebx

	mov	ax,(cpt[edi]).c_xcood
	add	ax,(s ptr[ebx]).s_offset_x		;+ our sprite offset

	mov	cx,(s ptr[ebx]).s_width		;width of talker
	shr	cx,1				;halved
	add	ax,cx				;middle of talker

;	mov	cx,(cpt[edi]).c_sp_width		;text width
;	shr	cx,1				;middle of text
;	sub	ax,cx
	sub	ax,fixed_text_width/2

	cmp	ax,top_left_x			;off left?
	jnc	lok
	mov	ax,top_left_x
lok:	mov	cx,ax				;off right?
;	add	cx,(cpt[edi]).c_sp_width
	add	cx,fixed_text_width
	cmp	cx,top_left_x+full_screen_width
	jc	rok
	mov	ax,top_left_x+full_screen_width
;	sub	ax,(cpt[edi]).c_sp_width
	sub	ax,fixed_text_width
rok:	mov	(cpt[esi]).c_xcood,ax

	mov	ax,(cpt[edi]).c_ycood
	add	ax,(s ptr[ebx]).s_offset_y
	sub	ax,6
	sub	ax,(s ptr[edx]).s_height		;depth of speech sprite
	cmp	ax,top_left_y
	jnc	yok
	mov	ax,top_left_y
yok:	mov	(cpt[esi]).c_ycood,ax

	;mov	eax,[dt_words]			;get no of words
	;inc	eax				;one more for timer
	;imul	eax,[text_rate]

	mov	eax,[dt_letters]
	add	eax,5

	mov	(cpt[edi]).c_sp_time,ax
	mov	(cpt[edi]).c_logic,l_talk
	mov	[logic_talk_button_release],1
	ret


talking_off_screen: ;mov	eax,[dt_words]			;get no of words
	;inc	eax				;one more for timer
	;imul	eax,[text_rate]

	mov	eax,[dt_letters]
	add	eax,5

	mov	(cpt[edi]).c_sp_time,ax
	mov	(cpt[edi]).c_logic,l_talk
	mov	(cpt[edi]).c_sp_text_id,0		;don't kill any text 'cos none was made
	mov	(cpt[esi]).c_status,0		;don't display text
	mov	[logic_talk_button_release],1
	ret

std_speak	endp




low_text_manager	proc

;	eax	= message number
;	ebx	= pixel_width
;	ecx	= text logic number
;	dl	= pen
;	ebp	= 1 for centre text

	push	ecx
	push	ebx
	push	edx
	push	ebp
	call	get_text

	pop	ebp
	pop	edx
	pop	ecx
	clear	ebx
	mov	esi,offset text_buffer
	call	display_text
	mov	[low_text_width],ebx		;save text width for pointer text

	pop	ecx				;get logic back
	push	eax				;save text data address

	mov	ebx,first_text_compact

text_free_loop:	mov	eax,ebx
	fetch_compact				;look at a text item
	test	(cpt[esi]).c_status,-1
	je	heres_the_slot
	inc	ebx
	jmp	text_free_loop

heres_the_slot:	;esi is a free text compact

	pop	eax				;get sprite data pointer
	push	eax				;save it agian
	push	ebx				;save compact number

	sub	ebx,first_text_compact		;calculate entry buffer item no
	add	ebx,first_text_buffer
	mov	(cpt[esi]).c_flag,bx
	xchg	eax,[offset item_list+ebx*4]

;	eax could be old text data that can be free'd

	jife	eax,no_free
	push	ecx
	push	esi
	call	my_free
	pop	esi
	pop	ecx

no_free:	;set up the compact to display the data

	mov	(cpt[esi]).c_logic,cx
	mov	(cpt[esi]).c_status,st_logic+st_foreground+st_recreate
	mov	eax,[screen]
	mov	(cpt[esi]).c_screen,ax

	pop	ebx				;compact number
	pop	eax				;text data

	ret

low_text_manager	endp




get_text	proc

;	mov	eax,24646

;	Decompress a text message
;	eax is text message number

	mov	ebx,eax				;section number is top four bits
	and	ebx,0f000h
	shr	ebx,10				;pointer to dwords
	mov	esi,[offset item_list+first_text_sec*4+ebx]
	jifne	esi,section_loaded

;	We must load this section

	push	eax
	push	ebx
	mov	eax,ebx
	shr	eax,2

	mov	ebx,[_language]			;calculate language offset
	imul	ebx,ebx,no_of_text_sections
	add	eax,ebx
	add	eax,60600

	clear	edx
	call	load_file
	mov	esi,eax
	pop	ebx
	mov	[offset item_list+first_text_sec*4+ebx],eax
	pop	eax

section_loaded:	clear	ecx				;offset calculator
	mov	ebx,eax				;first look at 32 message blocks
	and	ebx,0fe0h
	je	no_32s

	lea	edx,4[esi]
	shr	ebx,5
loop_32:	movzx	ebp,wpt[edx]
	add	ecx,ebp
ifdef debug_42
	jc	text_error
endif
	add	edx,2
	floop	ebx,loop_32

no_32s:	mov	edx,eax				;point to start of single offset block
	and	ax,1fh				;no of singles to do
	je	no_singles

	and	edx,0fe0h
	add	dx,[esi]
	add	edx,esi

single_loop:	movzx	ebx,bpt[edx]
	inc	edx
	btr	bx,7
	jc	big_mess

	add	ecx,ebx
	floop	ax,single_loop
	jmp	no_singles

big_mess:	shl	ebx,3				;double bytes to double bits
	add	ecx,ebx
	floop	ax,single_loop

no_singles:	;ecx is offset into message

	mov	edx,ecx
	shr	ecx,2				;double bits to bytes
	add	cx,2[esi]
ifdef debug_42
	jc	text_error
endif
	add	esi,ecx

;	Bit pointer: 0->8 , 1->6 , 2->4 , 3->2 ( 0->4 , 1-> 3 , 2->2 , 3->1 )
	and	edx,3
	xor	dl,3
	inc	edx
	shl	edx,1

	mov	bl,[esi]				;get a byte
	inc	esi
	mov	edi,offset text_buffer

text_loop:	call	get_text_char
	stosb
	cherror edi,nc,offset text_buffer+text_buffer_size,em_internal_error
	jifne	al,text_loop

;ifdef debug_42
;	mov	edi,offset text_buffer
;	printf "text message %s",edi
;endif

	ret

ifdef debug_42
text_error:	program_error	em_internal_error
endif

get_text	endp




get_tbit	proc

	dec	dl
	jns	no_new_byte
	mov	bl,[esi]
	inc	esi
	mov	dx,7
no_new_byte:	bt	bx,dx
	ret

get_tbit	endp




display_text	proc

;	Turn a text message into a sprite.

;	dl = text colour number
;	cx = pixel width
;	ebx  = 0 :	Allocate data for text
;	ebx != 0 :	Use memory at ebx for data
;	esi points to text
;	ebp = 1 for centre text

;	First split the message into seperate lines that will fit a fixed width

	mov	[dt_col],dl			;save colour
	mov	wpt[dt_line_width],cx		;and width
	mov	[dt_lines],0
	;mov	[dt_words2],1
	mov	[dt_letters],1
	mov	[dt_data],ebx
	mov	[dt_text],esi
	mov	[dt_centre],ebp

	mov	edi,[character_set]

	clear	edx				;use dx for width
	clear	eax				;clear bit 8-31

	mov	ebp,offset centre_table
ifdef debug_42
	clear	ebx				;will cause frame error if first word too long
endif

split_loop:	lodsb					;get a character
	inc	[dt_letters]
	sub	al,' '
	jc	line_split			;< 20h means end of line (0)
	jne	not_space
	mov	ebx,esi				;keep track of last space
	;inc	[dt_words2]
	mov	ds:[ebp],edx			;save width for centering
not_space:	add	dl,[edi+eax]			;add character width
	adc	dh,0
	add	dx,wpt[dt_char_spacing]		;include character spacing
	cmp	dx,cx
	jc	split_loop

;	we have exceeded the line width

	cherror bpt[ebx-1],e,10,em_internal_error

	mov	bpt[ebx-1],10			;turn last space into line feed
	clear	edx
	inc	[dt_lines]			;one more line
	lea	ebp,4[ebp]			;next space in centering table
	mov	esi,ebx				;go back for new count
	jmp	split_loop

line_split:	mov	wpt[dt_last_width],dx		;save width of last line (for editing single lines)
	mov	ds:[ebp],edx			;and update centering table

	;dt_lines = no of lines-1
	inc	[dt_lines]

	cherror [dt_lines],nc,max_no_lines,em_internal_error

	movzx	eax,cx				;calc size of one character line
	imul	eax,[char_height]
	mov	[dt_line_size],eax

	imul	eax,[dt_lines]			;get amount of memory to allocate
	add	eax,SIZE s+4			;4 for safety (rounding up)
	push	eax				;save no of bytes

	mov	edi,[dt_data]			;check if memory already exists
	jifne	edi,got_mem

	call	my_malloc			;and fetch the memory
	mov	edi,eax
	mov	[dt_data],eax

got_mem:	pop	ecx				;no of bytes to clear
	sub	ecx,SIZE s			;don't touch the header
	push	edi
	add	edi,SIZE s
	clear	eax
	shr	ecx,2				;do dwords
	rep	stosd
	pop	edi

;	Make the header

	mov	eax,[dt_line_width]
	mov	(s ptr[edi]).s_width,ax

	mov	ebx,[char_height]
	imul	ebx,[dt_lines]
	mov	(s ptr[edi]).s_height,bx

	imul	eax,ebx
	mov	(s ptr[edi]).s_sp_size,ax

	mov	(s ptr[edi]).s_offset_x,0
	mov	(s ptr[edi]).s_offset_y,0

	mov	esi,[dt_text]

	add	edi,SIZE s			;point to where pixels start
	push	edi				;save it

	mov	ebx,[character_set]
	mov	dl,[dt_col]
	mov	ecx,offset centre_table

line_loop:	test	[dt_centre],-1			;check for centering
	je	text_loop
	mov	eax,[dt_line_width]		;centre the text
	sub	eax,[ecx]
	lea	ecx,4[ecx]
	shr	eax,1
	add	edi,eax

text_loop:	movzx	eax,bpt[esi]			;get a character
	inc	esi
	sub	al,' '
	jc	line_end

	call	make_game_character		;[make_character]
	jmp	text_loop

line_end:	;end of line or end of text?
	cmp	al,10-' '
	jne	text_end

	pop	edi				;start of last line
	add	edi,[dt_line_size]		;start of next
	push	edi
	jmp	line_loop

text_end:	;The sprite has been done (yo ho ho)

	pop	eax				;trash dummy edi
	
	mov	eax,[dt_data]
	mov	ebx,[dt_last_width]
	ret

display_text	endp




make_game_character	proc

;	eax is character to print - 20h
;	ebx points to character set
;	edi points to data
;	dl is colour

	push	esi
	push	ebx
	push	ecx

	mov	cl,ds:[eax+ebx]			;get char width

	inc	cl				;bodge 'cos main character set widths are wrong
	sub	cl,bpt [dt_char_spacing]		;only main char set has 0 spacing


	mov	dh,bpt[char_height]
	shl	dh,2				;4 bytes per character line
	mul	dh
	mov	esi,eax
	add	esi,char_set_header
	add	esi,ebx
	mov	ebp,[char_height]
	push	edi
line_loop:	push	edi
	lodsw					;ax = data
	xchg	ah,al
	mov	bx,[esi]				;bx = mask
	xchg	bh,bl
	add	esi,2
	mov	ch,cl

bit_loop:	shl	bx,1				;check mask
	jc	yes_mask
;ifndef text_test
;	mov	bpt[edi],0			;no mask no nothing
;endif
	shl	ax,1				;shift data too
	jmp	bit_clear

yes_mask:	shl	ax,1				;check data
	jc	bit_set
	mov	bpt[edi],240	;1
	jmp	bit_clear
bit_set:	mov	bpt[edi],dl	;15
bit_clear:	inc	edi
	floop	ch,bit_loop
	pop	edi
	add	edi,[dt_line_width]
	floop	ebp,line_loop

	pop	edi
	and	ecx,0ffh
	add	edi,ecx
	add	edi,[dt_char_spacing]

	dec	edi				;bodge 'cos main character set widths are wrong
	add	edi,[dt_char_spacing]		;only main char set has 0 spacing

	pop	ecx
	pop	ebx
	pop	esi

	ret

make_game_character	endp




fn_pointer_text	proc

;	eax	= id of compact pointer is over

	fetch_compact
	movzx	eax,(cpt[esi]).c_cursor_text

	mov	ebx,text_mouse_width
	mov	ecx,l_cursor
	mov	dl,242
	clear	ebp
	call	low_text_manager

	mov	[cursor_id],ebx

;	Calculate offsets and things

	test	[menu],-1				;menu items are different
	je	not_menu

	mov	[pm_offset_y],top_left_y-2

	cmp	[amouse_x],150
	jc	menu_right

;	Text to left of cursor

	mov	eax,top_left_x - 4
	sub	eax,[low_text_width]
	mov	[pm_offset_x],eax

	jmp	logic_cursor

menu_right:	mov	[pm_offset_x],top_left_x+24
	jmp	logic_cursor

not_menu:	mov	[pm_offset_y],top_left_y-10

	cmp	[amouse_x],150
	jc	nmenu_right

;	Text to left of cursor

	mov	eax,top_left_x - 4
	sub	eax,[low_text_width]
	mov	[pm_offset_x],eax

	jmp	logic_cursor

nmenu_right:	mov	[pm_offset_x],top_left_x+13


logic_cursor::
;	mov	eax,[amouse_x]
;	add	eax,5 + top_left_x
;	sub	eax,[mouse_offset_x]
;
;	mov	ebx,[amouse_y]
;
;	cmp	ebx,26				;put it above or below
;	jc	below
;
;	add	ebx,top_left_y - 11
;	jmp	above
;
;below:	add	ebx,top_left_y + 1
;	add	eax,17
;
;above:	sub	ebx,[mouse_offset_y]

	mov	eax,[amouse_x]
	sub	eax,[mouse_offset_x]
	add	eax,[pm_offset_x]

	mov	ebx,[amouse_y]
	sub	ebx,[mouse_offset_y]
	add	ebx,[pm_offset_y]

	cmp	ebx,top_left_y
	jnc	no_yovf
	mov	ebx,top_left_y

no_yovf:	mov	(cpt[esi]).c_xcood,ax
	mov	(cpt[esi]).c_ycood,bx

	mov	al,1
	ret

fn_pointer_text	endp




fn_look_at	proc

;	eax = text no
;	ebx = colour
;	ecx = y_coord

	push	ecx

	mov	ebp,1
;	mov	dl,bl
	mov	dl,248
	clear	ecx
	mov	ebx,240
	call	low_text_manager

	mov	(cpt[esi]).c_xcood,168
	pop	eax
	mov	(cpt[esi]).c_ycood,ax

	push	esi

	;mov	eax,[cursor_id]
	;call	fn_kill_id
	;call	run_get_off			;clear anything else

	call	re_create
	call	sprite_engine
	call	flip

	call	fn_no_human
	call	lock_mouse

	clear	eax					;reset relative timer
	call	wait_relative

	call	wait_mouse_not_pressed

ifdef with_replay
	call	check_replay_skip
	jc	skip_wait
endif


	;mov	eax,[dt_letters]				;keep up for minimum time based on length
	;imul	eax,3
	mov	eax,40
	call	wait_relative

skip_wait:	call	unlock_mouse
	call	fn_add_human

	pop	esi

	mov	(cpt[esi]).c_status,0

	mov	al,1
	ret

fn_look_at	endp




fn_print_credit	proc

;	eax = text no
;	ebx = colour
;	ecx = y_coord

	push	ecx

	mov	ebp,1
;	mov	dl,bl
	mov	dl,248
	clear	ecx
	mov	ebx,240
	call	low_text_manager
	mov	[result],ebx

	mov	(cpt[esi]).c_xcood,168
	pop	eax
	mov	(cpt[esi]).c_ycood,ax

	mov	al,1
	ret

fn_print_credit	endp




change_text_sprite_colour	proc

;	Change colour of text sprite at  esi to colour bl

;	mov	bl,bpt[offset dt_col_table+ebx]		;convert colour

	movzx	ecx,(s ptr[esi]).s_sp_size			;do whole sprite
	add	esi,SIZE s				;and point to pixel data

high_loop:	cmp	bpt[esi],241				;don't change 1 or 0 (or 2 or 3 or 4 or 5 or 6 or 7 or 8 or
	jc	no_change
	mov	[esi],bl
no_change:	inc	esi
	loop	high_loop

	ret

change_text_sprite_colour	endp




fn_text_module	proc

;	eax	= id of text info
;	ebx	= text no

	push	eax
	push	ebx
	mov	eax,1
	call	fn_set_font
	pop	ebx
	pop	eax

	fetch_compact

	mov	eax,ebx		;message no
	mov	dx,[esi]		;pen
	mov	dx,209
	movzx	ebx,wpt 2[esi]	;width
	movzx	ecx,wpt 4[esi]	;logic

	push	esi
	clear	ebp		;no centre
	call	low_text_manager

	mov	[result],ebx	;text id

	pop	edi

	mov	ax,6[edi]
	mov	(cpt[esi]).c_xcood,ax

	mov	eax,8[edi]
	mov	(cpt[esi]).c_ycood,ax

	clear	eax
	call	fn_set_font

	mov	al,1
	ret

fn_text_module	endp




fn_linc_text_module proc

;	eax	= text number
;	ebx	= text no
;	ecx 	= button action no , -1 for none. On 0 or -1 clear button action nos

;	push	ecx
	push	ebx
	push	eax

;	Put button no in

	push	eax

	btr	ecx,15
	jnc	no_clr

	push	ecx
	mov	edi,offset linc_digit_0
	clear	eax
	mov	ecx,10
	rep	stosd
	pop	ecx

no_clr:	cmp	cx,10
	jnc	no_but
	mov	[offset linc_digit_0 + ecx*4],ebx

no_but:	pop	eax

	mov	eax,ebx		;message no
	mov	dx,215	;213	;242		;pen

	mov	ebx,220		;width
	clear	ecx

	clear	ebp		;no centre
	call	low_text_manager

	pop	eax

;	if eax < 20 then eax = line number (text items)
;	if eax > 20 then eax = x coordinate (numbers)
;	if eax = 20 then something has gone wrong

	cmp	eax,20
	jnc	numbers

	mov	(cpt[esi]).c_xcood,152
	imul	eax,13
	add	eax,170
	mov	(cpt[esi]).c_ycood,ax
	jmp	letters

numbers:	mov	(cpt[esi]).c_xcood,ax
	mov	(cpt[esi]).c_ycood,214

letters:	pop	eax
	mov	(cpt[esi]).c_get_to_flag,ax

	mov	al,1
	ret

fn_linc_text_module endp





ifdef mem_check


free_text_items	proc

	mov	ecx,8
	mov	esi,offset item_list+first_text_sec*4
ft_loop:	lodsd
	push	esi
	push	ecx
	jife	eax,no_free
	call	my_free
no_free:	pop	ecx
	pop	esi
	loop	ft_loop

	mov	ecx,10
	mov	esi,offset item_list+first_text_buffer*4
ft_loop2:	lodsd
	push	esi
	push	ecx
	jife	eax,no_free2
	call	my_free
no_free2:	pop	ecx
	pop	esi
	loop	ft_loop2

	ret

free_text_items	endp

endif

end32code
	end
