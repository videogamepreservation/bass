start32data



fast_list_sc4	dw	12
	dw	51
	dw	52
	dw	53
	dw	54
	dw	135
	dw	153
	dw	131
	dw	132
	dw	136
	dw	137
	dw	138
	dw	0


chip_list_sc4	dw	56
	dw	57
	dw	58
	dw	59
	dw	60
	dw	61
	dw	62
	dw	63
	dw	143
	dw	144
	dw	145
	dw	146
	dw	151
	dw	152
	dw	173
	dw	111
	dw	141
	dw	150
	dw	142
	dw	117
	dw	134
	dw	0



end32data

start32save_data



sc4_floor	dw	0
	dw	st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	r4_floor_table
	dw	184
	dw	232
	dw	0
	dw	0
	dw	0
	dw	0
	dw	advisor_188
	dw	0
	dw	0
	dw	183
	dw	64
	dw	floor_action



end32save_data

start32data



r4_floor_table	dw	id_s4_floor
	dw	return_ok
	dw	id_s4_l_exit
	dw	get_to_el4
	dw	id_cupboard
	dw	get_to_cupboard
	dw	id_sarnie
	dw	get_to_shelves
	dw	id_spanner
	dw	get_to_shelves
	dw	id_knob
	dw	get_to_knob
	dw	id_chuck
	dw	get_to_chuck
	dw	id_monitors
	dw	get_to_screens
	dw	id_buttons
	dw	get_to_buttons
	dw	4106
	dw	get_to_talk41
	dw	4107
	dw	get_to_talk42
	dw	4136
	dw	s4_walk_on
	dw	id_postcard
	dw	get_to_postcard
	dw	id_notice4
	dw	get_to_postcard
	dw	id_tv_screens
	dw	get_to_monitor
	dw	id_joey_park
	dw	get_to_jp2
	dw	id_lazer
	dw	GT_lazer
	dw	-1



end32data

start32save_data



sc4_left_exit	dw	0
	dw	st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	NULL
	dw	188
	dw	193
	dw	0
	dw	1+t7
	dw	std_exit_left_on
	dw	std_off
	dw	advisor_188
	dw	0
	dw	0
	dw	13
	dw	61
	dw	el4_action


l_talk_s4	dd 0 dup (0)

r_talk_s4	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	s4_talk_table



end32save_data

start32data



s4_talk_table	dw	4106
	dw	return_ok
	dw	4107
	dw	return_ok
	dw	id_s4_floor
	dw	std_adjoin_floor
	dw	id_s4_l_exit
	dw	get_to_el4
	dw	id_cupboard
	dw	get_to_cupboard
	dw	id_sarnie
	dw	get_to_shelves
	dw	id_spanner
	dw	get_to_shelves
	dw	id_knob
	dw	get_to_knob
	dw	id_chuck
	dw	get_to_chuck
	dw	id_monitors
	dw	get_to_screens
	dw	id_buttons
	dw	get_to_buttons
	dw	id_postcard
	dw	get_to_postcard
	dw	id_notice4
	dw	get_to_postcard
	dw	id_tv_screens
	dw	get_to_monitor
	dw	id_lazer
	dw	GT_lazer
	dw	-1



end32data

start32save_data



tv_screens_s4	dw	l_script
	dw	st_background+st_logic+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	NULL
	dw	0
	dw	0
	dw	s56
	dw	4200
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	18
	dw	NULL
	dw	10
	dw	7
	dw	tv_2_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	tv_logic
	dw	0


knob_s4	dw	l_script
	dw	st_background+st_logic+st_recreate+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	302
	dw	187
	dw	s58
	dw	13+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	5
	dw	14
	dw	knob_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	knob_logic
	dw	0


chuck_s4	dw	l_script
	dw	st_background+st_logic+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	334
	dw	222
	dw	s59
	dw	4198
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	17
	dw	10
	dw	chuck_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	chuck_logic
	dw	0


lazer_s4	dw	l_script
	dw	st_logic+st_recreate
	dw	0
	dw	4
	dw	NULL
	dd	NULL
	dw	331
	dw	210
	dw	0
	dw	4214
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	350-331
	dw	228-210
	dw	lazer_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	lazer_logic
	dw	0


cupboard_s4	dw	l_script
	dw	st_logic+st_recreate+st_background+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	248
	dw	214
	dw	s57
	dw	3+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	20
	dw	20
	dw	cupboard_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	cupboard_logic
	dw	0


