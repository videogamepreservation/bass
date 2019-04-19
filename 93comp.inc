start32save_data



sc93_floor	dw	NULL
	dw	st_mouse
	dw	NULL
	dw	93
	dw	NULL
	dd	sc93_floor_table
	dw	153
	dw	256
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	advisor_188
	dw	0
	dw	0
	dw	269
	dw	52
	dw	floor_action



end32save_data

start32data



sc93_floor_table	dw	id_sc93_floor
	dw	return_ok
	dw	id_door_l93
	dw	get_to_door_l93
	dw	id_persona
	dw	get_to_persona
	dw	id_adjust_book
	dw	get_to_adjust_book
	dw	-1



end32data

start32save_data



door_l93	dw	l_script
	dw	st_mouse+st_logic+st_background
	dw	NULL
	dw	93
	dw	NULL
	dd	NULL
	dw	205
	dw	136
	dw	s133
	dw	1+t7
	dw	std_exit_left_on
	dw	std_off
	dw	advisor_188
	dw	-5
	dw	26
	dw	9
	dw	109
	dw	door_l93_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	door_l93_logic
	dw	0


door_l93f	dw	l_script
	dw	st_mouse+st_logic+st_sort
	dw	NULL
	dw	93
	dw	NULL
	dd	NULL
	dw	200
	dw	136
	dw	s134
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	-19
	dw	263-136
	dw	20
	dw	10
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	c_base_mode
	dw	door_l93f_logic
	dw	0


persona	dw	l_script
	dw	st_mouse+st_logic+st_sort+st_recreate
	dw	NULL
	dw	93
	dw	NULL
	dd	NULL
	dw	342
	dw	250
	dw	s51
	dw	24594
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	-1
	dw	-1
	dw	16
	dw	22
	dw	persona_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	persona_logic
	dw	0


adjust_book	dw	l_script
	dw	st_mouse+st_logic+st_sort+st_recreate
	dw	NULL
	dw	93
	dw	NULL
	dd	NULL
	dw	370
	dw	284
	dw	s63
	dw	24596
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	15
	dw	15
	dw	adjust_book_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	adjust_book_logic
	dw	0



end32save_data

start32data



rs_foster_93_92	dw	c_screen
	dw	92
	dw	c_place
	dw	id_slab9
	dw	c_xcood
	dw	336
	dw	c_ycood
	dw	248
	dw	c_dir
	dw	down
	dw	-1


door_l93_anim	dw	s133
	dw	205
	dw	136
	dw	0
	dw	205
	dw	136
	dw	1
	dw	205
	dw	136
	dw	2
	dw	205
	dw	136
	dw	3
	dw	205
	dw	136
	dw	4
	dw	205
	dw	136
	dw	5
	dw	205
	dw	136
	dw	6
	dw	205
	dw	136
	dw	7
	dw	205
	dw	136
	dw	8
	dw	205
	dw	136
	dw	9
	dw	205
	dw	136
	dw	10
	dw	205
	dw	136
	dw	11
	dw	205
	dw	136
	dw	12
	dw	205
	dw	136
	dw	13
	dw	205
	dw	136
	dw	14
	dw	205
	dw	136
	dw	15
	dw	205
	dw	136
	dw	16
	dw	205
	dw	136
	dw	17
	dw	205
	dw	136
	dw	18
	dw	205
	dw	136
	dw	19
	dw	205
	dw	136
	dw	20
	dw	205
	dw	136
	dw	21
	dw	205
	dw	136
	dw	22
	dw	0


door_l93f_anim	dw	s134
	dw	200
	dw	136
	dw	0
	dw	200
	dw	136
	dw	1
	dw	200
	dw	136
	dw	2
	dw	200
	dw	136
	dw	3
	dw	200
	dw	136
	dw	4
	dw	200
	dw	136
	dw	5
	dw	200
	dw	136
	dw	6
	dw	200
	dw	136
	dw	7
	dw	200
	dw	136
	dw	8
	dw	200
	dw	136
	dw	9
	dw	200
	dw	136
	dw	10
	dw	200
	dw	136
	dw	11
	dw	200
	dw	136
	dw	12
	dw	200
	dw	136
	dw	13
	dw	200
	dw	136
	dw	14
	dw	200
	dw	136
	dw	15
	dw	200
	dw	136
	dw	16
	dw	200
	dw	136
	dw	17
	dw	200
	dw	136
	dw	18
	dw	200
	dw	136
	dw	19
	dw	200
	dw	136
	dw	20
	dw	200
	dw	136
	dw	21
	dw	200
	dw	136
	dw	22
	dw	0


