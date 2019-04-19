include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_error_codes equ	1
	include include.asm



route_grid_width	equ	((game_screen_width/8)+2)
route_grid_height	equ	((game_screen_height/8)+2)
route_grid_size	equ	(route_grid_width*route_grid_height*2)
walk_jump	equ	8				;walk in blocks of 8

check_block	macro offst
	local label

	test	wpt[esi+(offst)],-1		;check for empty or a wall
	jle	label
	cmp	[esi+(offst)],ax
	jnc	label
	mov	ax,[esi+offst]
	mov	[grid_changed],1
label:
endm




start32data

route_grid	dd	?				;pointer to route data grid

direction_x	dd	?
direction_y	dd	?

ar_init_x	dw	?
ar_init_y	dw	?
ar_post_x	dw	?
ar_post_y	dw	?

grid_changed	dd	?

route_data	dd	?				;pointer to where route data goes

end32data


start32code


initialise_router	proc

	mov	eax,route_grid_size
	call	my_malloc
	mov	[route_grid],eax

	ret

initialise_router	endp




auto_route	proc

;	esi is compact to route.

	mov	eax,(cpt[esi]).c_anim_scratch	;find where to put route data
	mov	[route_data],eax

;	Initially only do the player, and don't terminate routes half way.

	movzx	eax,(cpt[esi]).c_screen		;get current screen
	mov	al,bpt [offset grid_convert_table+eax]
	cherror al,nc,tot_no_grids,em_internal_error
	imul	eax,grid_size
	add	eax,[game_grids]
	add	eax,grid_size-4			;point to end of grid (makes stretching easier)
	mov	edx,esi				;put compact in here
	mov	esi,eax
	mov	edi,[route_grid]
	add	edi,route_grid_size-2
	std					;do it all backwards
	movzx	eax,(cpt[edx]).c_mega_set		;get the width of the mega
	mov	bh,bpt (cpt[edx+eax]).c_grid_width
	clear	bl				;bh:bl are stretching registers

;	First clear the bottom line and right hand edge of next line

	mov	ecx,route_grid_width+1
	clear	eax
	rep	stosw

	mov	ebp,route_grid_height-2
	mov	ch,route_grid_width-2

	lodsd					;get 4 bytes of grid data
	mov	cl,32

stretch:	shr	eax,1				;check a bit
	jc	bit_set

;	This bit is clear, are we still stretching

	jifne	bl,still_stretching

	mov	wpt[edi],0			;this block is free
	jmp	next_stretch

still_stretching:	;Still stretching from a previous block

	dec	bl
	mov	wpt[edi],-1
	jmp	next_stretch

bit_set:	mov	wpt[edi],-1
	mov	bl,bh				;set up stretch factor

next_stretch:	sub	edi,2

	floop	cl,still_bits			;check for end of bit pattern
	lodsd
	mov	cl,32

still_bits:	dec	ch
	jne	stretch

;	floop	ch,stretch			;do a line

	mov	dpt[edi-2],0			;do edges
	lea	edi,[edi-4]
	mov	ch,route_grid_width-2
	xor	bl,bl				;clear stretch factor

	floop	ebp,stretch			;and do the whole grid

;	Finally clear the top line (right hand edge already done)

	clear	eax
	mov	ecx,route_grid_width-1
	rep	stosw

	cld

;	The grid has been initialised.

;	Calculate the start and end points

	clear	eax
	mov	[ar_init_x],ax				;clear start and end offsets
	mov	[ar_init_y],ax
	mov	[ar_post_x],ax
	mov	[ar_post_y],ax

	mov	ax,(cpt[edx]).c_ycood
	sub	ax,136					;change coordinate systems
	jnc	no_init_y1

	mov	[ar_init_y],ax
	clear	ax

no_init_y1:	cmp	ax,game_screen_height
	jc	no_init_y2

	sub	ax,game_screen_height
	mov	[ar_init_y],ax
	mov	ax,game_screen_height-1

no_init_y2:	shr	ax,3					;change into blocks
	mov	bh,al					;and save it

	mov	ax,(cpt[edx]).c_xcood
	sub	ax,128					;change coordinate systems
	jnc	no_init_x1

	mov	[ar_init_x],ax
	clear	ax

