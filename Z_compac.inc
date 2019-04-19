start32data



z_compact_table	dd 0 dup (0)

zt	dd 0 dup (0)

data_0	dd	0
	dd	joey
	dd	joey_park
	dd	foster
	dd	std_menu_logic
	dd	text_mouse
	dd	gallcard_menu
	dd	rs_mega_alive
	dd	citycard_menu
	dd	shades_menu
	dd	putty_menu
	dd	lightbulb_menu
	dd	low_get_seq
	dd	mini_shrug_seq
	dd	sml_up_mid_get_seq
	dd	new_grid
	dd	lamb
	dd	floor
	dd	coordinate_test
	dd	save_restore_mouse
	dd	whole_screen
	dd	l_talk_s2
	dd	r_talk_s2


first_text_compact	equ	23
	dd	text_1
	dd	text_2
	dd	text_3
	dd	text_4
	dd	text_5
	dd	text_6
	dd	text_7
	dd	text_8
	dd	text_9
	dd	text_10
	dd	text_11
	dd	wd40_menu
	dd	skey_menu
	dd	secateurs_menu
	dd	rope_menu
	dd	plaster_menu
	dd	new_cable_menu
	dd	shrug_seq
	dd	rad_shrug_seq
	dd	brick_menu
	dd	tongs_menu
	dd	talk1
	dd	talk2
	dd	menu_bar
	dd	left_arrow
	dd	right_arrow
	dd	dog_food_menu
	dd	0
	dd	blank1
	dd	blank2
	dd	blank3
	dd	blank4
	dd	blank5
	dd	blank6
	dd	blank7
	dd	blank8
	dd	blank9
	dd	blank10
	dd	blank11
	dd	0
	dd	crow_bar_menu
	dd	sarnie_menu
	dd	spanner_menu
	dd	joeyb_menu
	dd	low_floor
	dd	0
	dd	stairs
	dd	upstairs
	dd	anita_card_menu
	dd	rs_lamb_to_three
	dd	rs_lamb_start_2
	dd	anchor_menu
	dd	magazine_menu
	dd	tape_menu
	dd	glass_menu
	dd	rs_lamb_start_3
	dd	ticket_menu
	dd	s29_fast_list
	dd	s6_fast_list
	dd	fast_list_sc3
	dd	s9_fast_list
	dd	s10_fast_list
	dd	bar
	dd	s11_fast_list
	dd	fast_list_0
	dd	s0_fast_list
	dd	s7_fast_list
	dd	door
	dd	s28_fast_list
	dd	swing_list
	dd	0
	dd	0
	dd	outside_ledge
	dd	0
	dd	r1_door
	dd	0
	dd	0
	dd	0
	dd	0
	dd	fast_list_sc90
	dd	0
	dd	0
	dd	small_door
	dd	sc85_fast_list
	dd	sc85_chip_list
	dd	sc85_logic_list
	dd	sc85_mouse_list
	dd	sc85_palette
	dd	right_exit0
	dd	0
	dd	0
	dd	0
	dd	s2_floor
	dd	0
	dd	s101_chip_list
	dd	s101_pal
	dd	s101_mouse
	dd	s101_logic
	dd	full_screen
	dd	cancel_button
	dd	button_0
	dd	button_1
	dd	button_2
	dd	button_3
	dd	button_4
	dd	button_5
	dd	button_6
	dd	button_7
	dd	button_8
	dd	button_9
	dd	rs_left_arrow
	dd	rs_right_arrow
	dd	rs_blank
	dd	monitor
	dd	anita
	dd	0
	dd	0
	dd	0
	dd	baby_logic_list
	dd	rs_l_arr_linc
	dd	rs_r_arr_linc
	dd	rs_blanks_linc
	dd	s5_fast_list
	dd	but_e
	dd	but_0
	dd	but_1
	dd	but_2
	dd	but_3
	dd	but_4
	dd	but_5
	dd	but_6
	dd	but_7
	dd	but_8
	dd	but_9
	dd	0
	dd	s102_chip_list
	dd	s102_pal
	dd	s102_logic
	dd	s102_mouse
	dd	restart_butt
	dd	restart_seq
	dd	restore_butt
	dd	restore_seq
	dd	seq1_pal
	dd	seq2_pal
	dd	seq3_pal
	dd	fast_intro
	dd	chip_intro
	dd	fast_intro_2
	dd	fast_intro_3
	dd	retina_scan
	dd	retina_scan_cdt
	dd	exit_butt
	dd	exit_seq
	dd	forklift_cpt
	dd	forklift1_cdt
	dd	forklift2_cdt



end32data

start32save_data



forklift_cpt	dw	l_script
	dw	st_background+st_logic+st_recreate
	dw	0
	dw	15
	dw	NULL
	dd	NULL
	dw	NULL
	dw	NULL
	dw	s93
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	forklift_logic
	dw	0



end32save_data

start32data



forklift1_cdt	dw	s93
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	1
	dw	289
	dw	291
	dw	2
	dw	289
	dw	291
	dw	3
	dw	289
	dw	291
	dw	4
	dw	289
	dw	291
	dw	5
	dw	289
	dw	291
	dw	6
	dw	289
	dw	291
	dw	7
	dw	289
	dw	291
	dw	8
	dw	289
	dw	291
	dw	9
	dw	289
	dw	291
	dw	10
	dw	289
	dw	291
	dw	11
	dw	289
	dw	291
	dw	12
	dw	289
	dw	291
	dw	13
	dw	289
	dw	291
	dw	14
	dw	289
	dw	291
	dw	15
	dw	289
	dw	291
	dw	16
	dw	289
	dw	291
	dw	17
	dw	289
	dw	291
	dw	18
	dw	289
	dw	291
	dw	19
	dw	289
	dw	291
	dw	20
	dw	289
	dw	291
	dw	21
	dw	289
	dw	291
	dw	22
	dw	289
	dw	291
	dw	23
	dw	289
	dw	291
	dw	24
	dw	289
	dw	291
	dw	25
	dw	289
	dw	291
	dw	26
	dw	289
	dw	291
	dw	27
	dw	289
	dw	291
	dw	28
	dw	289
	dw	291
	dw	29
	dw	289
	dw	291
	dw	30
	dw	289
	dw	291
	dw	31
	dw	289
	dw	291
	dw	32
	dw	289
	dw	291
	dw	33
	dw	289
	dw	291
	dw	34
	dw	289
	dw	291
	dw	35
	dw	289
	dw	291
	dw	36
	dw	289
	dw	291
	dw	37
	dw	289
	dw	290
	dw	38
	dw	289
	dw	289
	dw	39
	dw	289
	dw	288
	dw	37
	dw	289
	dw	287
	dw	38
	dw	289
	dw	286
	dw	39
	dw	289
	dw	285
	dw	37
	dw	289
	dw	284
	dw	38
	dw	289
	dw	283
	dw	39
	dw	289
	dw	282
	dw	37
	dw	289
	dw	281
	dw	38
	dw	289
	dw	280
	dw	39
	dw	289
	dw	279
	dw	37
	dw	291
	dw	291
	dw	40
	dw	291
	dw	291
	dw	41
	dw	291
	dw	291
	dw	42
	dw	291
	dw	291
	dw	43
	dw	291
	dw	291
	dw	44
	dw	291
	dw	291
	dw	45
	dw	291
	dw	291
	dw	46
	dw	291
	dw	291
	dw	47
	dw	291
	dw	291
	dw	48
	dw	291
	dw	291
	dw	49
	dw	291
	dw	291
	dw	50
	dw	291
	dw	291
	dw	51
	dw	291
	dw	291
	dw	52
	dw	291
	dw	291
	dw	53
	dw	291
	dw	291
	dw	54
	dw	291
	dw	291
	dw	55
	dw	291
	dw	291
	dw	56
	dw	291
	dw	291
	dw	57
	dw	292
	dw	291
	dw	58
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	292
	dw	291
	dw	0
	dw	0


