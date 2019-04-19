include_macros	equ	1
include_scripts	equ	1
include_sequates	equ	1
	include include.asm


start32data
	align 4

	include lists.inc
	include talks.inc

end32data




start32code

fetch_compact_esi	proc

;	Fetch the address of compact eax

	mov	esi,eax				;seperate section from number
	and	esi,0f000h
	shr	esi,12-2				;top four bits * 4
	and	eax,0fffh			;now look at number
	shl	eax,2				;dwords
	add	eax,[esi+offset item_list+section_0_item*4]
	mov	esi,[eax]
	ret

fetch_compact_esi	endp




end32code


;--------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------



start32data
	align 4


;	0 **NOT USED**
item_list	dd	0

;	1 first legal id - std scripts

	dd	0

;	2 module 2	section 1 scripts
	dd	0

;	3 module
	dd	0

;	4
	dd	0

;	5
	dd	0

;	6
	dd	0

;	7
	dd	0

;	8
	dd	0

;	9
	dd	0

;	10
	dd	0



;*******************

;	11
	dd	0 ;full_foster


;	12 foster full size
	dd	0 ;sprite+16

;	13 mini foster
	dd	0 ;mini_foster_sprite+16

;	14
	dd	0 ;up_stairs_spr+16

;	15
	dd	0 ;up_stairs2_spr+16

;	16
	dd	0 ;post

;	17
	dd	0 ;floor


;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *

;	18	used for debugging
	dd	0 ;coordinate_test

;	19
	dd	0

;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *

;	20
	dd	0 ;door

;	21	rm1
	dd	0 ;zdoor

;	22	rm1
	dd	0 ;zfloor

;	23	cursor sprite
	dd	0

;	24
	dd	0 ;text_2

;	25
	dd	0 ;text_3

;	26
	dd	0 ;text_4

;	27
	dd	0 ;text_5

;	28
	dd	0 ;text_6

;	29
	dd	0 ;text_7

;	30
	dd	0 ;text_8

;	31
	dd	0 ;text_9

;	32
	dd	0 ;text_10

;	and their corresponding data items

;	33
	dd	0

;	34	rm1
	dd	0

;	35	rm1
	dd	0

;	36	rm1
	dd	0

;	37	rm1
	dd	0

;	38	rm1
	dd	0

;	39	rm1
	dd	0

;	40	rm1
	dd	0

;	41	rm1
	dd	0

;	42	rm1
	dd	0

;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *

;	43
	dd	0 ;jobsworth

;	44
	dd	0 ;talk1

;	45
	dd	0 ;talk2

;	46
	dd	0 ;menu_bar

;	47
	dd	0 ;left_arrow

;	48
	dd	0 ;right_arrow

;	49 arrow sprites
	dd	0

;	50 menu objects
	dd	0

;	51 blank object 1
	dd	0 ;blank1

;	52 blank object 2
	dd	0 ;blank2

;	53 blank object 3
	dd	0 ;blank3

;	54 blank object 4
	dd	0 ;blank4

;	55 blank object 5
	dd	0 ;blank5

;	56 blank object 6
	dd	0 ;blank6

;	57 blank object 7
	dd	0 ;blank7

;	58 blank object 8
	dd	0 ;blank8

;	59 blank object 9
	dd	0 ;blank9

;	60 blank object 10
	dd	0 ;blank10

;	61 blank object 11
	dd	0 ;blank11

;	62
	dd	0 ;0

;	63 test object
	dd	0 ;test_object

;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *
;	64 layer 0
	dd	0 ;s2_layer_0

;	65 layer 1
	dd	0 ;s2_layer_1

;	66 grid 1
	dd	0 ;s2_grid_1

;	67 low floor - screen 0
	dd	0 ;low_floor

;	68 mini foster - screen 0
	dd	0

;	69 layer_2
	dd	0

;	70
	dd	0

s71	equ	64*71			;dnstairs
;	71
	dd	0

s72	equ	64*72			;dnstair2
;	72
	dd	0


s73	equ	73*64			;mini jobsworth
;	73
	dd	0

;	74
	dd	0

s75	equ	75*64			;smlgard.ams
	dd	0

s76	equ	76*64			;crouch
	dd	0

;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *

first_text_sec	equ	77

;	77	text section 0
	dd	0

;	78	text section 1
	dd	0

;	79	text section 2
	dd	0

;	80	text section 3
	dd	0

;	81	text section 4
	dd	0

;	82	text section 5
	dd	0

;	83	text section 6
	dd	0

;	84	text section 7
	dd	0

;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *

;	85
	dd	0

s86	equ	86*64			;bar
	dd	0

s87	equ	87*64			;get_bar
	dd	0

s88	equ	88*64			;bar_away
	dd	0

s89	equ	89*64			;door
	dd	0

;	90
	dd	0

s91	equ	91*64			;use_bar
	dd	0

;* ** *** **** ***** ****** ******* ****** ***** **** *** ** *

;	92 layer_0 room 1
	dd	0

;	93 layer_1
	dd	0

;	94 grid 1
	dd	0

;	95
	dd	0


s96	equ	96*64			;door
	dd	0

;	97
	dd	0

s98	equ	98*64			;dodoor
	dd	0


s99	equ	99*64			;guard
	dd	0

s100	equ	100*64			;kickdoor
	dd	0

;	101
	dd	0

s102	equ	102*64			;hang
	dd	0

s103	equ	103*64			;grd_shot
	dd	0

s104	equ	104*64			;smldoor
	dd	0

;	105
	dd	0

s106	equ	106*64			;getcig.ams
	dd	0

s107	equ	107*64			;dragcig
	dd	0

s108	equ	108*64			;cigback
	dd	0

s109	equ	109*64			;flickash
	dd	0


s110	equ	110*64			;grd_shot
	dd	0

;	111
	dd	0

;	112 layer_0 room 2
	dd	0

;	113 layer_1
	dd	0

;	114 sc2
	dd	0

;	115
	dd	0

;	116
	dd	0

s117	equ	117*64			;bigjobs
;	117 big jobsworth
	dd	0

grid_vector_id	equ	118

;	118	game grid buffer
	dd	0


;	119	compacts - section 0
	dd	data_0

;	120	compacts - section 1
	dd	data_1

ifdef s1_demo
	dd	data_0,data_0,data_0,data_0,data_0
else
;	121	compacts - section 2
	dd	data_2

;	122	compacts - section 3
	dd	data_3

;	123	compacts - section 4
	dd	data_4

;	124	compacts - section 5
	dd	data_5

;	125	compacts - section 6
	dd	data_6
endif

;	126	compacts - section 7
	dd	0

;	127	compacts - section 8
	dd	0

;	128	compacts - section 9
	dd	0


;	129 to 261
	dd	133 dup (0)

;	262 anita_card
	dd	0

;	263 anchor
	dd	0

;	264 magazine
	dd	0

;	265 video tape
	dd	0

;	266 cable
	dd	0

;	267 cable
	dd	0

;	268 cable
	dd	0

;	269
	dd	0

;	270	smljobst
	dd	0

;	271	dog biscuits
	dd	0

;	272	secateurs
	dd	0

;	273	smljobst
	dd	0

;	274-284	11 text sections

	dd	11 dup (0)

;	285
	dd	0

;	286
	dd	0

;	287
	dd	0

;	288
	dd	0

;	289
	dd	0

;	290
	dd	0

;	291
	dd	0

;	292
	dd	0

;	293
	dd	0

;	294
	dd	0

;	295
	dd	0

;	296
	dd	0

;	297
	dd	0

;	298
	dd	0

;	299
	dd	0

end32data

	end