sarnie_s4	dw	0
	dw	st_background+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	252
	dw	219
	dw	s61
	dw	4+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	5
	dw	5
	dw	sarnie_action
	dw	0
	dw	0
	dw	0
	dw	0


spanner_s4	dw	0
	dw	st_background+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	254
	dw	224
	dw	s62
	dw	8
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	5
	dw	5
	dw	spanner_action
	dw	0
	dw	0
	dw	0
	dw	0


monitors_s4	dw	l_script
	dw	st_background+st_logic+st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	NULL
	dw	NULL
	dw	s151
	dw	27+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	22
	dw	12
	dw	tv_1_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	NULL
	dd	0
	dw	0
	dw	c_base_mode
	dw	monitor_logic
	dw	0


buttons_s4	dw	0
	dw	st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	0
	dw	256
	dw	195
	dw	NULL
	dw	15+t7
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	8
	dw	15
	dw	button_action


postcard	dw	0
	dw	st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	NULL
	dw	167
	dw	224
	dw	NULL
	dw	4197
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	5
	dw	5
	dw	postcard_action


notice4	dw	0
	dw	st_mouse
	dw	0
	dw	4
	dw	NULL
	dd	NULL
	dw	152
	dw	232
	dw	NULL
	dw	4196
	dw	std_on
	dw	std_off
	dw	advisor_188
	dw	NULL
	dw	NULL
	dw	8
	dw	8
	dw	notice4_action



end32save_data

start32data



joey_list_s4	dw	224
	dw	320
	dw	232
	dw	296
	dw	1
	dw	224
	dw	304
	dw	256
	dw	272
	dw	0
	dw	0


sc4_logic	dw	id_foster
	dw	jobs
	dw	id_joey
	dw	id_tv_screens
	dw	id_knob
	dw	id_chuck
	dw	id_lazer
	dw	id_sarnie
	dw	id_spanner
	dw	id_cupboard
	dw	id_monitors
	dw	id_loader
	dw	id_top_lift
	dw	4344
	dw	id_top_barrel
	dw	id_light1
	dw	id_panel
	dw	$ffff
	dw	id_menu_logic


sc4_mouse	dw	jobs
	dw	id_joey
	dw	id_postcard
	dw	id_notice4
	dw	id_lazer
	dw	id_chuck
	dw	id_monitors
	dw	id_tv_screens
	dw	id_s4_l_exit
	dw	id_s4_floor
	dw	id_cupboard
	dw	id_knob
	dw	id_buttons
	dw	$ffff
	dw	id_text_mouse


sc4_mouse_open	dw	jobs
	dw	id_joey
	dw	id_postcard
	dw	id_notice4
	dw	id_lazer
	dw	id_chuck
	dw	id_monitors
	dw	id_tv_screens
	dw	id_s4_l_exit
	dw	id_s4_floor
	dw	id_sarnie
	dw	id_spanner
	dw	id_cupboard
	dw	id_knob
	dw	id_buttons
	dw	$ffff
	dw	id_text_mouse



end32data

start32save_data



c43	dd 0 dup (0)

jobsworth	dw	l_script
	dw	st_sort+st_recreate+st_logic+st_grid_plot+st_mouse+st_collision
	dw	0
	dw	0
	dw	id_low_floor
	dd	0
	dw	416
	dw	272
	dw	s73
	dw	4
	dw	std_on
	dw	std_off
	dw	mega_click
	dw	-4
	dw	-20
	dw	8
	dw	28
	dw	mega_action
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0