forklift2_cdt	dw	s94
	dw	291
	dw	292
	dw	0
	dw	291
	dw	292
	dw	1
	dw	291
	dw	292
	dw	2
	dw	291
	dw	292
	dw	3
	dw	291
	dw	292
	dw	4
	dw	291
	dw	292
	dw	5
	dw	291
	dw	292
	dw	6
	dw	291
	dw	292
	dw	7
	dw	291
	dw	292
	dw	8
	dw	291
	dw	292
	dw	9
	dw	291
	dw	292
	dw	10
	dw	291
	dw	292
	dw	11
	dw	291
	dw	292
	dw	12
	dw	291
	dw	292
	dw	13
	dw	291
	dw	292
	dw	14
	dw	291
	dw	292
	dw	15
	dw	291
	dw	292
	dw	16
	dw	291
	dw	292
	dw	17
	dw	291
	dw	292
	dw	18
	dw	291
	dw	280
	dw	19
	dw	291
	dw	281
	dw	20
	dw	291
	dw	282
	dw	21
	dw	291
	dw	283
	dw	19
	dw	291
	dw	284
	dw	20
	dw	291
	dw	285
	dw	21
	dw	291
	dw	286
	dw	19
	dw	291
	dw	287
	dw	20
	dw	291
	dw	288
	dw	21
	dw	291
	dw	289
	dw	19
	dw	291
	dw	290
	dw	20
	dw	291
	dw	291
	dw	21
	dw	291
	dw	292
	dw	19
	dw	291
	dw	292
	dw	22
	dw	291
	dw	292
	dw	23
	dw	291
	dw	292
	dw	24
	dw	291
	dw	292
	dw	25
	dw	291
	dw	292
	dw	26
	dw	291
	dw	292
	dw	27
	dw	291
	dw	292
	dw	28
	dw	291
	dw	292
	dw	29
	dw	291
	dw	292
	dw	30
	dw	291
	dw	292
	dw	31
	dw	291
	dw	292
	dw	32
	dw	291
	dw	292
	dw	33
	dw	292
	dw	292
	dw	34
	dw	292
	dw	292
	dw	35
	dw	292
	dw	292
	dw	36
	dw	292
	dw	292
	dw	37
	dw	292
	dw	292
	dw	38
	dw	292
	dw	292
	dw	39
	dw	292
	dw	292
	dw	40
	dw	292
	dw	292
	dw	41
	dw	292
	dw	292
	dw	42
	dw	292
	dw	292
	dw	43
	dw	293
	dw	292
	dw	44
	dw	293
	dw	292
	dw	45
	dw	297
	dw	292
	dw	46
	dw	297
	dw	292
	dw	47
	dw	299
	dw	292
	dw	48
	dw	299
	dw	292
	dw	49
	dw	299
	dw	292
	dw	50
	dw	299
	dw	292
	dw	51
	dw	299
	dw	292
	dw	52
	dw	299
	dw	292
	dw	53
	dw	299
	dw	292
	dw	54
	dw	299
	dw	292
	dw	55
	dw	299
	dw	292
	dw	56
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	299
	dw	292
	dw	57
	dw	0


retina_scan_cdt	dw	s151
	dw	378
	dw	302
	dw	0
	dw	378
	dw	302
	dw	0
	dw	378
	dw	302
	dw	1
	dw	378
	dw	302
	dw	2
	dw	378
	dw	302
	dw	3
	dw	378
	dw	302
	dw	4
	dw	378
	dw	302
	dw	5
	dw	378
	dw	302
	dw	6
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	7
	dw	378
	dw	302
	dw	8
	dw	378
	dw	302
	dw	9
	dw	378
	dw	302
	dw	10
	dw	378
	dw	302
	dw	11
	dw	378
	dw	302
	dw	12
	dw	378
	dw	302
	dw	13
	dw	378
	dw	302
	dw	13
	dw	378
	dw	302
	dw	14
	dw	378
	dw	302
	dw	15
	dw	378
	dw	302
	dw	16
	dw	378
	dw	302
	dw	17
	dw	0


fast_intro_2	dw	189+disk_15
	dw	190+disk_15
	dw	191+disk_15
	dw	0


fast_intro_3	dw	192+disk_15
	dw	193+disk_15
	dw	194+disk_15
	dw	0


fast_intro	dw	183+disk_15
	dw	184+disk_15
	dw	185+disk_15
	dw	186+disk_15
	dw	0


chip_intro	dw	187+disk_15
	dw	188+disk_15
	dw	195+disk_15
	dw	196+disk_15
	dw	197+disk_15
	dw	0


seq1_pal	dw	0
	dw	291
	dw	309
	dw	546
	dw	1075
	dw	1093
	dw	1314
	dw	1586
	dw	1604
	dw	1622
	dw	2133
	dw	2097
	dw	2114
	dw	2390
	dw	2387
	dw	2626
	dw	2167
	dw	2662
	dw	2679
	dw	2900
	dw	3138
	dw	3156
	dw	2696
	dw	3377
	dw	3190
	dw	3464
	dw	3685
	dw	3650
	dw	3668
	dw	3857
	dw	3703
	dw	3736


seq2_pal	dw	0
	dw	256
	dw	512
	dw	512
	dw	529
	dw	1024
	dw	1552
	dw	1296
	dw	1042
	dw	1552
	dw	2064
	dw	1568
	dw	2320
	dw	2080
	dw	2576
	dw	2337
	dw	2320
	dw	1842
	dw	2337
	dw	2849
	dw	3104
	dw	2848
	dw	2353
	dw	2866
	dw	2883
	dw	2882
	dw	3138
	dw	3394
	dw	3155
	dw	3411
	dw	3412
	dw	3428


seq3_pal	dw	0
	dw	1075
	dw	2932
	dw	3701
	dw	801
	dw	1586
	dw	2114
	dw	529
	dw	2916
	dw	785
	dw	1620
	dw	3154
	dw	818
	dw	529
	dw	3683
	dw	529
	dw	802
	dw	1587
	dw	802
	dw	1330
	dw	2643
	dw	2934
	dw	546
	dw	546
	dw	1092
	dw	3410
	dw	273
	dw	273
	dw	3410
	dw	2882
	dw	1057
	dw	3718


s5_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	17+disk_2
	dw	18+disk_2
	dw	113+disk_2
	dw	0


rs_l_arr_linc	dw	c_frame
	dw	s190
	dw	c_base_sub
	dw	linc_menu_script
	dw	c_base_sub+2
	dw	0
	dw	-1


rs_r_arr_linc	dw	c_frame
	dw	1+s190
	dw	c_base_sub
	dw	linc_menu_script
	dw	c_base_sub+2
	dw	0
	dw	-1


rs_blanks_linc	dw	c_frame
	dw	s191
	dw	c_base_sub
	dw	linc_menu_script
	dw	c_base_sub+2
	dw	0
	dw	-1


baby_logic_list	dw	id_foster
	dw	0


rs_left_arrow	dw	c_frame
	dw	s49
	dw	c_base_sub
	dw	menu_script
	dw	c_base_sub+2
	dw	0
	dw	-1


rs_right_arrow	dw	c_frame
	dw	s49+1
	dw	c_base_sub
	dw	menu_script
	dw	c_base_sub+2
	dw	0
	dw	-1


rs_blank	dw	c_frame
	dw	s50
	dw	c_base_sub
	dw	menu_script
	dw	c_base_sub+2
	dw	0
	dw	-1



end32data

start32save_data



coordinate_test	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	128+8
	dw	136+8
	dw	s19
	dw	0
	dw	0
	dw	0
	dw	click_debug
	dw	0
	dw	0
	dw	64
	dw	12


text_1	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	136
	dw	327-16
	dw	s274
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_2	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s275
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_3	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s276
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_4	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s277
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_5	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s278
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_6	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s279
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_7	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s280
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_8	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s281
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_9	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s282
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_10	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s283
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


text_11	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s284
	dw	0
	dw	text_on
	dw	text_off
	dw	text_click
	dw	0
	dw	0
	dw	320
	dw	12
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0


joey	dw	l_script
	dw	0
	dw	0
	dw	2
	dw	115
	dd	0
	dw	320
	dw	304
	dw	s173+12
	dw	3
	dw	std_on
	dw	std_off
	dw	mega_click
	dw	-10
	dw	-16
	dw	20
	dw	25
	dw	shout_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	c_base_mode
	dw	joey_logic
	dw	0
	dd	0
	dd	0
	dd	0
	dw	3
	dw	std_mega_stop
	dw	std_mini_bump
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96
	dw	sp_col_joey
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	joey_auto
	dw	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	ljoey_up
	dd	ljoey_down
	dd	ljoey_left
	dd	ljoey_right
	dd	ljoey_st_up
	dd	ljoey_st_down
	dd	ljoey_st_left
	dd	ljoey_st_right
	dd	0
	dd	0
	dd	ljoey_u_to_d
	dd	ljoey_u_to_l
	dd	ljoey_u_to_r
	dd	0
	dd	ljoey_d_to_u
	dd	0
	dd	ljoey_d_to_l
	dd	ljoey_d_to_r
	dd	0
	dd	ljoey_l_to_u
	dd	ljoey_l_to_d
	dd	0
	dd	ljoey_l_to_r
	dd	0
	dd	ljoey_r_to_u
	dd	ljoey_r_to_d
	dd	ljoey_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	wjoey_up
	dd	wjoey_down
	dd	wjoey_left
	dd	wjoey_right
	dd	wjoey_st_up
	dd	wjoey_st_down
	dd	wjoey_st_left
	dd	wjoey_st_right
	dd	0
	dd	0
	dd	wjoey_u_to_d
	dd	wjoey_u_to_l
	dd	wjoey_u_to_r
	dd	0
	dd	wjoey_d_to_u
	dd	0
	dd	wjoey_d_to_l
	dd	wjoey_d_to_r
	dd	0
	dd	wjoey_l_to_u
	dd	wjoey_l_to_d
	dd	0
	dd	wjoey_l_to_r
	dd	0
	dd	wjoey_r_to_u
	dd	wjoey_r_to_d
	dd	wjoey_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	0
	dw	8
	dw	8
	dd	sjoey_up
	dd	sjoey_down
	dd	sjoey_left
	dd	sjoey_right
	dd	sjoey_st_up
	dd	sjoey_st_down
	dd	sjoey_st_left
	dd	sjoey_st_right
	dd	0
	dd	0
	dd	sjoey_u_to_d
	dd	sjoey_u_to_l
	dd	sjoey_u_to_r
	dd	0
	dd	sjoey_d_to_u
	dd	0
	dd	sjoey_d_to_l
	dd	sjoey_d_to_r
	dd	0
	dd	sjoey_l_to_u
	dd	sjoey_l_to_d
	dd	0
	dd	sjoey_l_to_r
	dd	0
	dd	sjoey_r_to_u
	dd	sjoey_r_to_d
	dd	sjoey_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0


