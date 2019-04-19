start32data



chip_list_sc3	dw	173
	dw	111
	dw	227
	dw	202+disk_1
	dw	203+disk_1
	dw	204+disk_1
	dw	205+disk_1
	dw	206+disk_1
	dw	207+disk_1
	dw	208+disk_1
	dw	212+disk_1
	dw	216+disk_1+$8000
	dw	215+disk_1
	dw	209+$8000+disk_1
	dw	210+$8000+disk_1
	dw	217+disk_1
	dw	214+disk_1
	dw	225+disk_1
	dw	218+disk_1+$8000
	dw	169+disk_1+$8000
	dw	0


s3_logic	dw	id_steve_spy
	dw	id_foster
	dw	id_low_lift
	dw	4350
	dw	4351
	dw	id_convey
	dw	id_furnace
	dw	id_low_barrel
	dw	id_joey_fly
	dw	id_joey
	dw	id_lights1
	dw	id_furnace_door
	dw	id_eye_ball
	dw	id_shades
	dw	id_eye_bolt
	dw	id_smoulder
	dw	105
	dw	$ffff
	dw	id_menu_logic


s3_mouse	dw	id_furnace_door
	dw	id_steve_spy
	dw	id_joey
	dw	id_slot
	dw	id_smoulder
	dw	id_eye_ball
	dw	id_furnace
	dw	id_s3_floor
	dw	$ffff
	dw	id_text_mouse


s3_floor	dw	0
	dw	st_mouse
	dw	0
	dw	3
	dw	NULL
	dd	r3_floor_table
	dw	176
	dw	240
	dw	0
	dw	0
	dw	0
	dw	0
	dw	advisor_188
	dw	0
	dw	0
	dw	256
	dw	79
	dw	floor_action


r3_floor_table	dw	id_s3_floor
	dw	return_ok
	dw	id_furnace_door
	dw	get_to_furnace_door
	dw	id_slot
	dw	get_to_slot
	dw	id_smoulder
	dw	get_to_body
	dw	id_eye_ball
	dw	get_to_eye
	dw	id_furnace
	dw	get_to_furnace
	dw	id_joey_park
	dw	get_to_jp2
	dw	-1


rs_low_lift	dw	c_xcood
	dw	250
	dw	c_ycood
	dw	268
	dw	c_frame
	dw	s202
	dw	c_base_sub+2
	dw	0
	dw	c_logic
	dw	l_script
	dw	c_status
	dw	st_sort+st_logic+st_recreate+st_no_vmask
	dw	-1


rs_low_lift2	dw	c_xcood
	dw	292
	dw	c_ycood
	dw	210
	dw	c_frame
	dw	s203
	dw	c_base_sub+2
	dw	0
	dw	c_logic
	dw	l_script
	dw	c_status
	dw	st_sort+st_logic+st_recreate+st_no_vmask
	dw	-1


rs_low_lift3	dw	c_xcood
	dw	275
	dw	c_ycood
	dw	286
	dw	c_frame
	dw	s204
	dw	c_base_sub+2
	dw	0
	dw	c_logic
	dw	l_script
	dw	c_status
	dw	st_sort+st_logic+st_recreate+st_no_vmask
	dw	-1


rs_low_barrel	dw	c_xcood
	dw	10
	dw	c_ycood
	dw	10
	dw	c_frame
	dw	s202
	dw	c_status
	dw	st_logic+st_recreate+st_no_vmask
	dw	c_logic
	dw	l_script
	dw	c_base_sub+2
	dw	0
	dw	-1



end32data

start32save_data



steve_watch	dw	l_script
	dw	st_logic
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	244
	dw	196
	dw	NULL
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	1
	dw	1
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	steve_spy_logic
	dw	0


low_barrel	dw	l_script
	dw	st_logic+st_recreate+st_no_vmask
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	10
	dw	10
	dw	s202
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
	dw	low_barrel_logic
	dw	0


convey	dw	l_script
	dw	0
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	0
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
	dw	convey_logic
	dw	0


joey_fly	dw	l_script
	dw	0
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s209
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
	dw	fly_logic
	dw	0


furnace	dw	l_script
	dw	st_sort+st_logic+st_mouse+st_recreate
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	226
	dw	240
	dw	s211
	dw	4221
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	10
	dw	40
	dw	furnace_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	furnace_logic
	dw	0


lights1	dw	l_script
	dw	st_background+st_logic
	dw	0
	dw	3
	dw	0
	dd	0
	dw	10
	dw	10
	dw	s212
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
	dw	lights1_logic
	dw	0


