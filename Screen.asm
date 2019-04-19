include_macros  equ     1
include_deb_mac equ     1
include_flags   equ     1
	include include.asm


fade_jump       equ     2                               ;colour values to jump if fade
scroll_jump     equ     16                              ;amount to scroll screen by

vga_colours     equ     256                             ;no of colours on screen
game_colours    equ     240                             ;don't fade system colours

start32data

backscreen      dd      ?

original_screen_mode db ?                               ;screen mode on start up
	align 4

work_palette    dd      ?                               ;pointer to palette workspace
half_palette    dd      ?                               ;temp space for half palette (sssss)

scroll_addr     dd      0
scroll_segment  dw      0                               ;segment pointer to scroll workspace
old_scr_seg     dw      0
scroll_dir      dd      ?


;       System uses colours 240-255

top_16_colours  db      0,0,0                   ;       base black
	db      38,38,38        ;63,0,0                 ;       highlight red
	db      63,63,63                        ;       pointer text white
	db      0,0,0
	db      0,0,0
	db      0,0,0
	db      0,0,0
	db      54,54,54                        ;       disk icon
	db      45,47,49
	db      32,31,41
	db      29,23,37
	db      23,18,30
	db      49,11,11
	db      39,5,5
	db      29,1,1
	db      63,63,63                        ;       pointer white

end32data


start32save_data

current_palette dd      4316                            ;used by control to return the palette

end32save_data



start32code
	extrn   __x386_mk_protected_ptr:dword
	extrn   draw_mouse_to_back_screen:near
	extrn   restore_data_to_back_screen:near


initialise_screen       proc

;       Save the current screen mode for later

	mov     ah,0fh
	screen_int                                      ;returns screen mode in al
	mov     [original_screen_mode],al
	mov     ax,19                                   ;Set up the screen mode and clear the screen
	screen_int
	bts     [system_flags],sf_graphics                      ;flag we are in graphics mode

;       Allocate memory for the back screen

	mov     eax,full_screen_width*full_screen_height
	call    my_malloc
	mov     [backscreen],eax

;       Allocate memory for the game grid

	mov     eax,GRID_X*GRID_Y*2
	call    my_malloc
	mov     [game_grid],eax

;       Set up a descriptor to point to the screen

	push    0a0000h
	call    __x386_mk_protected_ptr                 ;returns pointer in dx:eax
	lea     esp,4[esp]
	mov     [screen_segment],dx

	mov     ax,3505h                                        ;limit selector to screen
	mov     bx,dx
	mov     ecx,full_screen_width*full_screen_height
	int     21h

	mov     eax,vga_colours*3                               ;make palette workspace
	call    my_malloc
	mov     [work_palette],eax

	mov     edi,eax                                 ;blank the palette
	clear   eax
	mov     ecx,game_colours*3/4
	rep     stosd

	mov     esi,offset top_16_colours                       ;and put system colours in
	mov     ecx,(vga_colours-game_colours)*3/4
	rep     movsd

	mov     esi,[work_palette]
	call    set_palette

	ret

initialise_screen       endp



fn_draw_screen  proc

;       Set up the new screen.
;       eax holds new palette number
;       ebx holds scroll value

	push    eax
	push    ebx
	call    fn_fade_down

ifdef with_replay
	mov     eax,-3
	mov     ebx,[random]
	call    replay_record_event
endif

	call    fn_force_refresh                        ;force full screen update
	call    re_create
	call    sprite_engine
	call    flip

	pop     ebx
	pop     eax
	call    fn_fade_up

ifdef with_replay
	call    replay_changed_screen
endif

ifdef debug_42
	mov     [last_speech_file],0
	mov     [last_speech_screen],200
endif

	mov     ax,1                            ;continue script
	ret

fn_draw_screen  endp




fn_force_refresh        proc

;       Force a full screen update

	mov     edi,[game_grid]
	mov     ecx,(GRID_X*GRID_Y)/4
	mov     eax,80808080h
	rep     stosd
	ret

fn_force_refresh        endp




flip    proc

	bts     [mouse_flag],mf_no_update                       ;hold the mouse interrupt

	call    draw_mouse_to_back_screen

	push    es
	mov     es,[screen_segment]

	mov     ebx,[game_grid]
	mov     esi,[backscreen]
	clear   edi

	mov     dh,GRID_Y

flip_loop_y:    push    esi
	push    edi
	mov     dl,GRID_X

flip_loop_x:    btr     wpt [ebx],0                             ;check flip flag
	jnc     no_flip

	push    esi
	push    edi

	mov     eax,GRID_H
move_loop:      mov     ecx,GRID_W/4
	rep     movsd
	add     esi,game_screen_width-GRID_W
	add     edi,full_screen_width-GRID_W
	floop   eax,move_loop

	pop     edi
	pop     esi

no_flip:        inc     ebx
	add     esi,GRID_W
	add     edi,GRID_W
	floop   dl,flip_loop_x

	pop     edi
	pop     esi
	add     esi,game_screen_width*GRID_H
	add     edi,full_screen_width*GRID_H
	floop   dh,flip_loop_y

	pop     es

	call    restore_data_to_back_screen

	btr     [mouse_flag],mf_no_update               ;allow the mouse to move again

	ret