joey_auto	db	64 dup (0)



end32save_data

start32data



ljoey_left	dw	2
	dw	4+s173
	dw	-2
	dw	0
	dw	2
	dw	5+s173
	dw	-2
	dw	0
	dw	2
	dw	6+s173
	dw	-2
	dw	0
	dw	2
	dw	7+s173
	dw	-2
	dw	0
	dw	2
	dw	8+s173
	dw	-2
	dw	0
	dw	2
	dw	9+s173
	dw	-2
	dw	0
	dw	2
	dw	10+s173
	dw	-2
	dw	0
	dw	2
	dw	11+s173
	dw	-2
	dw	0
	dw	0


ljoey_right	dw	2
	dw	12+s173
	dw	2
	dw	0
	dw	2
	dw	13+s173
	dw	2
	dw	0
	dw	2
	dw	14+s173
	dw	2
	dw	0
	dw	2
	dw	15+s173
	dw	2
	dw	0
	dw	2
	dw	16+s173
	dw	2
	dw	0
	dw	2
	dw	17+s173
	dw	2
	dw	0
	dw	2
	dw	18+s173
	dw	2
	dw	0
	dw	2
	dw	19+s173
	dw	2
	dw	0
	dw	0


ljoey_up	dw	1
	dw	0+s173
	dw	0
	dw	-1
	dw	1
	dw	1+s173
	dw	0
	dw	-1
	dw	0


ljoey_down	dw	1
	dw	2+s173
	dw	0
	dw	1
	dw	1
	dw	3+s173
	dw	0
	dw	1
	dw	0


ljoey_st_up	dw	s173
	dw	1
	dw	1
	dw	0
	dw	0


ljoey_st_down	dw	s173
	dw	1
	dw	1
	dw	2
	dw	0


ljoey_st_left	dw	s173
	dw	1
	dw	1
	dw	4
	dw	0


ljoey_st_right	dw	s173
	dw	1
	dw	1
	dw	12
	dw	0


ljoey_r_to_u	dw	22+s173
	dw	0


ljoey_r_to_d	dw	23+s173
	dw	0


ljoey_r_to_l	dw	22+s173
	dw	0+s173
	dw	21+s173
	dw	0


ljoey_u_to_d	dw	21+s173
	dw	4+s173
	dw	20+s173
	dw	0


ljoey_u_to_l	dw	21+s173
	dw	0


ljoey_u_to_r	dw	22+s173
	dw	0


ljoey_d_to_u	dw	23+s173
	dw	12+s173
	dw	22+s173
	dw	0


ljoey_d_to_l	dw	20+s173
	dw	0


ljoey_d_to_r	dw	23+s173
	dw	0


ljoey_l_to_u	dw	21+s173
	dw	0


ljoey_l_to_d	dw	20+s173
	dw	0


ljoey_l_to_r	dw	20+s173
	dw	2+s173
	dw	23+s173
	dw	0


wjoey_left	dw	2
	dw	4+s136
	dw	-2
	dw	0
	dw	2
	dw	5+s136
	dw	-2
	dw	0
	dw	2
	dw	6+s136
	dw	-2
	dw	0
	dw	2
	dw	7+s136
	dw	-2
	dw	0
	dw	2
	dw	8+s136
	dw	-2
	dw	0
	dw	2
	dw	9+s136
	dw	-2
	dw	0
	dw	2
	dw	10+s136
	dw	-2
	dw	0
	dw	2
	dw	11+s136
	dw	-2
	dw	0
	dw	0


wjoey_right	dw	2
	dw	12+s136
	dw	2
	dw	0
	dw	2
	dw	13+s136
	dw	2
	dw	0
	dw	2
	dw	14+s136
	dw	2
	dw	0
	dw	2
	dw	15+s136
	dw	2
	dw	0
	dw	2
	dw	16+s136
	dw	2
	dw	0
	dw	2
	dw	17+s136
	dw	2
	dw	0
	dw	2
	dw	18+s136
	dw	2
	dw	0
	dw	2
	dw	19+s136
	dw	2
	dw	0
	dw	0


wjoey_up	dw	1
	dw	0+s136
	dw	0
	dw	-1
	dw	1
	dw	1+s136
	dw	0
	dw	-1
	dw	0


wjoey_down	dw	1
	dw	2+s136
	dw	0
	dw	1
	dw	1
	dw	3+s136
	dw	0
	dw	1
	dw	0


wjoey_st_up	dw	s136
	dw	1
	dw	1
	dw	0
	dw	0


wjoey_st_down	dw	s136
	dw	1
	dw	1
	dw	2
	dw	0


wjoey_st_left	dw	s136
	dw	1
	dw	1
	dw	4
	dw	0


wjoey_st_right	dw	s136
	dw	1
	dw	1
	dw	12
	dw	0


wjoey_r_to_u	dw	22+s136
	dw	0


wjoey_r_to_d	dw	23+s136
	dw	0


wjoey_r_to_l	dw	22+s136
	dw	0+s136
	dw	21+s136
	dw	0


wjoey_u_to_d	dw	21+s136
	dw	4+s136
	dw	20+s136
	dw	0


wjoey_u_to_l	dw	21+s136
	dw	0


wjoey_u_to_r	dw	22+s136
	dw	0


wjoey_d_to_u	dw	23+s136
	dw	12+s136
	dw	22+s136
	dw	0


wjoey_d_to_l	dw	20+s136
	dw	0


wjoey_d_to_r	dw	23+s136
	dw	0


wjoey_l_to_u	dw	21+s136
	dw	0


wjoey_l_to_d	dw	20+s136
	dw	0


wjoey_l_to_r	dw	20+s136
	dw	2+s136
	dw	23+s136
	dw	0


sjoey_left	dw	1
	dw	4+s86
	dw	-1
	dw	0
	dw	1
	dw	5+s86
	dw	-1
	dw	0
	dw	1
	dw	6+s86
	dw	-1
	dw	0
	dw	1
	dw	7+s86
	dw	-1
	dw	0
	dw	0


sjoey_right	dw	1
	dw	8+s86
	dw	1
	dw	0
	dw	1
	dw	9+s86
	dw	1
	dw	0
	dw	1
	dw	10+s86
	dw	1
	dw	0
	dw	1
	dw	11+s86
	dw	1
	dw	0
	dw	0


sjoey_up	dw	1
	dw	0+s86
	dw	0
	dw	-1
	dw	1
	dw	1+s86
	dw	0
	dw	-1
	dw	0


sjoey_down	dw	1
	dw	2+s86
	dw	0
	dw	1
	dw	1
	dw	3+s86
	dw	0
	dw	1
	dw	0


sjoey_st_up	dw	s86
	dw	1
	dw	1
	dw	0
	dw	0


sjoey_st_down	dw	s86
	dw	1
	dw	1
	dw	2
	dw	0


sjoey_st_left	dw	s86
	dw	1
	dw	1
	dw	4
	dw	0


sjoey_st_right	dw	s86
	dw	1
	dw	1
	dw	8
	dw	0


sjoey_r_to_u	dw	15+s86
	dw	0


sjoey_r_to_d	dw	12+s86
	dw	0


sjoey_r_to_l	dw	15+s86
	dw	0+s86
	dw	14+s86
	dw	0


sjoey_u_to_d	dw	14+s86
	dw	4+s86
	dw	13+s86
	dw	0


sjoey_u_to_l	dw	14+s86
	dw	0


sjoey_u_to_r	dw	15+s86
	dw	0


sjoey_d_to_u	dw	12+s86
	dw	8+s86
	dw	15+s86
	dw	0


sjoey_d_to_l	dw	13+s86
	dw	0


sjoey_d_to_r	dw	12+s86
	dw	0


sjoey_l_to_u	dw	14+s86
	dw	0


sjoey_l_to_d	dw	13+s86
	dw	0


sjoey_l_to_r	dw	13+s86
	dw	2+s86
	dw	12+s86
	dw	0



end32data

start32save_data



joey_park	dw	NULL
	dw	0
	dw	NULL
	dw	0
	dw	NULL
	dd	park_table


park_table	dw	id_slot
	dw	get_to_slot
	dw	-1


c68	dd 0 dup (0)

