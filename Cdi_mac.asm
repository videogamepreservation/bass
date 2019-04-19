



;	CD intro files

cdv_00	equ	59500
cd_pal	equ	59501
cd_1_log	equ	59502
cd_1	equ	59503
cdv_01	equ	59504
cdv_02	equ	59505
cd_2	equ	59506
cdv_03	equ	59507
cdv_04	equ	59508
cd_3	equ	59509
cdv_05	equ	59510
cdv_06	equ	59511
cd_5	equ	59512
cdv_07	equ	59513
cdv_08	equ	59514
cdv_09	equ	59515
cd_7	equ	59516

cdv_10	equ	59518
cd_11	equ	59519
cdv_11	equ	59520
cd_11_pal	equ	59521
cd_11_log	equ	59522
cdv_12	equ	59523
cd_13	equ	59524
cdv_13	equ	59525

cdv_14	equ	59527
cdv_15	equ	59528
cd_15_pal	equ	59529
cd_15_log	equ	59530
cdv_16	equ	59531
cd_17_log	equ	59532
cd_17	equ	59533
cdv_17	equ	59534

cdv_18	equ	59535
cdv_19	equ	59536
cd_19_pal	equ	59537
cd_19_log	equ	59538
cdv_20	equ	59539

cd_20_log	equ	59540

cdv_21	equ	59541

cd_21_log	equ	59542

;cd_22	equ	59544
cdv_22	equ	59545
cdv_23	equ	59546
cd_23_pal	equ	59547
;cd_23_log	equ	59548
;cd_23	equ	59549

cd_24_log	equ	59550
cdv_24	equ	59551

cdv_25	equ	59554

cdv_26	equ	59556
cd_27	equ	59557
cdv_27	equ	59558
cd_27_pal	equ	59559
cd_27_log	equ	59560
cdv_28	equ	59561
cdv_29	equ	59562
cdv_30	equ	59563

cdv_31	equ	59565
cdv_32	equ	59566
cdv_33	equ	59567
cdv_34	equ	59568
cd_35	equ	59569
cdv_35	equ	59570
cd_35_pal	equ	59571
cd_35_log	equ	59572

cdv_36	equ	59574
cd_37	equ	59575
cdv_37	equ	59576
cd_37_pal	equ	59577
cd_37_log	equ	59578
cdv_38	equ	59579

cdv_39	equ	59581

cdv_40	equ	59583
cd_40_pal	equ	59584
cd_40_log	equ	59585

cdv_41	equ	59587
cdv_42	equ	59588
cd_43	equ	59589
cdv_43	equ	59590
cd_43_pal	equ	59591
cd_43_log	equ	59592

cdv_44	equ	59594
cd_45	equ	59595
cdv_45	equ	59596
cd_45_pal	equ	59597
cd_45_log	equ	59598

cdv_46	equ	59600

cdv_47	equ	59602

cd_47_pal	equ	59603
cd_47_log	equ	59604
cd_48	equ	59605
cdv_48	equ	59606
cd_48_pal	equ	59607
cd_48_log	equ	59608
cd_49	equ	59609
cdv_49	equ	59610
cd_50	equ	59611
cdv_50	equ	59612
cdv_51	equ	59613
cdv_52	equ	59614
cdv_53	equ	59615
cdv_54	equ	59616

cdv_55	equ	59618
cd_55_pal	equ	59619
cd_55_log	equ	59620
cdv_56	equ	59621
cdv_57	equ	59622
cd_58	equ	59623
cdv_58	equ	59624
cd_58_pal	equ	59625
cd_58_log	equ	59626
cdv_59	equ	59627
cdv_60	equ	59628
cdv_61	equ	59629
cdv_62	equ	59630
cdv_63	equ	59631
cdv_64	equ	59632
cdv_65	equ	59633

cdv_66	equ	59635
cd_66_pal	equ	59636
cd_66_log	equ	59637

cdv_67	equ	59639
cd_67_pal	equ	59640
cd_67_log	equ	59641
cdv_68	equ	59642
cd_69	equ	59643
cdv_69	equ	59644
cd_69_pal	equ	59645
cd_69_log	equ	59646
cdv_70	equ	59647
cdv_71	equ	59648
cdv_72	equ	59649
cd_72_pal	equ	59650
cd_72_log	equ	59651
cd_73_pal	equ	59652
cd_73_log	equ	59653
cdv_73	equ	59654
cdv_74	equ	59655
cdv_75	equ	59656
cd_76_pal	equ	59657
cd_76_log	equ	59658
cdv_76	equ	59659
cdv_77	equ	59660
cd_78_pal	equ	59661
cd_78_log	equ	59662
cdv_78	equ	59663
cdv_79	equ	59664
cdv_80	equ	59665
cdv_81	equ	59666
cdv_82	equ	59667

cdv_83	equ	59668
cdv_84	equ	59669
cdv_85	equ	59670
cdv_86	equ	59671
cdv_87	equ	59672