eye_ball	dw	l_script
	dw	st_foreground+st_recreate+st_logic+st_no_vmask+st_mouse
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	201
	dw	165
	dw	s213
	dw	4218
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	25
	dw	70
	dw	eye_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	eye_ball_logic
	dw	NULL
	dd	NULL
	dd	NULL
	dd	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	0


furnace_door	dw	l_script
	dw	st_background+st_recreate+st_logic+st_mouse
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	$18e
	dw	$de
	dw	s215
	dw	181
	dw	furnace_exit_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	16
	dw	60
	dw	furnace_d_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	furnace_door_logic
	dw	0


slot	dw	0
	dw	st_mouse
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	385
	dw	233
	dw	0
	dw	4219
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	5
	dw	15
	dw	slot_action


sh	dd 0 dup (0)

shades	dw	l_script
	dw	st_grid_plot+st_logic
	dw	0
	dw	3
	dw	id_s3_floor
	dd	0
	dw	424
	dw	280
	dw	s217
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	mega_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	shades_logic
	dw	0
	dd	0
	dd	0
	dd	0
	dw	0
	dw	std_mega_stop
	dw	std_mini_bump
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	96
	dw	sp_col_shades
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	shades_auto
	dw	0
	dw	0
	dw	0
	dw	8
	dw	8
	dd	shades_up
	dd	shades_down
	dd	shades_left
	dd	shades_right
	dd	shades_st_up
	dd	shades_st_down
	dd	shades_st_left
	dd	shades_st_right
	dd	shades_st_talk
	dd	0
	dd	shades_u_to_d
	dd	shades_u_to_l
	dd	shades_u_to_r
	dd	0
	dd	shades_d_to_u
	dd	0
	dd	shades_d_to_l
	dd	shades_d_to_r
	dd	0
	dd	shades_l_to_u
	dd	shades_l_to_d
	dd	0
	dd	shades_l_to_r
	dd	0
	dd	shades_r_to_u
	dd	shades_r_to_d
	dd	shades_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0


shades_auto	db	64 dup (0)



end32save_data

start32data



shades_left	dw	4
	dw	16+s217
	dw	-4
	dw	0
	dw	4
	dw	17+s217
	dw	-4
	dw	0
	dw	4
	dw	18+s217
	dw	-4
	dw	0
	dw	4
	dw	19+s217
	dw	-4
	dw	0
	dw	4
	dw	20+s217
	dw	-4
	dw	0
	dw	4
	dw	21+s217
	dw	-4
	dw	0
	dw	4
	dw	22+s217
	dw	-4
	dw	0
	dw	4
	dw	23+s217
	dw	-4
	dw	0
	dw	0


shades_right	dw	4
	dw	24+s217
	dw	4
	dw	0
	dw	4
	dw	25+s217
	dw	4
	dw	0
	dw	4
	dw	26+s217
	dw	4
	dw	0
	dw	4
	dw	27+s217
	dw	4
	dw	0
	dw	4
	dw	28+s217
	dw	4
	dw	0
	dw	4
	dw	29+s217
	dw	4
	dw	0
	dw	4
	dw	30+s217
	dw	4
	dw	0
	dw	4
	dw	31+s217
	dw	4
	dw	0
	dw	0


shades_up	dw	2
	dw	0+s217
	dw	0
	dw	-2
	dw	2
	dw	1+s217
	dw	0
	dw	-2
	dw	2
	dw	2+s217
	dw	0
	dw	-2
	dw	2
	dw	3+s217
	dw	0
	dw	-2
	dw	2
	dw	4+s217
	dw	0
	dw	-2
	dw	2
	dw	5+s217
	dw	0
	dw	-2
	dw	2
	dw	6+s217
	dw	0
	dw	-2
	dw	2
	dw	7+s217
	dw	0
	dw	-2
	dw	0


shades_down	dw	2
	dw	8+s217
	dw	0
	dw	2
	dw	2
	dw	9+s217
	dw	0
	dw	2
	dw	2
	dw	10+s217
	dw	0
	dw	2
	dw	2
	dw	11+s217
	dw	0
	dw	2
	dw	2
	dw	12+s217
	dw	0
	dw	2
	dw	2
	dw	13+s217
	dw	0
	dw	2
	dw	2
	dw	14+s217
	dw	0
	dw	2
	dw	2
	dw	15+s217
	dw	0
	dw	2
	dw	0


shades_st_up	dw	s217
	dw	1
	dw	1
	dw	36
	dw	0


shades_st_down	dw	s217
	dw	1
	dw	1
	dw	32
	dw	0