foster	dw	l_script
	dw	st_sort+st_recreate+st_logic+st_ar_priority+st_grid_plot+st_collision
	dw	0
	dw	safe_start_screen
	dw	67
	dd	0
	dw	160
	dw	280
	dw	s13
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	c_base_mode
	dw	base_intro
	dw	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	std_player_stop
	dw	std_mini_bump
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96+32
	dw	sp_col_foster
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	minif_auto
	dw	0
	dw	0
	dw	0
	dw	8
	dw	8
	dd	mfoster_up
	dd	mfoster_down
	dd	mfoster_left
	dd	mfoster_right
	dd	mfoster_st_up
	dd	mfoster_st_down
	dd	mfoster_st_left
	dd	mfoster_st_right
	dd	0
	dd	0
	dd	mfoster_u_to_d
	dd	mfoster_u_to_l
	dd	mfoster_u_to_r
	dd	0
	dd	mfoster_d_to_u
	dd	0
	dd	mfoster_d_to_l
	dd	mfoster_d_to_r
	dd	0
	dd	mfoster_l_to_u
	dd	mfoster_l_to_d
	dd	0
	dd	mfoster_l_to_r
	dd	0
	dd	mfoster_r_to_u
	dd	mfoster_r_to_d
	dd	mfoster_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	foster_up
	dd	foster_down
	dd	foster_left
	dd	foster_right
	dd	foster_st_up
	dd	foster_st_down
	dd	foster_st_left
	dd	foster_st_right
	dd	foster_st_talk
	dd	0
	dd	foster_u_to_d
	dd	foster_u_to_l
	dd	foster_u_to_r
	dd	foster_u_to_t
	dd	foster_d_to_u
	dd	0
	dd	foster_d_to_l
	dd	foster_d_to_r
	dd	0
	dd	foster_l_to_u
	dd	foster_l_to_d
	dd	0
	dd	foster_l_to_r
	dd	foster_l_to_t
	dd	foster_r_to_u
	dd	foster_r_to_d
	dd	foster_r_to_l
	dd	0
	dd	0
	dd	foster_t_to_u
	dd	0
	dd	foster_t_to_l
	dd	0
	dd	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	fradman_up
	dd	fradman_down
	dd	fradman_left
	dd	fradman_right
	dd	fradman_st_up
	dd	fradman_st_down
	dd	fradman_st_left
	dd	fradman_st_right
	dd	fradman_st_talk
	dd	0
	dd	fradman_u_to_d
	dd	fradman_u_to_l
	dd	fradman_u_to_r
	dd	0
	dd	fradman_d_to_u
	dd	0
	dd	fradman_d_to_l
	dd	fradman_d_to_r
	dd	0
	dd	fradman_l_to_u
	dd	fradman_l_to_d
	dd	0
	dd	fradman_l_to_r
	dd	0
	dd	fradman_r_to_u
	dd	fradman_r_to_d
	dd	fradman_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	bfoster_up
	dd	bfoster_down
	dd	bfoster_left
	dd	bfoster_right
	dd	bfoster_st_up
	dd	bfoster_st_down
	dd	bfoster_st_left
	dd	bfoster_st_right
	dd	0
	dd	0
	dd	bfoster_u_to_d
	dd	bfoster_u_to_l
	dd	bfoster_u_to_r
	dd	0
	dd	bfoster_d_to_u
	dd	0
	dd	bfoster_d_to_l
	dd	bfoster_d_to_r
	dd	0
	dd	bfoster_l_to_u
	dd	bfoster_l_to_d
	dd	0
	dd	bfoster_l_to_r
	dd	0
	dd	bfoster_r_to_u
	dd	bfoster_r_to_d
	dd	bfoster_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0



end32save_data

start32data



bfoster_left	dw	4
	dw	20+s182
	dw	-4
	dw	0
	dw	4
	dw	21+s182
	dw	-4
	dw	0
	dw	4
	dw	22+s182
	dw	-4
	dw	0
	dw	4
	dw	23+s182
	dw	-4
	dw	0
	dw	4
	dw	24+s182
	dw	-4
	dw	0
	dw	4
	dw	25+s182
	dw	-4
	dw	0
	dw	4
	dw	26+s182
	dw	-4
	dw	0
	dw	4
	dw	27+s182
	dw	-4
	dw	0
	dw	4
	dw	28+s182
	dw	-4
	dw	0
	dw	4
	dw	29+s182
	dw	-4
	dw	0
	dw	0


bfoster_right	dw	4
	dw	30+s182
	dw	4
	dw	0
	dw	4
	dw	31+s182
	dw	4
	dw	0
	dw	4
	dw	32+s182
	dw	4
	dw	0
	dw	4
	dw	33+s182
	dw	4
	dw	0
	dw	4
	dw	34+s182
	dw	4
	dw	0
	dw	4
	dw	35+s182
	dw	4
	dw	0
	dw	4
	dw	36+s182
	dw	4
	dw	0
	dw	4
	dw	37+s182
	dw	4
	dw	0
	dw	4
	dw	38+s182
	dw	4
	dw	0
	dw	4
	dw	39+s182
	dw	4
	dw	0
	dw	0


bfoster_up	dw	2
	dw	0+s182
	dw	0
	dw	-2
	dw	2
	dw	1+s182
	dw	0
	dw	-2
	dw	2
	dw	2+s182
	dw	0
	dw	-2
	dw	2
	dw	3+s182
	dw	0
	dw	-2
	dw	2
	dw	4+s182
	dw	0
	dw	-2
	dw	2
	dw	5+s182
	dw	0
	dw	-2
	dw	2
	dw	6+s182
	dw	0
	dw	-2
	dw	2
	dw	7+s182
	dw	0
	dw	-2
	dw	2
	dw	8+s182
	dw	0
	dw	-2
	dw	2
	dw	9+s182
	dw	0
	dw	-2
	dw	0


bfoster_down	dw	2
	dw	10+s182
	dw	0
	dw	2
	dw	2
	dw	11+s182
	dw	0
	dw	2
	dw	2
	dw	12+s182
	dw	0
	dw	2
	dw	2
	dw	13+s182
	dw	0
	dw	2
	dw	2
	dw	14+s182
	dw	0
	dw	2
	dw	2
	dw	15+s182
	dw	0
	dw	2
	dw	2
	dw	16+s182
	dw	0
	dw	2
	dw	2
	dw	17+s182
	dw	0
	dw	2
	dw	2
	dw	18+s182
	dw	0
	dw	2
	dw	2
	dw	19+s182
	dw	0
	dw	2
	dw	0


bfoster_st_up	dw	s182
	dw	1
	dw	0
	dw	44
	dw	0


bfoster_st_down	dw	s182
	dw	1
	dw	0
	dw	40
	dw	0


bfoster_st_left	dw	s182
	dw	1
	dw	0
	dw	42
	dw	0


bfoster_st_right	dw	s182
	dw	1
	dw	0
	dw	46
	dw	0


bfoster_r_to_u	dw	45+s182
	dw	0


bfoster_r_to_d	dw	47+s182
	dw	0


bfoster_r_to_l	dw	45+s182
	dw	44+s182
	dw	43+s182
	dw	0


bfoster_u_to_d	dw	43+s182
	dw	42+s182
	dw	41+s182
	dw	0


bfoster_u_to_l	dw	43+s182
	dw	0


bfoster_u_to_r	dw	45+s182
	dw	0


bfoster_d_to_u	dw	47+s182
	dw	46+s182
	dw	45+s182
	dw	0


bfoster_d_to_l	dw	41+s182
	dw	0


bfoster_d_to_r	dw	47+s182
	dw	0


bfoster_l_to_u	dw	43+s182
	dw	0


bfoster_l_to_d	dw	41+s182
	dw	0


bfoster_l_to_r	dw	41+s182
	dw	40+s182
	dw	47+s182
	dw	0


minif_auto	db	64 dup (0)


fradman_left	dw	4
	dw	20+s90
	dw	-4
	dw	0
	dw	4
	dw	21+s90
	dw	-4
	dw	0
	dw	4
	dw	22+s90
	dw	-4
	dw	0
	dw	4
	dw	23+s90
	dw	-4
	dw	0
	dw	4
	dw	24+s90
	dw	-4
	dw	0
	dw	4
	dw	25+s90
	dw	-4
	dw	0
	dw	4
	dw	26+s90
	dw	-4
	dw	0
	dw	4
	dw	27+s90
	dw	-4
	dw	0
	dw	4
	dw	28+s90
	dw	-4
	dw	0
	dw	4
	dw	29+s90
	dw	-4
	dw	0
	dw	0


fradman_right	dw	4
	dw	30+s90
	dw	4
	dw	0
	dw	4
	dw	31+s90
	dw	4
	dw	0
	dw	4
	dw	32+s90
	dw	4
	dw	0
	dw	4
	dw	33+s90
	dw	4
	dw	0
	dw	4
	dw	34+s90
	dw	4
	dw	0
	dw	4
	dw	35+s90
	dw	4
	dw	0
	dw	4
	dw	36+s90
	dw	4
	dw	0
	dw	4
	dw	37+s90
	dw	4
	dw	0
	dw	4
	dw	38+s90
	dw	4
	dw	0
	dw	4
	dw	39+s90
	dw	4
	dw	0
	dw	0


fradman_up	dw	2
	dw	0+s90
	dw	0
	dw	-2
	dw	2
	dw	1+s90
	dw	0
	dw	-2
	dw	2
	dw	2+s90
	dw	0
	dw	-2
	dw	2
	dw	3+s90
	dw	0
	dw	-2
	dw	2
	dw	4+s90
	dw	0
	dw	-2
	dw	2
	dw	5+s90
	dw	0
	dw	-2
	dw	2
	dw	6+s90
	dw	0
	dw	-2
	dw	2
	dw	7+s90
	dw	0
	dw	-2
	dw	2
	dw	8+s90
	dw	0
	dw	-2
	dw	2
	dw	9+s90
	dw	0
	dw	-2
	dw	0