no_init_x1:	cmp	ax,game_screen_width
	jc	no_init_x2

	sub	ax,game_screen_width-1		;changed to -1 to match amiga
	mov	[ar_init_x],ax
	mov	ax,game_screen_width-1

no_init_x2:	shr	ax,3					;change into blocks
	mov	bl,al					;and save it

;	and destination

	mov	ax,(cpt[edx]).c_ar_target_y
	sub	ax,136					;change coordinate systems
	jnc	no_post_y1

	mov	[ar_post_y],ax
	clear	ax

no_post_y1:	cmp	ax,game_screen_height
	jc	no_post_y2

	sub	ax,game_screen_height
	mov	[ar_post_y],ax
	mov	ax,game_screen_height-1

no_post_y2:	shr	ax,3					;change into blocks
	mov	ch,al					;and save it

	mov	ax,(cpt[edx]).c_ar_target_x
	sub	ax,128					;change coordinate systems
	jnc	no_post_x1

	mov	[ar_post_x],ax
	clear	ax

no_post_x1:	cmp	ax,game_screen_width
	jc	no_post_x2

	sub	ax,game_screen_width
	mov	[ar_post_x],ax
	mov	ax,game_screen_width-1

no_post_x2:	shr	ax,3					;change into blocks
	mov	cl,al					;and save it

;	bh:bl is source y,x
;	ch:cl is destination y,x

	cmp	bh,ch
	jne	yes_route
	cmp	bl,cl
	je	empty_route

yes_route:	;Work out the route calculation direction

	cmp	bh,ch
	jc	go_down

	mov	[direction_y],-(route_grid_width*2)		;go up
	mov	dh,bh					;this no of lines to do
	jmp	go_up

go_down:	mov	[direction_y],route_grid_width*2		;go down
	mov	dh,route_grid_height-1	;-2
	sub	dh,bh					;this no of lines to do

go_up:	cmp	bl,cl
	jc	go_right

	mov	[direction_x],-2				;go left
	mov	dl,bl					;this no of lines to do
	add	dl,2
	jmp	go_left

go_right:	mov	[direction_x],2				;go right
	mov	dl,route_grid_width-1	;2		;-1 put in 8/7/93
	sub	dl,bl

go_left:	shl	cx,1					;multiply values by 2
	mov	al,route_grid_width			;calculate destination address
	mul	ch
	add	al,cl
	adc	ah,0
	mov	edi,eax
	add	edi,[route_grid]
	add	edi,(route_grid_width+1)*2			;skip blank edges

	shl	bx,1					;mpy vals by 2
	mov	al,route_grid_width			;calculate source address
	mul	bh
	add	al,bl
	adc	ah,0
	mov	esi,eax
	add	esi,[route_grid]
	add	esi,(route_grid_width+1)*2			;skip blank edges
	mov	wpt[esi],1				;start this one off

	cmp	dh,route_grid_height-3	;2			;if we are not on the edge,
	jnc	not_hor_edge				;move diagonally from start
	sub	esi,[direction_y]
not_hor_edge:	cmp	dl,route_grid_width-2
	jnc	not_ver_edge
	sub	esi,[direction_x]
not_ver_edge:

;	So,	dh:dl is no of blocks to check in y,x
;		esi = start address
;		edi = destination address

;	If destination is a wall then we have no route

	test	wpt[edi],-1
	jne	no_route

;	mov	wpt[edi],0				;IF DEST IS WALL REMOVE WALL	WHY?????

wallow_y:	mov	ch,dh
	push	esi
	mov	[grid_changed],0

wallow_x:	mov	cl,dl
	push	esi

wallow:	;do current block
	test	wpt[esi],-1				;only do block if block not done yet
	jne	block_done

;	ignore a block if it is empty or a wall
	mov	ax,-1
	check_block 2
	check_block -2
	check_block route_grid_width*2
	check_block -route_grid_width*2

	inc	ax					;add 1, will turn wall (-1) into 0
	je	block_done
	mov	[esi],ax

block_done:	add	esi,[direction_x]				;onwards horizontally
	floop	cl,wallow

	pop	esi
	add	esi,[direction_y]
	floop	ch,wallow_x

	pop	esi
	test	wpt[edi],-1				;have we found the route?
	jne	route_found

	test	[grid_changed],-1				;will we ever find the route?
	je	no_route