jobs_script	dw	start_jobs
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
	dw	sp_col_jobs
	dw	0
	dw	0
	dw	0
	dd	0
	dw	0
	dw	0
	dw	0
	dd	jobs_auto
	dw	0
	dw	0
	dw	0
	dw	8
	dw	8
	dd	m_jobs_up
	dd	m_jobs_down
	dd	m_jobs_left
	dd	m_jobs_right
	dd	m_jobs_st_up
	dd	m_jobs_st_down
	dd	m_jobs_st_left
	dd	m_jobs_st_right
	dd	m_jobs_st_talk
	dd	0
	dd	m_jobs_u_to_d
	dd	m_jobs_u_to_l
	dd	m_jobs_u_to_r
	dd	0
	dd	m_jobs_d_to_u
	dd	0
	dd	m_jobs_d_to_l
	dd	m_jobs_d_to_r
	dd	0
	dd	m_jobs_l_to_u
	dd	m_jobs_l_to_d
	dd	0
	dd	m_jobs_l_to_r
	dd	0
	dd	m_jobs_r_to_u
	dd	m_jobs_r_to_d
	dd	m_jobs_r_to_l
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
	dd	jobs_up
	dd	jobs_down
	dd	jobs_left
	dd	jobs_right
	dd	jobs_st_up
	dd	jobs_st_down
	dd	jobs_st_left
	dd	jobs_st_right
	dd	jobs_st_talk
	dd	0
	dd	jobs_u_to_d
	dd	jobs_u_to_l
	dd	jobs_u_to_r
	dd	0
	dd	jobs_d_to_u
	dd	0
	dd	jobs_d_to_l
	dd	jobs_d_to_r
	dd	0
	dd	jobs_l_to_u
	dd	jobs_l_to_d
	dd	0
	dd	jobs_l_to_r
	dd	0
	dd	jobs_r_to_u
	dd	jobs_r_to_d
	dd	jobs_r_to_l
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0


jobs_auto	db	64 dup (0)



end32save_data

start32data



m_jobs_left	dw	2
	dw	16+s270
	dw	-2
	dw	0
	dw	2
	dw	17+s270
	dw	-2
	dw	0
	dw	2
	dw	18+s270
	dw	-2
	dw	0
	dw	2
	dw	19+s270
	dw	-2
	dw	0
	dw	2
	dw	20+s270
	dw	-2
	dw	0
	dw	2
	dw	21+s270
	dw	-2
	dw	0
	dw	2
	dw	22+s270
	dw	-2
	dw	0
	dw	2
	dw	23+s270
	dw	-2
	dw	0
	dw	0


m_jobs_right	dw	2
	dw	24+s270
	dw	2
	dw	0
	dw	2
	dw	25+s270
	dw	2
	dw	0
	dw	2
	dw	26+s270
	dw	2
	dw	0
	dw	2
	dw	27+s270
	dw	2
	dw	0
	dw	2
	dw	28+s270
	dw	2
	dw	0
	dw	2
	dw	29+s270
	dw	2
	dw	0
	dw	2
	dw	30+s270
	dw	2
	dw	0
	dw	2
	dw	31+s270
	dw	2
	dw	0
	dw	0


m_jobs_up	dw	1
	dw	0+s270
	dw	0
	dw	-1
	dw	1
	dw	1+s270
	dw	0
	dw	-1
	dw	1
	dw	2+s270
	dw	0
	dw	-1
	dw	1
	dw	3+s270
	dw	0
	dw	-1
	dw	1
	dw	4+s270
	dw	0
	dw	-1
	dw	1
	dw	5+s270
	dw	0
	dw	-1
	dw	1
	dw	6+s270
	dw	0
	dw	-1
	dw	1
	dw	7+s270
	dw	0
	dw	-1
	dw	0


m_jobs_down	dw	1
	dw	8+s270
	dw	0
	dw	1
	dw	1
	dw	9+s270
	dw	0
	dw	1
	dw	1
	dw	10+s270
	dw	0
	dw	1
	dw	1
	dw	11+s270
	dw	0
	dw	1
	dw	1
	dw	12+s270
	dw	0
	dw	1
	dw	1
	dw	13+s270
	dw	0
	dw	1
	dw	1
	dw	14+s270
	dw	0
	dw	1
	dw	1
	dw	15+s270
	dw	0
	dw	1
	dw	0


m_jobs_st_up	dw	s270
	dw	1
	dw	1
	dw	36
	dw	0


m_jobs_st_down	dw	s270
	dw	1
	dw	1
	dw	32
	dw	0


m_jobs_st_left	dw	s270
	dw	1
	dw	1
	dw	34
	dw	0


m_jobs_st_right	dw	s270
	dw	1
	dw	1
	dw	38
	dw	0


m_jobs_st_talk	dw	s273
	dw	1
	dw	1
	dw	0
	dw	0


m_jobs_r_to_u	dw	45-8+s270
	dw	0


m_jobs_r_to_d	dw	47-8+s270
	dw	0


m_jobs_r_to_l	dw	45-8+s270
	dw	44-8+s270
	dw	43-8+s270
	dw	0


m_jobs_u_to_d	dw	43-8+s270
	dw	42-8+s270
	dw	41-8+s270
	dw	0


m_jobs_u_to_l	dw	43-8+s270
	dw	0