fradman_down	dw	2
	dw	10+s90
	dw	0
	dw	2
	dw	2
	dw	11+s90
	dw	0
	dw	2
	dw	2
	dw	12+s90
	dw	0
	dw	2
	dw	2
	dw	13+s90
	dw	0
	dw	2
	dw	2
	dw	14+s90
	dw	0
	dw	2
	dw	2
	dw	15+s90
	dw	0
	dw	2
	dw	2
	dw	16+s90
	dw	0
	dw	2
	dw	2
	dw	17+s90
	dw	0
	dw	2
	dw	2
	dw	18+s90
	dw	0
	dw	2
	dw	2
	dw	19+s90
	dw	0
	dw	2
	dw	0


fradman_st_up	dw	s90
	dw	1
	dw	0
	dw	44
	dw	0


fradman_st_down	dw	s90
	dw	1
	dw	0
	dw	40
	dw	0


fradman_st_left	dw	s90
	dw	1
	dw	0
	dw	42
	dw	0


fradman_st_right	dw	s90
	dw	1
	dw	0
	dw	46
	dw	0


fradman_st_talk	dw	s97
	dw	1
	dw	0
	dw	0
	dw	0


fradman_r_to_u	dw	45+s90
	dw	0


fradman_r_to_d	dw	47+s90
	dw	0


fradman_r_to_l	dw	45+s90
	dw	44+s90
	dw	43+s90
	dw	0


fradman_u_to_d	dw	43+s90
	dw	42+s90
	dw	41+s90
	dw	0


fradman_u_to_l	dw	43+s90
	dw	0


fradman_u_to_r	dw	45+s90
	dw	0


fradman_d_to_u	dw	47+s90
	dw	46+s90
	dw	45+s90
	dw	0


fradman_d_to_l	dw	41+s90
	dw	0


fradman_d_to_r	dw	47+s90
	dw	0


fradman_l_to_u	dw	43+s90
	dw	0


fradman_l_to_d	dw	41+s90
	dw	0


fradman_l_to_r	dw	41+s90
	dw	40+s90
	dw	47+s90
	dw	0


mfoster_left	dw	2
	dw	20+s13
	dw	-2
	dw	0
	dw	2
	dw	21+s13
	dw	-2
	dw	0
	dw	2
	dw	22+s13
	dw	-2
	dw	0
	dw	2
	dw	23+s13
	dw	-2
	dw	0
	dw	2
	dw	24+s13
	dw	-2
	dw	0
	dw	2
	dw	25+s13
	dw	-2
	dw	0
	dw	2
	dw	26+s13
	dw	-2
	dw	0
	dw	2
	dw	27+s13
	dw	-2
	dw	0
	dw	2
	dw	28+s13
	dw	-2
	dw	0
	dw	2
	dw	29+s13
	dw	-2
	dw	0
	dw	0


mfoster_right	dw	2
	dw	30+s13
	dw	2
	dw	0
	dw	2
	dw	31+s13
	dw	2
	dw	0
	dw	2
	dw	32+s13
	dw	2
	dw	0
	dw	2
	dw	33+s13
	dw	2
	dw	0
	dw	2
	dw	34+s13
	dw	2
	dw	0
	dw	2
	dw	35+s13
	dw	2
	dw	0
	dw	2
	dw	36+s13
	dw	2
	dw	0
	dw	2
	dw	37+s13
	dw	2
	dw	0
	dw	2
	dw	38+s13
	dw	2
	dw	0
	dw	2
	dw	39+s13
	dw	2
	dw	0
	dw	0


mfoster_up	dw	1
	dw	0+s13
	dw	0
	dw	-1
	dw	1
	dw	1+s13
	dw	0
	dw	-1
	dw	1
	dw	2+s13
	dw	0
	dw	-1
	dw	1
	dw	3+s13
	dw	0
	dw	-1
	dw	1
	dw	4+s13
	dw	0
	dw	-1
	dw	1
	dw	5+s13
	dw	0
	dw	-1
	dw	1
	dw	6+s13
	dw	0
	dw	-1
	dw	1
	dw	7+s13
	dw	0
	dw	-1
	dw	1
	dw	8+s13
	dw	0
	dw	-1
	dw	1
	dw	9+s13
	dw	0
	dw	-1
	dw	0


mfoster_down	dw	1
	dw	10+s13
	dw	0
	dw	1
	dw	1
	dw	11+s13
	dw	0
	dw	1
	dw	1
	dw	12+s13
	dw	0
	dw	1
	dw	1
	dw	13+s13
	dw	0
	dw	1
	dw	1
	dw	14+s13
	dw	0
	dw	1
	dw	1
	dw	15+s13
	dw	0
	dw	1
	dw	1
	dw	16+s13
	dw	0
	dw	1
	dw	1
	dw	17+s13
	dw	0
	dw	1
	dw	1
	dw	18+s13
	dw	0
	dw	1
	dw	1
	dw	19+s13
	dw	0
	dw	1
	dw	0


mfoster_st_up	dw	s13
	dw	1
	dw	1
	dw	44
	dw	0


mfoster_st_down	dw	s13
	dw	1
	dw	1
	dw	40
	dw	0


mfoster_st_left	dw	s13
	dw	1
	dw	1
	dw	42
	dw	0


mfoster_st_right	dw	s13
	dw	1
	dw	1
	dw	46
	dw	0


mfoster_r_to_u	dw	45+s13
	dw	0


mfoster_r_to_d	dw	47+s13
	dw	0


mfoster_r_to_l	dw	45+s13
	dw	44+s13
	dw	43+s13
	dw	0


mfoster_u_to_d	dw	43+s13
	dw	42+s13
	dw	41+s13
	dw	0


mfoster_u_to_l	dw	43+s13
	dw	0


mfoster_u_to_r	dw	45+s13
	dw	0


mfoster_d_to_u	dw	47+s13
	dw	46+s13
	dw	45+s13
	dw	0


mfoster_d_to_l	dw	41+s13
	dw	0


mfoster_d_to_r	dw	47+s13
	dw	0


mfoster_l_to_u	dw	43+s13
	dw	0


mfoster_l_to_d	dw	41+s13
	dw	0


mfoster_l_to_r	dw	41+s13
	dw	40+s13
	dw	47+s13
	dw	0


foster_left	dw	4
	dw	20+s12
	dw	-4
	dw	0
	dw	4
	dw	21+s12
	dw	-4
	dw	0
	dw	4
	dw	22+s12
	dw	-4
	dw	0
	dw	4
	dw	23+s12
	dw	-4
	dw	0
	dw	4
	dw	24+s12
	dw	-4
	dw	0
	dw	4
	dw	25+s12
	dw	-4
	dw	0
	dw	4
	dw	26+s12
	dw	-4
	dw	0
	dw	4
	dw	27+s12
	dw	-4
	dw	0
	dw	4
	dw	28+s12
	dw	-4
	dw	0
	dw	4
	dw	29+s12
	dw	-4
	dw	0
	dw	0


foster_right	dw	4
	dw	30+s12
	dw	4
	dw	0
	dw	4
	dw	31+s12
	dw	4
	dw	0
	dw	4
	dw	32+s12
	dw	4
	dw	0
	dw	4
	dw	33+s12
	dw	4
	dw	0
	dw	4
	dw	34+s12
	dw	4
	dw	0
	dw	4
	dw	35+s12
	dw	4
	dw	0
	dw	4
	dw	36+s12
	dw	4
	dw	0
	dw	4
	dw	37+s12
	dw	4
	dw	0
	dw	4
	dw	38+s12
	dw	4
	dw	0
	dw	4
	dw	39+s12
	dw	4
	dw	0
	dw	0


foster_up	dw	2
	dw	0+s12
	dw	0
	dw	-2
	dw	2
	dw	1+s12
	dw	0
	dw	-2
	dw	2
	dw	2+s12
	dw	0
	dw	-2
	dw	2
	dw	3+s12
	dw	0
	dw	-2
	dw	2
	dw	4+s12
	dw	0
	dw	-2
	dw	2
	dw	5+s12
	dw	0
	dw	-2
	dw	2
	dw	6+s12
	dw	0
	dw	-2
	dw	2
	dw	7+s12
	dw	0
	dw	-2
	dw	2
	dw	8+s12
	dw	0
	dw	-2
	dw	2
	dw	9+s12
	dw	0
	dw	-2
	dw	0


foster_down	dw	2
	dw	10+s12
	dw	0
	dw	2
	dw	2
	dw	11+s12
	dw	0
	dw	2
	dw	2
	dw	12+s12
	dw	0
	dw	2
	dw	2
	dw	13+s12
	dw	0
	dw	2
	dw	2
	dw	14+s12
	dw	0
	dw	2
	dw	2
	dw	15+s12
	dw	0
	dw	2
	dw	2
	dw	16+s12
	dw	0
	dw	2
	dw	2
	dw	17+s12
	dw	0
	dw	2
	dw	2
	dw	18+s12
	dw	0
	dw	2
	dw	2
	dw	19+s12
	dw	0
	dw	2
	dw	0


s_count	equ	0


s_frame	equ	2


s_ar_x	equ	4


s_ar_y	equ	6


s_length	equ	8


foster_st_up	dw	s12
	dw	1
	dw	0
	dw	44
	dw	0


foster_st_down	dw	s12
	dw	1
	dw	0
	dw	40
	dw	0


foster_st_left	dw	s12
	dw	1
	dw	0
	dw	42
	dw	0


foster_st_right	dw	s12
	dw	1
	dw	0
	dw	46
	dw	0


foster_st_talk	dw	s135
	dw	1
	dw	0
	dw	0
	dw	0