shades_st_left	dw	s217
	dw	1
	dw	1
	dw	34
	dw	0


shades_st_right	dw	s217
	dw	1
	dw	1
	dw	38
	dw	0


shades_st_talk	dw	s43
	dw	1
	dw	1
	dw	0
	dw	0


shades_r_to_u	dw	45-8+s217
	dw	0


shades_r_to_d	dw	47-8+s217
	dw	0


shades_r_to_l	dw	45-8+s217
	dw	44-8+s217
	dw	43-8+s217
	dw	0


shades_u_to_d	dw	43-8+s217
	dw	42-8+s217
	dw	41-8+s217
	dw	0


shades_u_to_l	dw	43-8+s217
	dw	0


shades_u_to_r	dw	45-8+s217
	dw	0


shades_d_to_u	dw	47-8+s217
	dw	46-8+s217
	dw	45-8+s217
	dw	0


shades_d_to_l	dw	41-8+s217
	dw	0


shades_d_to_r	dw	47-8+s217
	dw	0


shades_l_to_u	dw	43-8+s217
	dw	0


shades_l_to_d	dw	41-8+s217
	dw	0


shades_l_to_r	dw	41-8+s217
	dw	40-8+s217
	dw	47-8+s217
	dw	0



end32data

start32save_data



eye_bolt	dw	l_script
	dw	st_recreate+st_logic+st_no_vmask
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	null
	dw	null
	dw	0
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
	dw	eye_bolt_logic
	dw	0


smoulder	dw	l_script
	dw	st_recreate+st_logic
	dw	0
	dw	3
	dw	0
	dd	0
	dw	373+24
	dw	289
	dw	0
	dw	4220
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	-24
	dw	-4
	dw	60
	dw	10
	dw	smoulder_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	smoulder_logic
	dw	0
	dd	NULL
	dd	NULL
	dd	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	NULL
	dw	NULL
	dd	NULL
	dw	NULL
	dw	7



end32save_data

start32data



smoulder_seq	dw	s225
	dw	373
	dw	269
	dw	0
	dw	373
	dw	269
	dw	1
	dw	373
	dw	269
	dw	1
	dw	373
	dw	269
	dw	2
	dw	373
	dw	269
	dw	2
	dw	373
	dw	269
	dw	3
	dw	373
	dw	269
	dw	3
	dw	373
	dw	269
	dw	4
	dw	373
	dw	269
	dw	4
	dw	373
	dw	269
	dw	0
	dw	0


joey_list_s3	dw	296
	dw	360
	dw	248
	dw	321
	dw	1
	dw	0


rs_start_joey_fly	dw	c_status
	dw	st_sort+st_logic+st_recreate
	dw	-1


rs_joey_to_furnace	dw	c_xcood
	dw	344
	dw	c_ycood
	dw	264
	dw	c_status
	dw	st_sort+st_recreate+st_logic+st_grid_plot+st_collision+st_mouse
	dw	c_place
	dw	id_s3_floor
	dw	c_screen
	dw	3
	dw	c_mode
	dw	0
	dw	c_base_sub
	dw	joey_logic
	dw	c_base_sub+2
	dw	0
	dw	c_dir
	dw	right
	dw	c_frame
	dw	s173+12
	dw	-1



end32data

start32save_data



low_lift	dw	l_script
	dw	st_sort+st_logic+st_recreate+st_no_vmask
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	250
	dw	268
	dw	s202
	dw	19+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	57
	dw	48
	dw	21
	dw	top_lift_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	low_lift_logic
	dw	0


low_lift_2	dw	l_script
	dw	st_sort+st_logic+st_recreate+st_no_vmask
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	292
	dw	210
	dw	s203
	dw	19+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	57
	dw	48
	dw	21
	dw	top_lift_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	low_lift2_logic
	dw	0


low_lift_3	dw	l_script
	dw	st_sort+st_logic+st_recreate+st_no_vmask
	dw	0
	dw	3
	dw	NULL
	dd	NULL
	dw	275
	dw	286
	dw	s204
	dw	19+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	57
	dw	48
	dw	21
	dw	top_lift_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	low_lift3_logic
	dw	0



end32save_data

start32data



