include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_flags	equ	1
include_error_codes equ	1
	include include.asm


st_sort_list	struc

y_cord	dw	?
compact	dd	?
sprite	dd	?

st_sort_list	ends


start32data
	align 4

sort_list_size	equ	30
sort_list	st_sort_list sort_list_size dup (<?>)

sprite_x	dd	?			;calculated by draw sprite
sprite_y	dd	?
sprite_w	dd	?
sprite_h	dd	?

mask_x1	dd	?			;pixels to skip on left of sprite
mask_x2	dd	?			;pixels to skip on right of sprite


end32data



start32code
	extrn	load_file:near


sprite_engine	proc

	call	back_sprites
	call	sort_sprites
	call	fore_sprites
se_ret:	ret

fore_sprites:	mov	ecx,1				;test status bit 1 (foreground
	jmp	std_sprites

back_sprites:	clear	ecx				;test status bit 0 (background)

std_sprites:	mov	ebx,offset draw_list_no

std_sp_loop:	flodsd	eax,ebx				;look for draw list
	jife	eax,se_ret

new_draw_list:	fetch_compact edi

back_loop:	;edi points to list
	flodswl eax,edi
	jife	ax,std_sp_loop

;	ax is an id
	cmp	ax,-1
	jne	not_new_list

	movzx	eax,word ptr[edi]
	jmp	new_draw_list

not_new_list:	fetch_compact

	bt	(cpt[esi]).c_status,cx		;is it fore/back ground
	jnc	back_loop

	mov	ax,(cpt[esi]).c_screen		;on this screen?
	cmp	ax,wpt [screen]
	jne	back_loop

;	ecx is fore/back bit
;	ebx points to draw_list_no+1
;	esi is compact
;	edi is current draw_list pointer

	push	ecx
	push	ebx
	push	edi
	push	ecx				;save fore/back for vertical mask

	movzx	eax,(cpt[esi]).c_frame		;get the frame number
	shr	eax,6				;devide by 64
	fetch_item edi,eax

	call	draw_sprite

	pop	ecx
	jifne	ecx,no_v_mask

	call	vertical_mask

no_v_mask:	mov	bl,81h
	bt	(cpt[esi]).c_status,3		;re_create?
	jc	no_reform
	mov	bl,1
no_reform:	call	vector_to_game

	pop	edi
	pop	ebx
	pop	ecx
	jmp	back_loop

;----------------------------------

sort_sprites:	;calculate and sort normal sprites

	mov	ebx,offset draw_list_no

big_sort_loop:	flodsws ax,ebx
	jife	ax,se_ret
	push	ebx

	mov	ebp,offset sort_list
	clear	ecx				;sprite count

a_new_draw_list:	fetch_compact edi			;get list

form_list:	flodsws ax,edi				;get an id
	jife	ax,made_list

	cmp	ax,-1				;new list?
	jne	process_this_id

	mov	ax,[edi]
	jmp	a_new_draw_list

process_this_id:	fetch_compact
	bt	(cpt[esi]).c_status,2		;is it sortable playfield?(!?!)
	jnc	form_list
	mov	ax,(cpt[esi]).c_screen		;on current screen?
	cmp	ax,wpt [screen]
	jne	form_list

	movzx	eax,(cpt[esi]).c_frame		;get frame
	shr	eax,6				;devide by 64
	fetch_item ebx,eax

;	If ebx=0 then the sprite data has not been loaded, a program error
;	The simplest solution is to ignore the sprite

ifdef debug_42
	jifne	ebx,no_error
	printf "Missing file (1) %d",eax
	debug_compact esi,"missing file 1"
	mov	(cpt[esi]).c_status,0
	jmp	form_list
no_error:
else
	jife	ebx,form_list			;just continue
endif

	mov	ax,(cpt[esi]).c_ycood		;calculate y coordinate
	add	ax,(s ptr[ebx]).s_offset_y		;add offset
	add	ax,(s ptr[ebx]).s_height		;get bottom of sprite

	mov	ds:(st_sort_list ptr[ebp]).y_cord,ax
	mov	ds:(st_sort_list ptr[ebp]).compact,esi
	mov	ds:(st_sort_list ptr[ebp]).sprite,ebx
	add	ebp,SIZE st_sort_list
	inc	ecx
	jmp	form_list

made_list:	;now sort the list

	dec	ecx
	js	no_sprites			;no sprites to sort
	mov	edx,ecx
	je	not_my_sort			;1 sprite is already sorted

;	Now really sort the list
bubble_loop:	clear	ebx				;sort flag
	mov	esi,offset sort_list
	mov	ecx,edx
inner_bubble:	mov	ax,[esi]				;first y coordinate
	cmp	ax,[esi+SIZE st_sort_list]		;second y coordinate
	jna	no_swap

	xchg	ax,[esi+SIZE st_sort_list]		;swap y coords
	mov	[esi],ax

	mov	eax,(st_sort_list ptr[esi]).compact	;swap compacts
	xchg	eax,(st_sort_list ptr[esi+SIZE st_sort_list]).compact
	mov	(st_sort_list ptr[esi]).compact,eax

	mov	eax,(st_sort_list ptr[esi]).sprite	;swap sprites
	xchg	eax,(st_sort_list ptr[esi+SIZE st_sort_list]).sprite
	mov	(st_sort_list ptr[esi]).sprite,eax

	mov	bl,1

no_swap:	add	esi,SIZE st_sort_list
	loop	inner_bubble

	jifne	ebx,bubble_loop

not_my_sort:	;now print them all

;	edx is no of sprites-1
	inc	edx

	cherror edx,nc,sort_list_size,em_internal_error

	mov	esi,offset sort_list

print_loop:	push	edx
	push	esi
	mov	edi,(st_sort_list ptr[esi]).sprite
	mov	esi,(st_sort_list ptr[esi]).compact
	call	draw_sprite

	mov	bl,81h
	bt	(cpt[esi]).c_status,3
	jc	not_reform
	mov	bl,1
not_reform:	call	vector_to_game

	bt	(cpt[esi]).c_status,9
	jc	no_vertical_mask
	call	vertical_mask
no_vertical_mask:	pop	esi
	add	esi,SIZE st_sort_list
	pop	edx
	floop	edx,print_loop

no_sprites:	pop	ebx
	jmp	big_sort_loop

sprite_engine	endp




draw_sprite	proc

;	esi points to compact
;	edi points to sprite data

;	if edi=0 then the sprite data has not been loaded, a program bug
;	The simplest solution is to not print the sprite

ifdef debug_42
	jifne	edi,no_error

	movzx	eax,(cpt[esi]).c_frame
	shr	eax,6
	printf "Missing File (2) %d",eax
	debug_compact esi,"Missing file 2"
	mov	[sprite_w],0
	mov	(cpt[esi]).c_status,0
	ret
no_error:
else
	jife	edi,nowt_to_do
endif

	push	esi
	push	edi

     	movzx	ebx,(s ptr[edi]).s_width			;put width and height in
	mov	[sprite_w],ebx
	movzx	edx,(s ptr[edi]).s_height
	mov	[sprite_h],edx
	mov	[mask_x1],0
	mov	[mask_x2],0

	movzx	eax,(cpt[esi]).c_frame			;get pointer to data
	and	ax,3fh
	movsx	ecx,(s ptr[edi]).s_sp_size
	mul	ecx
	add	eax,SIZE s
	add	eax,edi
	mov	ecx,eax					;pointer to sprite data

;	Look at y values

	movzx	eax,(cpt[esi]).c_ycood
	add	ax,(s ptr[edi]).s_offset_y
	sub	eax,top_left_y
	jnc	no_top_clip

;	We must clip the top of the sprite

	neg	eax
	sub	[sprite_h],eax				;do fewer lines
	jna	no_sprite
	mul	(s ptr[edi]).s_width			;offset into sprite
	add	ecx,eax
	clear	eax

no_top_clip:	mov	ebx,game_screen_height
	sub	bx,(s ptr[edi]).s_height
	sub	ebx,eax
	jnc	no_bot_clip

	neg	ebx
	sub	[sprite_h],ebx
	jna	no_sprite

no_bot_clip:	;eax is screen y coordinate

	mov	[sprite_y],eax
	imul	eax,eax,game_screen_width

;	Look at x values

	movzx	ebx,(cpt[esi]).c_xcood
	add	bx,(s ptr[edi]).s_offset_x
	sub	ebx,top_left_x
	jnc	left_ok

;	Need to mask left of sprite

	neg	ebx
	sub	[sprite_w],ebx
	jna	no_sprite
	mov	[mask_x1],ebx
	clear	ebx

left_ok:	mov	edx,game_screen_width
	sub	dx,(s ptr[edi]).s_width
	sub	edx,ebx
	jnc	right_ok

;	Mask right of sprite

	neg	edx
	sub	[sprite_w],edx
	jna	no_sprite
	mov	[mask_x2],edx

right_ok:	mov	[sprite_x],ebx
	add	eax,ebx

	add	eax,[backscreen]				;pointer to where sprite is printed

	mov	ebx,[sprite_w]
	mov	edx,[sprite_h]

	cherror ebx,nc,321,em_internal_error
	cherror dx,nc,192,em_internal_error

	mov	esi,ecx
	mov	edi,eax

draw_loop:	push	edi
	mov	ecx,ebx
	add	esi,[mask_x1]

pix_loop:	lodsb
	jife	al,no_pix
	mov	[edi],al
no_pix:	inc	edi
	floop	ecx,pix_loop
	pop	edi
	add	edi,full_screen_width
	add	esi,[mask_x2]
	floop	dx,draw_loop

	pop	edi
	pop	esi

;	Convert the sprite coordinate/size values to blocks for vertical mask and/or vector to game

	mov	eax,[sprite_x]
	mov	ebx,[sprite_w]
	mov	ecx,[sprite_y]
	mov	edx,[sprite_h]

	add	ebx,eax
	add	ebx,GRID_W-1				;-1 pixel, +1 block for looping
	add	edx,ecx
	add	edx,GRID_H-1

	shr	eax,GRID_W_SHIFT
	shr	ebx,GRID_W_SHIFT
	shr	ecx,GRID_H_SHIFT
	shr	edx,GRID_H_SHIFT

	sub	ebx,eax
	sub	edx,ecx

	mov	[sprite_x],eax
	mov	[sprite_w],ebx
	mov	[sprite_y],ecx
	mov	[sprite_h],edx

	ret

no_sprite:	mov	[sprite_w],0
	pop	edi
	pop	esi
	ret

draw_sprite	endp




vector_to_game	proc

;	Plot sprite onto screen grid
;	plot with value in bl

;	esi is compact
;	edi is sprite data

	mov	ebp,[sprite_h]
	mov	edx,[sprite_w]
	jife	edx,nowt_to_do

	mov	eax,[sprite_y]
	imul	eax,eax,GRID_X
	add	eax,[sprite_x]
	add	eax,[game_grid]

vg_loop1:	push	eax
	mov	cx,dx
vg_loop2:	or	bpt[eax],bl
	inc	eax
	floop	cx,vg_loop2
	pop	eax
	add	eax,GRID_X
	floop	ebp,vg_loop1

nowt_to_do::	ret	;label used elsewhere

vector_to_game	endp




vertical_mask	proc

;	Calculate grid coordinates

	push	esi
	push	edi

	test	[sprite_w],-1
	je	no_plot

	mov	edx,[sprite_y]				;get bottom y
	add	edx,[sprite_h]
	dec	edx

	mov	ecx,edx
	imul	ecx,ecx,GRID_X
	add	ecx,[sprite_x]				;get grid offset
	shl	ecx,1					;words

	mov	eax,edx
	imul	eax,eax,GRID_H*full_screen_width		;calculate screen offset
	mov	ebx,[sprite_x]
	imul	ebx,ebx,GRID_W
	add	eax,ebx
	mov	edi,[backscreen]				;pointer to back screen
	add	edi,eax

;	edi = screen offset
;	ecx = grid offset

	mov	edx,offset layer_1_id			;start with layer 1

layer_loop:	push	edi
	push	ecx
	mov	ebx,[sprite_w]

;	move upwards in vertical strips

x_loop:	push	edx
	push	ebx
	push	ecx
	push	edi

try_nlayer:	mov	eax,12[edx]				;get layer 1 grid item
	jife	eax,next_x
	fetch_item					;pointer to grid in esi

	test	wpt[esi+ecx],-1				;is there a block here?
	jne	start_x

	lea	edx,4[edx]				;try a new layer
	jmp	try_nlayer

start_x:	mov	ebp,[sprite_h]				;move all the way up

block_loop:	push	edx					;save current layer
	push	esi

try_dummy:	movzx	eax,wpt[esi+ecx]				;get block
	jife	ax,next_x_edx				;anything here?
	js	dummy_block				;check for dummy block
	dec	eax

	push	ecx
	push	edi

;	Do block eax

	imul	eax,eax,GRID_W*GRID_H			;get pointer to data
	mov	ecx,[edx]
	fetch_item esi,ecx				;pointer to source
	add	esi,eax

	mov	ch,GRID_H

block_loop2:	push	edi
	mov	cl,GRID_W

pix_loop:	lodsb
	jife	al,no_pix
	mov	[edi],al
no_pix:	inc	edi
	floop	cl,pix_loop
	
	pop	edi
	add	edi,full_screen_width
	floop	ch,block_loop2

	pop	edi
	pop	ecx
dummy_end:	pop	esi
	sub	edi,GRID_H*full_screen_width
	sub	ecx,GRID_X*2				;up one
	pop	edx
	floop	ebp,block_loop

	jmp	next_x

dummy_block:	jmp	dummy_end	;Shorley not???

	lea	edx,4[edx]				;try another layer
	mov	eax,12[edx]
	fetch_item
	jifne	eax,try_dummy
	jmp	dummy_end

next_x_edx:	pop	esi
	pop	edx
next_x:	pop	edi
	add	edi,GRID_W
	pop	ecx
	add	ecx,2
	pop	ebx
	pop	edx
	floop	ebx,x_loop

;	try for another layer

	pop	ecx
	pop	edi
	lea	edx,4[edx]
	test	dpt 12[edx],-1
	jne	layer_loop

no_plot:	pop	edi
	pop	esi

	ret

vertical_mask	endp


end32code

	end