m_jobs_u_to_r	dw	45-8+s270
	dw	0


m_jobs_d_to_u	dw	47-8+s270
	dw	46-8+s270
	dw	45-8+s270
	dw	0


m_jobs_d_to_l	dw	41-8+s270
	dw	0


m_jobs_d_to_r	dw	47-8+s270
	dw	0


m_jobs_l_to_u	dw	43-8+s270
	dw	0


m_jobs_l_to_d	dw	41-8+s270
	dw	0


m_jobs_l_to_r	dw	41-8+s270
	dw	40-8+s270
	dw	47-8+s270
	dw	0


jobs_left	dw	4
	dw	16+s117
	dw	-4
	dw	0
	dw	4
	dw	17+s117
	dw	-4
	dw	0
	dw	4
	dw	18+s117
	dw	-4
	dw	0
	dw	4
	dw	19+s117
	dw	-4
	dw	0
	dw	4
	dw	20+s117
	dw	-4
	dw	0
	dw	4
	dw	21+s117
	dw	-4
	dw	0
	dw	4
	dw	22+s117
	dw	-4
	dw	0
	dw	4
	dw	23+s117
	dw	-4
	dw	0
	dw	0


jobs_right	dw	4
	dw	24+s117
	dw	4
	dw	0
	dw	4
	dw	25+s117
	dw	4
	dw	0
	dw	4
	dw	26+s117
	dw	4
	dw	0
	dw	4
	dw	27+s117
	dw	4
	dw	0
	dw	4
	dw	28+s117
	dw	4
	dw	0
	dw	4
	dw	29+s117
	dw	4
	dw	0
	dw	4
	dw	30+s117
	dw	4
	dw	0
	dw	4
	dw	31+s117
	dw	4
	dw	0
	dw	0


jobs_up	dw	2
	dw	0+s117
	dw	0
	dw	-2
	dw	2
	dw	1+s117
	dw	0
	dw	-2
	dw	2
	dw	2+s117
	dw	0
	dw	-2
	dw	2
	dw	3+s117
	dw	0
	dw	-2
	dw	2
	dw	4+s117
	dw	0
	dw	-2
	dw	2
	dw	5+s117
	dw	0
	dw	-2
	dw	2
	dw	6+s117
	dw	0
	dw	-2
	dw	2
	dw	7+s117
	dw	0
	dw	-2
	dw	0


jobs_down	dw	2
	dw	8+s117
	dw	0
	dw	2
	dw	2
	dw	9+s117
	dw	0
	dw	2
	dw	2
	dw	10+s117
	dw	0
	dw	2
	dw	2
	dw	11+s117
	dw	0
	dw	2
	dw	2
	dw	12+s117
	dw	0
	dw	2
	dw	2
	dw	13+s117
	dw	0
	dw	2
	dw	2
	dw	14+s117
	dw	0
	dw	2
	dw	2
	dw	15+s117
	dw	0
	dw	2
	dw	0


jobs_st_up	dw	s117
	dw	1
	dw	1
	dw	36
	dw	0


jobs_st_down	dw	s117
	dw	1
	dw	1
	dw	32
	dw	0


jobs_st_left	dw	s117
	dw	1
	dw	1
	dw	34
	dw	0


jobs_st_right	dw	s117
	dw	1
	dw	1
	dw	38
	dw	0


jobs_st_talk	dw	s134
	dw	1
	dw	1
	dw	0
	dw	0


jobs_r_to_u	dw	45-8+s117
	dw	0


jobs_r_to_d	dw	47-8+s117
	dw	0


jobs_r_to_l	dw	45-8+s117
	dw	44-8+s117
	dw	43-8+s117
	dw	0


jobs_u_to_d	dw	43-8+s117
	dw	42-8+s117
	dw	41-8+s117
	dw	0


jobs_u_to_l	dw	43-8+s117
	dw	0


jobs_u_to_r	dw	45-8+s117
	dw	0


jobs_d_to_u	dw	47-8+s117
	dw	46-8+s117
	dw	45-8+s117
	dw	0


jobs_d_to_l	dw	41-8+s117
	dw	0


jobs_d_to_r	dw	47-8+s117
	dw	0


jobs_l_to_u	dw	43-8+s117
	dw	0


jobs_l_to_d	dw	41-8+s117
	dw	0


jobs_l_to_r	dw	41-8+s117
	dw	40-8+s117
	dw	47-8+s117
	dw	0



end32data

start32save_data



end32save_data