liftc1_up	dw	s202
	dw	250
	dw	268
	dw	0
	dw	250
	dw	263
	dw	1
	dw	250
	dw	259
	dw	2
	dw	250
	dw	254
	dw	2
	dw	250
	dw	250
	dw	3
	dw	250
	dw	245
	dw	3
	dw	250
	dw	241
	dw	4
	dw	250
	dw	236
	dw	4
	dw	250
	dw	232
	dw	5
	dw	250
	dw	227
	dw	5
	dw	250
	dw	223
	dw	6
	dw	250
	dw	218
	dw	6
	dw	250
	dw	214
	dw	7
	dw	250
	dw	209
	dw	7
	dw	250
	dw	205
	dw	8
	dw	250
	dw	200
	dw	8
	dw	250
	dw	196
	dw	9
	dw	250
	dw	191
	dw	9
	dw	250
	dw	187
	dw	10
	dw	250
	dw	182
	dw	10
	dw	250
	dw	178
	dw	11
	dw	250
	dw	173
	dw	11
	dw	250
	dw	169
	dw	12
	dw	250
	dw	164
	dw	12
	dw	250
	dw	160
	dw	13
	dw	250
	dw	155
	dw	13
	dw	250
	dw	151
	dw	14
	dw	250
	dw	146
	dw	14
	dw	250
	dw	141
	dw	15
	dw	0


liftc2_up	dw	s203
	dw	292
	dw	210
	dw	0
	dw	292
	dw	205
	dw	1
	dw	292
	dw	201
	dw	2
	dw	292
	dw	196
	dw	2
	dw	292
	dw	192
	dw	3
	dw	292
	dw	187
	dw	3
	dw	292
	dw	183
	dw	4
	dw	292
	dw	178
	dw	4
	dw	292
	dw	174
	dw	5
	dw	292
	dw	169
	dw	5
	dw	292
	dw	165
	dw	6
	dw	292
	dw	160
	dw	6
	dw	292
	dw	156
	dw	7
	dw	292
	dw	151
	dw	7
	dw	292
	dw	146
	dw	8
	dw	292
	dw	141
	dw	8
	dw	292
	dw	141
	dw	9
	dw	292
	dw	141
	dw	10
	dw	292
	dw	141
	dw	11
	dw	292
	dw	141
	dw	12
	dw	292
	dw	141
	dw	13
	dw	292
	dw	141
	dw	14
	dw	292
	dw	141
	dw	15
	dw	292
	dw	141
	dw	16
	dw	292
	dw	141
	dw	17
	dw	292
	dw	141
	dw	18
	dw	292
	dw	141
	dw	19
	dw	292
	dw	141
	dw	20
	dw	292
	dw	141
	dw	21
	dw	0


liftc3_up	dw	s204
	dw	275
	dw	286
	dw	0
	dw	275
	dw	281
	dw	1
	dw	275
	dw	276
	dw	2
	dw	275
	dw	271
	dw	3
	dw	275
	dw	266
	dw	4
	dw	275
	dw	261
	dw	4
	dw	275
	dw	256
	dw	5
	dw	275
	dw	251
	dw	5
	dw	275
	dw	246
	dw	6
	dw	275
	dw	241
	dw	6
	dw	275
	dw	236
	dw	7
	dw	275
	dw	231
	dw	7
	dw	275
	dw	226
	dw	8
	dw	275
	dw	221
	dw	8
	dw	275
	dw	216
	dw	9
	dw	275
	dw	211
	dw	9
	dw	275
	dw	206
	dw	10
	dw	275
	dw	201
	dw	10
	dw	275
	dw	196
	dw	11
	dw	275
	dw	191
	dw	11
	dw	275
	dw	186
	dw	12
	dw	275
	dw	181
	dw	12
	dw	275
	dw	176
	dw	13
	dw	275
	dw	171
	dw	13
	dw	275
	dw	166
	dw	14
	dw	275
	dw	161
	dw	14
	dw	275
	dw	156
	dw	15
	dw	275
	dw	151
	dw	15
	dw	275
	dw	146
	dw	16
	dw	275
	dw	141
	dw	16
	dw	280
	dw	141
	dw	17
	dw	285
	dw	141
	dw	18
	dw	289
	dw	141
	dw	19
	dw	294
	dw	141
	dw	20
	dw	298
	dw	141
	dw	21
	dw	298
	dw	141
	dw	22
	dw	0