flip    endp




fn_fade_up      proc

;       eax is palette no
;       ebx = 123 for scroll left  (going right)
;       ebx = 321 for scroll right (going left)

	call    check_replay_skip
	jc      fn_set_palette

	bt      [system_flags],sf_no_scroll
	jc      fade

	cmp     [computer_speed],30000
	jc      fade

	cmp     ebx,123
	je      scroll_left

	cmp     ebx,321
	je      scroll_right

fade:   ;fade palette from 0 to new palette

	mov     [current_palette],eax
	fetch_compact

	jmp     fade_up_esi


;       Scrolling

scroll_right:   mov     [scroll_dir],1
	jmp     scroll

scroll_left:    mov     [scroll_dir],0
scroll:

;       next screen should have been drawn to scroll segment. Scroll the screen

;       [screen_segemnt]:0 points to new screen
;       [scroll_segment]:0 points to graphic screen showing old room

	push    ds
	push    es

	push    scroll_jump
fu_start        equ     8                                       ;scroll position
	push    game_screen_width-scroll_jump
fu_left equ     4                                       ;bytes to do
	push    [screen_segment]
fu_screen       equ     2
	push    [scroll_segment]
fu_scroll       equ     0

	mov     ebp,esp

	mov     es,[scroll_segment]                     ;it all goes to screen

	test    [scroll_dir],-1
	jne     do_right

scroll_screen_l:        clear   edi
	mov     esi,scroll_jump ;fu_start[ebp]
	clear   ebx                                     ;point to new screen

;       Start the scroll at the start of a vertical sync

	call    get_vsync_flag
	jnc     not_in_v
	call    wait_till_out_v_sync
not_in_v:       call    wait_till_in_v_sync

	mov     edx,game_screen_height

scroll_loop_l:  push    esi
	push    ebx

	mov     ds,fu_scroll[ebp]                               ;move screen data along
	mov     ecx,fu_left[ebp]
	rep     movsb

	mov     ds,fu_screen[ebp]                               ;and fill in with new screen
	mov     esi,ebx
	mov     ecx,fu_start[ebp]
	rep     movsb

	pop     ebx
	add     ebx,full_screen_width
	pop     esi
	add     esi,full_screen_width
	floop   edx,scroll_loop_l

;       screen has scrolled one along

	add     dpt fu_start[ebp],scroll_jump
	sub     dpt fu_left[ebp],scroll_jump
	jnc     scroll_screen_l

	jmp     scroll_done


do_right:       std

scroll_screen_r:        mov     edi,game_screen_width-1
	mov     esi,game_screen_width-scroll_jump-1
	mov     ebx,edi                                 ;point to new screen
	mov     edx,game_screen_height

scroll_loop_r:  push    edi
	push    esi
	push    ebx

	mov     ds,fu_scroll[ebp]                               ;move screen data along
	mov     ecx,fu_left[ebp]
	rep     movsb

	mov     ds,fu_screen[ebp]                               ;and fill in with new screen
	mov     esi,ebx
	mov     ecx,fu_start[ebp]
	rep     movsb

	pop     ebx
	add     ebx,full_screen_width
	pop     esi
	add     esi,full_screen_width
	pop     edi
	add     edi,full_screen_width
	floop   edx,scroll_loop_r

;       screen has scrolled one along

	add     dpt fu_start[ebp],scroll_jump
	sub     dpt fu_left[ebp],scroll_jump
	jnc     scroll_screen_r

	cld

scroll_done:    lea     esp,12[esp]

	pop     es
	pop     ds

;       now swap around the segments

	mov     bx,[scroll_segment]
	xchg    bx,[screen_segment]
	mov     ax,3502h
	int     21h
	mov     [scroll_segment],0

	mov     eax,[scroll_addr]
	call    my_free

	mov     al,1
	ret

fn_fade_up      endp




fade_up_esi     proc

;       esi points to new palette

	mov     edx,64-fade_jump
	call    wait_50hz                               ;try and work to 50hz

fade_loop:      push    esi
	push    edx

	mov     ecx,game_colours*3                      ;rgb for each colour
	mov     edi,[work_palette]                      ;what we are working from

col_loop:       lodsb                                           ;where we want to get
	sub     al,dl                                   ;show it yet?
	jc      no_show
	mov     [edi],al

no_show:        inc     edi
	loop    col_loop

	mov     esi,[work_palette]                      ;what we are working from
	call    set_palette

	call    wait_50hz

	pop     edx
	pop     esi

	sub     edx,fade_jump
	jnc     fade_loop

;       Copy the palette accross to make sure it is ok

	mov     edi,[work_palette]
	mov     ecx,game_colours*3/4
	rep     movsd

	mov     esi,[work_palette]
	call    set_palette                             ;set real palette (not work space)

	;mov    esi,offset top_16_colours                       ;and put system colours in
	;mov    ecx,(vga_colours2-fade_colours2)*3/4
	;rep    movsd