foster_r_to_u	dw	45+s12
	dw	0


foster_r_to_d	dw	47+s12
	dw	0


foster_r_to_l	dw	45+s12
	dw	44+s12
	dw	43+s12
	dw	0


foster_u_to_d	dw	43+s12
	dw	42+s12
	dw	41+s12
	dw	0


foster_u_to_l	dw	43+s12
	dw	0


foster_u_to_r	dw	45+s12
	dw	0


foster_u_to_t	dw	45+s12
	dw	46+s12
	dw	0


foster_d_to_u	dw	47+s12
	dw	46+s12
	dw	45+s12
	dw	0


foster_d_to_l	dw	41+s12
	dw	0


foster_d_to_r	dw	47+s12
	dw	0


foster_l_to_u	dw	43+s12
	dw	0


foster_l_to_d	dw	41+s12
	dw	0


foster_l_to_r	dw	41+s12
	dw	40+s12
	dw	47+s12
	dw	0


foster_l_to_t	dw	41+s12
	dw	40+s12
	dw	0


foster_t_to_u	dw	47+s12
	dw	46+s12
	dw	45+s12
	dw	0


foster_t_to_l	dw	40+s12
	dw	41+s12
	dw	0


shrug_seq	dw	s12
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	0


rad_shrug_seq	dw	s90
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	0


mini_shrug_seq	dw	s13
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	48
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	1
	dw	1
	dw	49
	dw	0


sml_up_mid_get_seq	dw	s22
	dw	1
	dw	1
	dw	0
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	0
	dw	0


std_menu_logic	dw	18
	dw	47
	dw	48
	dw	63
	dw	64
	dw	65
	dw	66
	dw	ido_citycard
	dw	ido_shades
	dw	ido_putty
	dw	ido_lightbulb
	dw	ido_wd40
	dw	ido_skey
	dw	ido_anita_card
	dw	ido_anchor
	dw	ido_magazine
	dw	ido_tape
	dw	ido_glass
	dw	ido_rope
	dw	ido_new_cable
	dw	ido_ticket
	dw	ido_secateurs
	dw	ido_plaster
	dw	ido_brick
	dw	ido_tongs
	dw	ido_dog_food
	dw	ido_gallcard
	dw	51
	dw	52
	dw	53
	dw	54
	dw	55
	dw	56
	dw	57
	dw	58
	dw	59
	dw	60
	dw	61
	dw	33
	dw	32
	dw	31
	dw	30
	dw	29
	dw	28
	dw	27
	dw	26
	dw	25
	dw	24
	dw	23
	dw	0


text_mouse	dw	18
	dw	23
	dw	24
	dw	25
	dw	26
	dw	27
	dw	28
	dw	29
	dw	30
	dw	31
	dw	32
	dw	33
	dw	47
	dw	48
	dw	51
	dw	52
	dw	53
	dw	54
	dw	55
	dw	56
	dw	57
	dw	58
	dw	59
	dw	60
	dw	61
	dw	63
	dw	64
	dw	65
	dw	66
	dw	ido_citycard
	dw	ido_shades
	dw	ido_putty
	dw	ido_lightbulb
	dw	ido_wd40
	dw	ido_skey
	dw	ido_anita_card
	dw	ido_anchor
	dw	ido_magazine
	dw	ido_tape
	dw	ido_glass
	dw	ido_rope
	dw	ido_new_cable
	dw	ido_ticket
	dw	ido_secateurs
	dw	ido_plaster
	dw	ido_brick
	dw	ido_tongs
	dw	ido_dog_food
	dw	ido_gallcard
	dw	46
	dw	0


rs_mega_alive	dw	c_status
	dw	st_sort+st_recreate+st_logic+st_grid_plot+st_collision+st_mouse
	dw	-1



end32data

start32save_data



floor	dw	0
	dw	st_mouse
	dw	0
	dw	0
	dw	NULL
	dd	high_floor_table
	dw	152
	dw	208
	dw	0
	dw	0
	dw	0
	dw	0
	dw	advisor_188
	dw	0
	dw	0
	dw	248
	dw	23
	dw	floor_action


high_floor_table	dw	67
	dw	stairs_from_high
	dw	70
	dw	stairs_from_high
	dw	85
	dw	get_to_bar
	dw	90
	dw	get_to_fexit
	dw	17
	dw	return_ok
	dw	id_notice
	dw	get_to_notice
	dw	0


l_talk_s2	dd 0 dup (0)

r_talk_s2	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	s2_talk_table



end32save_data

start32data



s2_talk_table	dw	21
	dw	return_ok
	dw	22
	dw	return_ok
	dw	116
	dw	get_to_el2
	dw	id_r_exit_s2
	dw	get_to_er2
	dw	115
	dw	std_adjoin_floor
	dw	id_light1
	dw	get_to_light1
	dw	id_hole
	dw	get_to_hole
	dw	id_dead_loader
	dw	get_to_transporter
	dw	id_top_lift
	dw	get_to_lifter
	dw	id_robot_shell
	dw	get_to_shell
	dw	id_panel
	dw	get_to_leds
	dw	-1



end32data

start32save_data



talk1	dd 0 dup (0)

talk2	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	talk_table



end32save_data

start32data



talk_table	dw	67
	dw	std_adjoin_floor
	dw	69
	dw	stairs_from_low
	dw	44
	dw	return_ok
	dw	45
	dw	return_ok
	dw	105
	dw	get_to_small_door
	dw	111
	dw	get_to_er0
	dw	17
	dw	stairs_from_low



end32data

start32save_data



low_floor	dw	0
	dw	st_mouse
	dw	0
	dw	0
	dw	NULL
	dd	low_floor_table
	dw	163
	dw	272
	dw	0
	dw	0
	dw	0
	dw	0
	dw	advisor_188
	dw	0
	dw	0
	dw	237
	dw	40
	dw	floor_action



end32save_data

start32data



low_floor_table	dw	105
	dw	get_to_small_door
	dw	111
	dw	get_to_er0
	dw	69
	dw	stairs_from_low
	dw	17
	dw	stairs_from_low
	dw	id_low_floor
	dw	return_ok
	dw	44
	dw	get_to_talk1
	dw	45
	dw	get_to_talk2
	dw	id_upload
	dw	get_to_upload
	dw	id_press
	dw	get_to_press
	dw	0



end32data

start32save_data



stairs	dw	0
	dw	st_mouse
	dw	0
	dw	0
	dw	NULL
	dd	stair_table
	dw	194
	dw	306
	dw	0
	dw	4147
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	12
	dw	14
	dw	stair_action



end32save_data

start32data



stair_table	dw	67
	dw	std_adjoin_floor
	dw	17
	dw	climb_stairs
	dw	44
	dw	get_to_talk1
	dw	45
	dw	get_to_talk2
	dw	69
	dw	return_ok
	dw	105
	dw	get_to_small_door
	dw	111
	dw	get_to_er0
	dw	id_upload
	dw	get_to_upload
	dw	id_press
	dw	get_to_press
	dw	0



end32data

start32save_data



upstairs	dw	0
	dw	st_mouse
	dw	0
	dw	0
	dw	NULL
	dd	upstair_table
	dw	164
	dw	207
	dw	0
	dw	4147
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	200-164
	dw	211-207
	dw	upstair_action



end32save_data

start32data



upstair_table	dw	67
	dw	decend
	dw	17
	dw	std_adjoin_floor
	dw	70
	dw	return_ok
	dw	85
	dw	get_to_bar
	dw	90
	dw	get_to_fexit
	dw	id_notice
	dw	get_to_notice
	dw	0



end32data

start32save_data



bar	dw	0
	dw	st_mouse+st_foreground+st_recreate
	dw	0
	dw	0
	dw	NULL
	dd	bar_table
	dw	143
	dw	205
	dw	s86
	dw	4295
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	13+4
	dw	3
	dw	bar_action



end32save_data

start32data



bar_table	dw	17
	dw	std_adjoin_floor
	dw	67
	dw	stairs_from_high
	dw	70
	dw	stairs_from_high
	dw	90
	dw	get_to_fexit
	dw	85
	dw	return_ok
	dw	id_notice
	dw	get_to_notice



end32data

start32save_data



door	dw	l_script
	dw	st_mouse+st_background+st_recreate+st_logic
	dw	0
	dw	0
	dw	NULL
	dd	door_table
	dw	400
	dw	167
	dw	s89
	dw	4148
	dw	fexit_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	16
	dw	58
	dw	fire_exit_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	c_base_mode
	dw	fexit_door
	dw	0



end32save_data

start32data



door_table	dw	17
	dw	std_adjoin_floor
	dw	67
	dw	stairs_from_high
	dw	70
	dw	stairs_from_high
	dw	85
	dw	get_to_bar
	dw	90
	dw	get_to_fexit
	dw	id_notice
	dw	get_to_notice
	dw	-1



end32data

start32save_data



small_door	dw	l_script
	dw	st_mouse+st_background+st_recreate+st_logic
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	163
	dw	248
	dw	s104
	dw	4148
	dw	small_door_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	9
	dw	36
	dw	small_door_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	c_base_mode
	dw	small_door_logic
	dw	0



end32save_data

start32data