liftc1_down	dw	s202
	dw	250
	dw	141
	dw	15
	dw	250
	dw	146
	dw	14
	dw	250
	dw	151
	dw	14
	dw	250
	dw	155
	dw	13
	dw	250
	dw	160
	dw	13
	dw	250
	dw	164
	dw	12
	dw	250
	dw	169
	dw	12
	dw	250
	dw	173
	dw	11
	dw	250
	dw	178
	dw	11
	dw	250
	dw	182
	dw	10
	dw	250
	dw	187
	dw	10
	dw	250
	dw	191
	dw	9
	dw	250
	dw	196
	dw	9
	dw	250
	dw	200
	dw	8
	dw	250
	dw	205
	dw	8
	dw	250
	dw	209
	dw	7
	dw	250
	dw	214
	dw	7
	dw	250
	dw	218
	dw	6
	dw	250
	dw	223
	dw	6
	dw	250
	dw	227
	dw	5
	dw	250
	dw	232
	dw	5
	dw	250
	dw	236
	dw	4
	dw	250
	dw	241
	dw	4
	dw	250
	dw	245
	dw	3
	dw	250
	dw	250
	dw	3
	dw	250
	dw	254
	dw	2
	dw	250
	dw	259
	dw	2
	dw	250
	dw	263
	dw	1
	dw	250
	dw	268
	dw	0
	dw	0
	dw	0


liftc2_down	dw	s203
	dw	292
	dw	141
	dw	21
	dw	292
	dw	141
	dw	20
	dw	292
	dw	141
	dw	19
	dw	292
	dw	141
	dw	18
	dw	292
	dw	141
	dw	17
	dw	292
	dw	141
	dw	16
	dw	292
	dw	141
	dw	15
	dw	292
	dw	141
	dw	14
	dw	292
	dw	141
	dw	13
	dw	292
	dw	141
	dw	12
	dw	292
	dw	141
	dw	11
	dw	292
	dw	141
	dw	10
	dw	292
	dw	141
	dw	9
	dw	292
	dw	141
	dw	8
	dw	292
	dw	146
	dw	8
	dw	292
	dw	151
	dw	7
	dw	292
	dw	156
	dw	7
	dw	292
	dw	160
	dw	6
	dw	292
	dw	165
	dw	6
	dw	292
	dw	169
	dw	5
	dw	292
	dw	174
	dw	5
	dw	292
	dw	178
	dw	4
	dw	292
	dw	183
	dw	4
	dw	292
	dw	187
	dw	3
	dw	292
	dw	192
	dw	3
	dw	292
	dw	196
	dw	2
	dw	292
	dw	201
	dw	2
	dw	292
	dw	205
	dw	1
	dw	292
	dw	210
	dw	0
	dw	0
	dw	0


liftc3_down	dw	s204
	dw	298
	dw	141
	dw	22
	dw	298
	dw	141
	dw	21
	dw	294
	dw	141
	dw	20
	dw	289
	dw	141
	dw	19
	dw	285
	dw	141
	dw	18
	dw	280
	dw	141
	dw	17
	dw	275
	dw	141
	dw	16
	dw	275
	dw	146
	dw	16
	dw	275
	dw	151
	dw	15
	dw	275
	dw	156
	dw	15
	dw	275
	dw	161
	dw	14
	dw	275
	dw	166
	dw	14
	dw	275
	dw	171
	dw	13
	dw	275
	dw	176
	dw	13
	dw	275
	dw	181
	dw	12
	dw	275
	dw	186
	dw	12
	dw	275
	dw	191
	dw	11
	dw	275
	dw	196
	dw	11
	dw	275
	dw	201
	dw	10
	dw	275
	dw	206
	dw	10
	dw	275
	dw	211
	dw	9
	dw	275
	dw	216
	dw	9
	dw	275
	dw	221
	dw	8
	dw	275
	dw	226
	dw	8
	dw	275
	dw	231
	dw	7
	dw	275
	dw	236
	dw	7
	dw	275
	dw	241
	dw	6
	dw	275
	dw	246
	dw	6
	dw	275
	dw	251
	dw	5
	dw	275
	dw	256
	dw	5
	dw	275
	dw	261
	dw	4
	dw	275
	dw	266
	dw	4
	dw	275
	dw	271
	dw	3
	dw	275
	dw	276
	dw	2
	dw	275
	dw	281
	dw	1
	dw	275
	dw	286
	dw	0
	dw	0
	dw	0


search_seq	dw	s169
	dw	289
	dw	231
	dw	0
	dw	289
	dw	231
	dw	1
	dw	289
	dw	231
	dw	2
	dw	289
	dw	231
	dw	3
	dw	289
	dw	231
	dw	4
	dw	289
	dw	231
	dw	5
	dw	289
	dw	231
	dw	4
	dw	289
	dw	231
	dw	6
	dw	289
	dw	231
	dw	7
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	8
	dw	289
	dw	231
	dw	7
	dw	289
	dw	231
	dw	6
	dw	289
	dw	231
	dw	4
	dw	289
	dw	231
	dw	1
	dw	289
	dw	231
	dw	0
	dw	0



end32data

start32save_data



end32save_data