cd_100	equ	60087

cd_101_log	equ	60088
cd_101	equ	60099

cd_102_log	equ	60090
cd_102	equ	60091
cd_103_pal	equ	60092
cd_103_log	equ	60093
cd_103	equ	60094
cd_104_pal	equ	60095
cd_104_log	equ	60096
cd_104	equ	60097
cd_105	equ	60098


load_voc	macro num

ifdef selective_intro
	mov	eax,num
	cmp	eax,intro_start
	jc	lc_skip_&num&
endif

	cherror [cd_voices],ne,0,em_internal_error
	mov	eax,[cd_voices]
	jife	eax,lab_fr_&num&
	call	my_free
lab_fr_&num&:	mov	eax,cdv_&num&
	clear	edx
	call	load_file
	mov	[cd_voices],eax
lc_skip_&num&:

endm

load_seq	macro	num

ifndef which_seq
which_seq	=	1
else
IF	which_seq EQ 1
which_seq	=	2
ELSE
which_seq	=	1
ENDIF
endif

ifdef selective_intro
	mov	eax,num
	cmp	eax,intro_start
	jc	ls_skip_&num&
endif

IF	which_seq EQ 1
	free_if_n0 cd2_seq_data_1
ELSE
	free_if_n0 cd2_seq_data_2
ENDIF

	mov	eax,cd_&num&
	clear	edx
	call	load_file

IF	which_seq EQ 1
	mov	[cd2_seq_data_1],eax
ELSE
	mov	[cd2_seq_data_2],eax
ENDIF

ls_skip_&num&:

endm

start_sequence	macro num

ifdef selective_intro
	mov	eax,num
	cmp	eax,intro_start
	jc	ss_skip_&num&
endif	

IF	which_seq EQ 1
	mov	esi,[cd2_seq_data_1]
ELSE
	mov	esi,[cd2_seq_data_2]
ENDIF
	call	start_timer_sequence
ifdef selective_intro
ss_skip_&num&:
endif
endm


wait_sequence	macro	lab

wait_seq_&lab&:	;call	check_commands

ifdef debug_42
	call	debug_loop
endif

ifdef no_timer
	call	do_timer_sequence
	call	stabilise
endif

	call	fetch_key
	jne	key_pressed_eax
	test	[tseq_frames],-1
	jne	wait_seq_&lab&

endm

start_voc	macro	num

;	1/5 second pause before starting the voc's

ifdef debug_42
	mov	[c_text_no],num
	call	debug_loop
endif
ifdef selective_intro
	mov	eax,num
	cmp	eax,intro_start
	jc	sv_skip_&num&
endif

	mov	eax,[game_50hz_count]
sv_wait_&num&:	mov	ebx,[game_50hz_count]
	sub	ebx,eax
	cmp	ebx,20
	jc	sv_wait_&num&

	mov	esi,[cd_voices]
	movzx	ecx,(s ptr[esi]).s_tot_size
	lea	esi,SIZE s[esi]
	push	esi
	push	ecx
	push	0
	call	_play_voc_data__Npcii
	bts	[system_flags],sf_voc_playing
	free_clr2 [cd_voices]

sv_skip_&num&:

endm

wait_voc	macro lab
	local freddy

wait_voc_&lab&:	mov	al,-1
	call	voc_progress_report2
ifdef debug_42
	call	debug_loop
endif
	call	fetch_key
	jne	key_pressed_eax
ifndef no_timer
	btr	[system_flags],sf_timer_tick
freddy:	btr	[system_flags],sf_timer_tick
	jnc	freddy
endif

	bt	[system_flags],sf_voc_playing
	jc	wait_voc_&lab&
endm


cd_fade_up	macro	seq

ifdef selective_intro
	mov	eax,seq
	cmp	eax,intro_start
	jc	cdfj_&seq&
	call	fade_up_esi
	jmp	cdfp_&seq&
cdfj_&seq&:	call	set_palette
cdfp_&seq&:
else
	call	fade_up_esi
endif
endm

cd_fade_down	macro	seq

ifdef selective_intro
	mov	eax,seq
	cmp	eax,intro_start
	jc	cdfdj_&seq&
	call	fn_fade_down
cdfdj_&seq&:
else
	call	fn_fade_down
endif
endm


load_to_cd	macro num,dest
	local fred

	mov	eax,num
	clear	edx
	call	load_file
	xchg	dest,eax
	jife	eax,fred
	call	my_free
fred:
endm


load_background	macro num

	mov	eax,num
	mov	edx,[back_voc_space]
	call	load_file
	mov	[back_voc_space],eax
endm



play_background	macro	num

	mov	esi,[back_voc_space]
	movzx	ecx,(s ptr[esi]).s_tot_size
	lea	esi,SIZE s[esi]
	push	esi
	push	ecx
	push	1
	call	_play_voc_data__Npcii
endm