sml_door_table	dw	17
	dw	stairs_from_low
	dw	105
	dw	return_ok
	dw	111
	dw	get_to_er0
	dw	69
	dw	stairs_from_low
	dw	67
	dw	std_adjoin_floor
	dw	44
	dw	get_to_talk1
	dw	45
	dw	get_to_talk2



end32data

start32save_data



right_exit0	dw	0
	dw	st_mouse
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	393
	dw	250
	dw	0
	dw	1+t7
	dw	std_exit_right_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	9
	dw	36
	dw	er0_action


outside_ledge	dw	0
	dw	st_mouse
	dw	0
	dw	1
	dw	NULL
	dd	ledge_table
	dw	192
	dw	224+8
	dw	0
	dw	0
	dw	0
	dw	0
	dw	advisor_188
	dw	0
	dw	0
	dw	64
	dw	33-8
	dw	floor_action



end32save_data

start32data



ledge_table	dw	95
	dw	return_ok
	dw	97
	dw	get_to_r1_door
	dw	id_notice2
	dw	get_to_notice2
	dw	id_ss_sign
	dw	get_to_ss_sign
	dw	-1



end32data

start32save_data



r1_door	dw	l_script
	dw	st_mouse+st_background+st_recreate+st_logic
	dw	0
	dw	1
	dw	NULL
	dd	r1door_table
	dw	186
	dw	177
	dw	s96
	dw	4148
	dw	out_exit_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	16
	dw	64
	dw	s1_door_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	c_base_mode
	dw	r1exit_door
	dw	0



end32save_data

start32data



r1door_table	dw	95
	dw	std_adjoin_floor
	dw	97
	dw	get_to_r1_door
	dw	id_notice2
	dw	get_to_notice2
	dw	id_ss_sign
	dw	get_to_ss_sign
	dw	-1



end32data

start32save_data



s2_floor	dw	0
	dw	st_mouse
	dw	0
	dw	2
	dw	NULL
	dd	r2_floor_table
	dw	152
	dw	224
	dw	0
	dw	0
	dw	0
	dw	0
	dw	advisor_188
	dw	0
	dw	0
	dw	240
	dw	71
	dw	floor_action



end32save_data

start32data



r2_floor_table	dw	115
	dw	return_ok
	dw	id_l_exit_s2
	dw	get_to_el2
	dw	id_r_exit_s2
	dw	get_to_er2
	dw	id_top_lift
	dw	get_to_lifter
	dw	21
	dw	get_to_talk21
	dw	22
	dw	get_to_talk22
	dw	id_light1
	dw	get_to_light1
	dw	id_panel
	dw	get_to_leds
	dw	id_hole
	dw	get_to_hole
	dw	id_dead_loader
	dw	get_to_transporter
	dw	id_robot_shell
	dw	get_to_shell
	dw	id_joey_park
	dw	get_to_jp2
	dw	id_panel
	dw	GT_panel2
	dw	id_junk1
	dw	GT_junk1
	dw	id_junk2
	dw	GT_junk2
	dw	0
	dw	s2_walk_on
	dw	1
	dw	er0_walk_on
	dw	-1


low_get_seq	dw	s200
	dw	315
	dw	267
	dw	0
	dw	315
	dw	267
	dw	1
	dw	315
	dw	267
	dw	2
	dw	315
	dw	267
	dw	3
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	3
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	0
	dw	0


new_grid	db	120 dup (0)



end32data

start32save_data



lamb	dw	l_wait_sync
	dw	st_sort+st_recreate+st_logic+st_grid_plot+st_collision+st_mouse
	dw	0
	dw	12
	dw	id_s12_floor
	dd	0
	dw	464
	dw	280
	dw	s131
	dw	4
	dw	std_on
	dw	std_off
	dw	mega_click
	dw	-16
	dw	-48
	dw	32
	dw	48
	dw	mega_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	c_base_mode
	dw	lamb_factory_start
	dw	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	std_player_stop
	dw	std_mini_bump
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96+32
	dw	sp_col_lamb
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	lamb_auto
	dw	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	lamb_up
	dd	lamb_down
	dd	lamb_left
	dd	lamb_right
	dd	lamb_st_up
	dd	lamb_st_down
	dd	lamb_st_left
	dd	lamb_st_right
	dd	lamb_st_talk
	dd	0
	dd	lamb_u_to_d
	dd	lamb_u_to_l
	dd	lamb_u_to_r
	dd	0
	dd	lamb_d_to_u
	dd	0
	dd	lamb_d_to_l
	dd	lamb_d_to_r
	dd	0
	dd	lamb_l_to_u
	dd	lamb_l_to_d
	dd	0
	dd	lamb_l_to_r
	dd	0
	dd	lamb_r_to_u
	dd	lamb_r_to_d
	dd	lamb_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0


lamb_auto	db	64 dup (0)



end32save_data

start32data



lamb_left	dw	4
	dw	20+s131
	dw	-4
	dw	0
	dw	4
	dw	21+s131
	dw	-4
	dw	0
	dw	4
	dw	22+s131
	dw	-4
	dw	0
	dw	4
	dw	23+s131
	dw	-4
	dw	0
	dw	4
	dw	24+s131
	dw	-4
	dw	0
	dw	4
	dw	25+s131
	dw	-4
	dw	0
	dw	4
	dw	26+s131
	dw	-4
	dw	0
	dw	4
	dw	27+s131
	dw	-4
	dw	0
	dw	4
	dw	28+s131
	dw	-4
	dw	0
	dw	4
	dw	29+s131
	dw	-4
	dw	0
	dw	0


lamb_right	dw	4
	dw	30+s131
	dw	4
	dw	0
	dw	4
	dw	31+s131
	dw	4
	dw	0
	dw	4
	dw	32+s131
	dw	4
	dw	0
	dw	4
	dw	33+s131
	dw	4
	dw	0
	dw	4
	dw	34+s131
	dw	4
	dw	0
	dw	4
	dw	35+s131
	dw	4
	dw	0
	dw	4
	dw	36+s131
	dw	4
	dw	0
	dw	4
	dw	37+s131
	dw	4
	dw	0
	dw	4
	dw	38+s131
	dw	4
	dw	0
	dw	4
	dw	39+s131
	dw	4
	dw	0
	dw	0


lamb_up	dw	2
	dw	0+s131
	dw	0
	dw	-2
	dw	2
	dw	1+s131
	dw	0
	dw	-2
	dw	2
	dw	2+s131
	dw	0
	dw	-2
	dw	2
	dw	3+s131
	dw	0
	dw	-2
	dw	2
	dw	4+s131
	dw	0
	dw	-2
	dw	2
	dw	5+s131
	dw	0
	dw	-2
	dw	2
	dw	6+s131
	dw	0
	dw	-2
	dw	2
	dw	7+s131
	dw	0
	dw	-2
	dw	2
	dw	8+s131
	dw	0
	dw	-2
	dw	2
	dw	9+s131
	dw	0
	dw	-2
	dw	0


lamb_down	dw	2
	dw	10+s131
	dw	0
	dw	2
	dw	2
	dw	11+s131
	dw	0
	dw	2
	dw	2
	dw	12+s131
	dw	0
	dw	2
	dw	2
	dw	13+s131
	dw	0
	dw	2
	dw	2
	dw	14+s131
	dw	0
	dw	2
	dw	2
	dw	15+s131
	dw	0
	dw	2
	dw	2
	dw	16+s131
	dw	0
	dw	2
	dw	2
	dw	17+s131
	dw	0
	dw	2
	dw	2
	dw	18+s131
	dw	0
	dw	2
	dw	2
	dw	19+s131
	dw	0
	dw	2
	dw	0


lamb_st_up	dw	s131
	dw	1
	dw	1
	dw	44
	dw	0


lamb_st_down	dw	s131
	dw	1
	dw	1
	dw	40
	dw	0


lamb_st_left	dw	s131
	dw	1
	dw	1
	dw	42
	dw	0


lamb_st_right	dw	s131
	dw	1
	dw	1
	dw	46
	dw	0


lamb_st_talk	dw	s132
	dw	1
	dw	1
	dw	0
	dw	0


lamb_r_to_u	dw	45+s131
	dw	0


lamb_r_to_d	dw	47+s131
	dw	0


lamb_r_to_l	dw	45+s131
	dw	44+s131
	dw	43+s131
	dw	0


lamb_u_to_d	dw	43+s131
	dw	42+s131
	dw	41+s131
	dw	0


lamb_u_to_l	dw	43+s131
	dw	0


lamb_u_to_r	dw	45+s131
	dw	0


lamb_d_to_u	dw	47+s131
	dw	46+s131
	dw	45+s131
	dw	0


lamb_d_to_l	dw	41+s131
	dw	0


lamb_d_to_r	dw	47+s131
	dw	0


lamb_l_to_u	dw	43+s131
	dw	0


lamb_l_to_d	dw	41+s131
	dw	0


lamb_l_to_r	dw	41+s131
	dw	40+s131
	dw	47+s131
	dw	0


rs_lamb_to_three	dw	c_status
	dw	st_logic
	dw	c_logic
	dw	l_script
	dw	-1


rs_lamb_start_2	dw	c_status
	dw	st_sort+st_recreate+st_logic+st_grid_plot+st_collision+st_mouse
	dw	c_place
	dw	id_s7_floor
	dw	c_screen
	dw	7
	dw	c_xcood
	dw	256
	dw	c_ycood
	dw	224
	dw	c_mouse_rel_x
	dw	-16
	dw	c_mouse_rel_y
	dw	-48
	dw	c_dir
	dw	down
	dw	-1