get_persona	dw	s51
	dw	342
	dw	250
	dw	0
	dw	342
	dw	250
	dw	1
	dw	342
	dw	250
	dw	2
	dw	342
	dw	250
	dw	3
	dw	342
	dw	250
	dw	4
	dw	342
	dw	250
	dw	5
	dw	0


get_adjust	dw	s63
	dw	370
	dw	284
	dw	0
	dw	370
	dw	284
	dw	1
	dw	370
	dw	284
	dw	2
	dw	370
	dw	284
	dw	3
	dw	370
	dw	284
	dw	4
	dw	0


pal93	dw	0
	dw	3584
	dw	8960
	dw	1044
	dw	7211
	dw	12812
	dw	5413
	dw	11066
	dw	15390
	dw	45
	dw	10257
	dw	3840
	dw	33
	dw	7436
	dw	2560
	dw	1550
	dw	5888
	dw	10
	dw	3616
	dw	9472
	dw	20
	dw	7211
	dw	15360
	dw	39
	dw	25
	dw	8
	dw	0
	dw	15928
	dw	11071
	dw	13873
	dw	10015
	dw	6188
	dw	8990
	dw	5135
	dw	2587
	dw	5903
	dw	8458
	dw	783
	dw	1303
	dw	4096
	dw	12032
	dw	0
	dw	30
	dw	5632
	dw	0
	dw	6183
	dw	5658
	dw	1792
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	0
	dw	14336
	dw	13364
	dw	11569
	dw	9261
	dw	8481
	dw	6687
	dw	6681
	dw	4626
	dw	2578
	dw	1803
	dw	770
	dw	519
	dw	13571
	dw	9517
	dw	9778
	dw	11805
	dw	5151
	dw	5926
	dw	8205
	dw	1808
	dw	2586
	dw	11267
	dw	2056
	dw	8210
	dw	7441
	dw	6954
	dw	9494
	dw	4119
	dw	3866
	dw	4864
	dw	13316
	dw	13364
	dw	11563
	dw	8751
	dw	9506
	dw	10024
	dw	8242
	dw	10527
	dw	6174
	dw	5927
	dw	7698
	dw	3600
	dw	2325
	dw	2308
	dw	11573
	dw	12837
	dw	7462
	dw	7982
	dw	9748
	dw	3351
	dw	4128
	dw	6663
	dw	778
	dw	9533
	dw	13100
	dw	9244
	dw	5162
	dw	8476
	dw	5390
	dw	2072
	dw	3855
	dw	2308
	dw	2865
	dw	9995
	dw	1285
	dw	285
	dw	4865
	dw	0
	dw	11573
	dw	12837
	dw	7462
	dw	0
	dw	16128
	dw	0
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	16191
	dw	13887
	dw	13878
	dw	12077
	dw	8241
	dw	10527
	dw	5917
	dw	5925
	dw	7698
	dw	2865
	dw	9995
	dw	1285
	dw	285
	dw	16129
	dw	16191


fast_list_sc93	dw	it_blue_foster+disk_4
	dw	it_logoff+$8000+disk_4
	dw	it_window+$8000+disk_4
	dw	it_info_button+disk_4
	dw	it_link_arrows+disk_4
	dw	it_link_objects+disk_4
	dw	it_crouch_right+disk_4
	dw	it_sc93_layer_0+disk_4
	dw	it_sc93_layer_1+disk_4
	dw	it_sc93_grid_1+disk_4
	dw	0


chip_list_sc93	dw	it_persona+disk_4
	dw	it_adjust_book+disk_4
	dw	it_door_l93+disk_4
	dw	it_door_l93f+disk_4
	dw	0


sc93_logic	dw	id_blue_foster
	dw	id_persona
	dw	id_adjust_book
	dw	id_door_l93
	dw	id_door_l93f
	dw	id_eyeball_90
	dw	$ffff
	dw	id_linc_menu_logic


sc93_mouse	dw	id_persona
	dw	id_adjust_book
	dw	id_door_l93
	dw	id_door_l93f
	dw	id_sc93_floor
	dw	$ffff
	dw	id_linc_menu_mouse



end32data

start32save_data



end32save_data