;       fade done

	ret

fade_up_esi     endp




fn_fade_down    proc

;       if ebx is 123 or 321 then we want to scroll

	call    check_replay_skip
	jnc     not_skip
	ret

not_skip:	bt      [system_flags],sf_no_scroll
	jc      fade

	cmp     [computer_speed],30000
	jc      fade

	cmp     ebx,123
	je      scroll
	cmp     ebx,321
	jne     fade

scroll:	;create a new screen pointer so new screen is drawn to memory and not screen

	mov     eax,full_screen_width*full_screen_height
	call    my_malloc                       ;allocate space for next screen
	mov     [scroll_addr],eax

	mov     ax,3501h                                ;make a selector
	int     21h
	mov     [scroll_segment],bx

	mov     bx,ds                           ;calculate base address of screen
	mov     ax,3504h
	int     21h

	add     ecx,[scroll_addr]

	mov     ax,3503h                                ;set address for scroll segment
	mov     bx,[scroll_segment]
	int     21h

	mov     bx,[scroll_segment]             ;point screen segment to this work space
	xchg    bx,[screen_segment]
	mov     [scroll_segment],bx

	jmp     done


fade:	;take palette at workspace down to 0

	mov     ecx,64/fade_jump
	call    wait_50hz                       ;try and work to 50hx

fade_loop:      push    ecx

	mov     esi,[work_palette]
	mov     ecx,3*game_colours
col_loop:       test    bpt[esi],-1                     ;already at 0?
	je      is_0

	sub     bpt[esi],fade_jump              ;going down
	jnc     is_0
	mov     bpt[esi],0                      ;compensate for underflow
is_0:   inc     esi
	loop    col_loop

	mov     esi,[work_palette]              ;set the palette
	call    set_palette

	call    wait_50hz

	pop     ecx
	loop    fade_loop

;       palette is all gone

done:   mov     al,1
	ret

fn_fade_down    endp




fn_set_palette  proc

;       eax is palette

	mov     [current_palette],eax

	fetch_compact

;       Copy palette to workspace

	mov     edi,[work_palette]
	mov     ecx,(3*game_colours)/4
	rep     movsd

;       and set the palette

	mov     esi,[work_palette]
	call    set_palette

	mov     al,1
	ret

fn_set_palette  endp




set_palette     proc

;       set screen palette
;       palette data pointed to by esi

;       If display in vertical sync wait for next vertical sync
;       If display in display mode wait for vertiacl sync

	call    get_vsync_flag
	jnc     not_in_v
	call    wait_till_out_v_sync
not_in_v:       call    wait_till_in_v_sync

	xor     al,al
	mov     dx,3c8h
	out     dx,al
	inc     dx
	mov     ecx,vga_colours*3/2
fu_tst: lodsb
	out     dx,al
	loop    fu_tst

	mov     al,vga_colours/2
	mov     dx,3c8h
	out     dx,al
	inc     dx
	mov     ecx,vga_colours*3/2
fu_tst4:        lodsb
	out     dx,al
	loop    fu_tst4

	ret

set_palette     endp




halve_palette   proc

;       start of the sssss

	mov     eax,vga_colours*3                       ;allocate space for half palette
	call    my_malloc
	mov     [half_palette],eax

	mov     esi,[work_palette]
	mov     edi,eax
	mov     ecx,vga_colours*3
half_loop:      lodsb
	shr     al,1
	stosb
	loop    half_loop

	mov     esi,[half_palette]
	call    set_palette

	ret

halve_palette   endp


double_palette  proc

	mov     esi,[work_palette]
	call    set_palette
	mov     eax,[half_palette]
	call    my_free

	ret

double_palette  endp




clear_screen    proc

;       clear front screen

	push    es
	mov     es,[screen_segment]
	clear   eax
	clear   edi
	mov     ecx,full_screen_width*full_screen_height/4
	rep     stosd
	pop     es

	ret

clear_screen    endp




wait_till_in_v_sync     proc

;       Wait until the display is in a vertical sync, wait while in display mode
;       bit 3 = 0 for display mode

	push    eax
	push    edx

llll:   call    get_vsync_flag
	jnc     llll

	pop     edx
	pop     eax

	ret

wait_till_in_v_sync     endp




wait_till_out_v_sync    proc

;       Wait until the display is in display mode, wait while in a vertical sync
;       bit 3 = 1 for in vertical sync

	push    eax
	push    edx

llll:   call    get_vsync_flag
	jc      llll

	pop     edx
	pop     eax

	ret

wait_till_out_v_sync    endp




get_vsync_flag  proc

;       Get the status of the vertical sync flag

;       bit 3 = 0 for display mode
;       bit 3 = 1 for in vertical sync

	mov     dx,3dah
	in      al,dx
	bt      eax,3
	ret

get_vsync_flag  endp




frame   proc

;       Wait for a full screen frame

	call    wait_till_out_v_sync
	call    wait_till_in_v_sync
	ret

frame   endp


end32code

	end