;	We have done a section, see if we want to shift backwards

	cmp	dh,route_grid_height-4
	jnc	no_move_ver
	sub	esi,[direction_y]
	inc	dh
no_move_ver:	cmp	dl,route_grid_width-4
	jnc	no_move_hor
	sub	esi,[direction_x]
	inc	dl
no_move_hor:	jmp	wallow_y

route_found:	;The time has come, to work out the route

	mov	esi,[route_data]				;and point to where route data goes
	add	esi,route_space-2				;go backwards
	mov	wpt[esi],0				;route is null terminated

	mov	ax,[edi]					;get final value
	dec	ax					;and look for the path to this door

;	check left and right first as this means last animation type is horizontal,
;	looks better when exiting left or right

check_dir:	cmp	ax,[edi-2]				;look left
	je	look_left
	cmp	ax,[edi+2]				;look right
	je	look_right
	cmp	ax,[edi-route_grid_width*2]		;look up
	je	look_up

	cherror ax,ne,[edi+route_grid_width*2],em_internal_error	;MUST be look down

	jmp	look_down

;	Must be right
look_right:	sub	esi,4
	mov	wpt[esi+2],lefty				;going backwards remember
	mov	wpt[esi],walk_jump
right_loop:	dec	ax
	je	route_done
	add	edi,2
	cmp	ax,[edi+2]				;keep checking right
	jne	check_dir
	add	wpt[esi],walk_jump
	jmp	right_loop

look_left:	;going left
	sub	esi,4
	mov	wpt[esi+2],righty				;going backwards remember
	mov	wpt[esi],walk_jump
left_loop:	dec	ax
	je	route_done
	sub	edi,2
	cmp	ax,[edi-2]				;keep checking left
	jne	check_dir
	add	wpt[esi],walk_jump
	jmp	left_loop

look_up:	;going up
	sub	esi,4
	mov	wpt[esi+2],downy				;going backwards remember
	mov	wpt[esi],walk_jump
up_loop:	dec	ax
	je	route_done
	sub	edi,route_grid_width*2
	cmp	ax,[edi-route_grid_width*2]		;keep checking up
	jne	check_dir
	add	wpt[esi],walk_jump
	jmp	up_loop

look_down:	;going down
	sub	esi,4
	mov	wpt[esi+2],upy				;going backwards remember
	mov	wpt[esi],walk_jump
down_loop:	dec	ax
	je	route_done
	add	edi,route_grid_width*2
	cmp	ax,[edi+route_grid_width*2]		;keep checking up
	jne	check_dir
	add	wpt[esi],walk_jump
	jmp	down_loop

route_done:	;if there was an initial x/y movement tag it onto the start

	mov	ax,[ar_init_x]
	or	ax,ax
	je	no_init_x
	js	init_right
	mov	bx,lefty
	jmp	init_left
init_right:	mov	bx,righty
	neg	ax
init_left:	sub	esi,4
	mov	2[esi],bx
	add	ax,7			;was +1, changed to match amiga
	and	ax,0fff8h
	mov	[esi],ax

no_init_x:	;esi points to the start of the route data
	cherror esi,c,[route_data],em_internal_error

	mov	eax,1					;signal success
	debug_route

	ret

empty_route:	mov	esi,[route_data]				;point to zero route
	mov	wpt[esi],0
	mov	eax,1
	debug_route
	ret

no_route:	mov	eax,2					;signal route failure
ifdef ar_debug
	mov	wpt[edi],-1
	debug_route
endif
	ret

auto_route	endp

ifdef ar_debug

proc_start	_draw_box__Nciiii

;	void draw_box(int col,int x,int y,int w,int h);

db_col	equ	24
db_x	equ	20
db_y	equ	16
db_w	equ	12
db_h	equ	8

	mov	eax,full_screen_width
	mul	dpt db_y[ebp]
	add	eax,db_x[ebp]
	mov	edi,eax
	push	es
	mov	es,[screen_segment]
	mov	al,db_col[ebp]
	mov	edx,db_h[ebp]

box_loop:	push	edi
	mov	ecx,db_w[ebp]
	rep	stosb
	pop	edi
	add	edi,full_screen_width
	floop	edx,box_loop

	pop	es

proc_end	_draw_box__Nciiii,20


endif

end32code

	end