rs_lamb_start_3	dw	c_status
	dw	st_sort+st_recreate+st_logic+st_grid_plot+st_collision+st_mouse
	dw	c_place
	dw	id_s29_floor
	dw	c_screen
	dw	29
	dw	c_xcood
	dw	240
	dw	c_ycood
	dw	232
	dw	c_mouse_rel_x
	dw	-16
	dw	c_mouse_rel_y
	dw	-48
	dw	c_dir
	dw	down
	dw	-1


s29_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	170+disk_8
	dw	171+disk_8
	dw	0


s6_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	24+disk_2+$8000
	dw	25+disk_2+$8000
	dw	0


fast_list_sc3	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	211+disk_1
	dw	67+disk_1
	dw	68+disk_1
	dw	69+disk_1
	dw	222+disk_1
	dw	223+disk_1
	dw	213+disk_1
	dw	0


s9_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	56+disk_2
	dw	150+disk_2
	dw	102+disk_2
	dw	103+disk_2
	dw	104+disk_2
	dw	105+disk_2
	dw	100+disk_2
	dw	108+disk_2
	dw	109+disk_2
	dw	0


s10_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	43+disk_1
	dw	44+disk_1
	dw	0


s11_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	16+disk_1
	dw	0


fast_list_0	dw	64
	dw	65
	dw	66
	dw	12+$000
	dw	51
	dw	52
	dw	53
	dw	13+$8000
	dw	0


s0_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	13
	dw	55
	dw	22
	dw	158
	dw	14+$8000
	dw	15+$8000
	dw	71+$8000
	dw	72+$8000
	dw	0


s7_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	134+disk_2
	dw	146+disk_2
	dw	151+disk_2
	dw	149+disk_2
	dw	0


s28_fast_list	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	0


fast_list_sc90	dw	it_blue_foster+disk_4
	dw	it_logoff+$8000+disk_4
	dw	it_window+$8000+disk_4
	dw	it_info_button+disk_4
	dw	it_link_arrows+disk_4
	dw	it_link_objects+disk_4
	dw	it_crouch_right+disk_4
	dw	it_eyeball+disk_4
	dw	it_get_eye+disk_4+$8000
	dw	it_blind_eye+disk_4
	dw	it_see_eye+disk_4
	dw	it_eye90_zap+disk_4+$8000
	dw	it_sc90_layer_0+disk_4
	dw	it_sc90_layer_1+disk_4
	dw	it_sc90_grid_1+disk_4
	dw	0



end32data

start32save_data



monitor	dw	l_script
	dw	st_sort+st_recreate+st_logic+st_mouse
	dw	0
	dw	18
	dw	id_s18_floor
	dd	0
	dw	250
	dw	231
	dw	s75
	dw	4
	dw	std_on
	dw	std_off
	dw	mega_click
	dw	260-250
	dw	244-231
	dw	280-260
	dw	276-244
	dw	sat_gordon_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	monitor_sleep
	dw	0
	dd	0
	dd	0
	dd	0
	dw	down
	dw	std_mega_stop
	dw	std_mini_bump
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96
	dw	sp_col_monitor
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	monitor_auto
	dw	0
	dw	3
	dw	8
	dw	16
	dw	24
	dd	monitor_up
	dd	monitor_down
	dd	monitor_left
	dd	monitor_right
	dd	monitor_st_up
	dd	monitor_st_down
	dd	monitor_st_left
	dd	monitor_st_right
	dd	monitor_st_talk
	dd	0
	dd	monitor_u_to_d
	dd	monitor_u_to_l
	dd	monitor_u_to_r
	dd	0
	dd	monitor_d_to_u
	dd	0
	dd	monitor_d_to_l
	dd	monitor_d_to_r
	dd	0
	dd	monitor_l_to_u
	dd	monitor_l_to_d
	dd	0
	dd	monitor_l_to_r
	dd	0
	dd	monitor_r_to_u
	dd	monitor_r_to_d
	dd	monitor_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0


monitor_auto	db	64 dup (0)



end32save_data

start32data



monitor_left	dw	4
	dw	16+s74
	dw	-4
	dw	0
	dw	4
	dw	17+s74
	dw	-4
	dw	0
	dw	4
	dw	18+s74
	dw	-4
	dw	0
	dw	4
	dw	19+s74
	dw	-4
	dw	0
	dw	4
	dw	20+s74
	dw	-4
	dw	0
	dw	4
	dw	21+s74
	dw	-4
	dw	0
	dw	4
	dw	22+s74
	dw	-4
	dw	0
	dw	4
	dw	23+s74
	dw	-4
	dw	0
	dw	0


monitor_right	dw	4
	dw	24+s74
	dw	4
	dw	0
	dw	4
	dw	25+s74
	dw	4
	dw	0
	dw	4
	dw	26+s74
	dw	4
	dw	0
	dw	4
	dw	27+s74
	dw	4
	dw	0
	dw	4
	dw	28+s74
	dw	4
	dw	0
	dw	4
	dw	29+s74
	dw	4
	dw	0
	dw	4
	dw	30+s74
	dw	4
	dw	0
	dw	4
	dw	31+s74
	dw	4
	dw	0
	dw	0


monitor_up	dw	2
	dw	0+s74
	dw	0
	dw	-2
	dw	2
	dw	1+s74
	dw	0
	dw	-2
	dw	2
	dw	2+s74
	dw	0
	dw	-2
	dw	2
	dw	3+s74
	dw	0
	dw	-2
	dw	2
	dw	4+s74
	dw	0
	dw	-2
	dw	2
	dw	5+s74
	dw	0
	dw	-2
	dw	2
	dw	6+s74
	dw	0
	dw	-2
	dw	2
	dw	7+s74
	dw	0
	dw	-2
	dw	0


monitor_down	dw	2
	dw	8+s74
	dw	0
	dw	2
	dw	2
	dw	9+s74
	dw	0
	dw	2
	dw	2
	dw	10+s74
	dw	0
	dw	2
	dw	2
	dw	11+s74
	dw	0
	dw	2
	dw	2
	dw	12+s74
	dw	0
	dw	2
	dw	2
	dw	13+s74
	dw	0
	dw	2
	dw	2
	dw	14+s74
	dw	0
	dw	2
	dw	2
	dw	15+s74
	dw	0
	dw	2
	dw	0


monitor_st_up	dw	s74
	dw	1
	dw	1
	dw	36
	dw	0


monitor_st_down	dw	s74
	dw	1
	dw	1
	dw	32
	dw	0


monitor_st_left	dw	s74
	dw	1
	dw	1
	dw	34
	dw	0


monitor_st_right	dw	s74
	dw	1
	dw	1
	dw	38
	dw	0


monitor_st_talk	dw	s134
	dw	1
	dw	1
	dw	0
	dw	0


monitor_r_to_u	dw	45-8+s74
	dw	0


monitor_r_to_d	dw	47-8+s74
	dw	0


monitor_r_to_l	dw	45-8+s74
	dw	44-8+s74
	dw	43-8+s74
	dw	0


monitor_u_to_d	dw	43-8+s74
	dw	42-8+s74
	dw	41-8+s74
	dw	0


monitor_u_to_l	dw	43-8+s74
	dw	0


monitor_u_to_r	dw	45-8+s74
	dw	0


monitor_d_to_u	dw	47-8+s74
	dw	46-8+s74
	dw	45-8+s74
	dw	0


monitor_d_to_l	dw	41-8+s74
	dw	0


monitor_d_to_r	dw	47-8+s74
	dw	0


monitor_l_to_u	dw	43-8+s74
	dw	0


monitor_l_to_d	dw	41-8+s74
	dw	0


monitor_l_to_r	dw	41-8+s74
	dw	40-8+s74
	dw	47-8+s74
	dw	0



end32data

start32save_data



anita	dw	l_script
	dw	st_sort+st_recreate+st_logic+st_mouse
	dw	0
	dw	12
	dw	0
	dd	0
	dw	$157
	dw	$b3
	dw	s27
	dw	54
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	4
	dw	4
	dw	24
	dw	48
	dw	anita_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	anita_work
	dw	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96
	dw	sp_col_anita
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0



end32save_data

start32data



save_restore_mouse	dw	23
	dw	24
	dw	25
	dw	26
	dw	27
	dw	28
	dw	29
	dw	30
	dw	31
	dw	32
	dw	20
	dw	0



end32data

start32save_data



whole_screen	dw	0
	dw	st_mouse
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	128
	dw	136
	dw	0
	dw	0
	dw	0
	dw	0
	dw	text_edit
	dw	0
	dw	0
	dw	320
	dw	192



end32save_data

start32data



swing_list	dw	85+disk_1
	dw	86+disk_1
	dw	87+disk_1
	dw	88+disk_1
	dw	0


but_0	dw	s140
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_1	dw	s141
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_2	dw	s142
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_3	dw	s143
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_4	dw	s144
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_5	dw	s145
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_6	dw	s146
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_7	dw	s147
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_8	dw	s148
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_9	dw	s149
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0


but_e	dw	s150
	dw	1
	dw	1
	dw	1
	dw	1
	dw	1
	dw	2
	dw	1
	dw	1
	dw	0
	dw	0



end32data

start32save_data



end32save_data
