include_macros	equ	1
include_deb_mac	equ	1
include_struc	equ	1
include_flags	equ	1
include_error_codes equ	1
	include include.asm
	include cdi_mac.asm


ifdef selective_intro
intro_start	equ	80
endif

ifdef short_intro_start

;virgin_time_1	equ	3
;virgin_time_2	equ	3
;rev_time	equ	8
gibb_time	equ	6

else

;virgin_time_1	equ	3*50
;virgin_time_2	equ	3*50+8
;rev_time	equ	8*50+8
gibb_time	equ	6*50+8

endif


start32data
	extrn	temp_pal:dword
	extrn	work_screen:dword

cd2_seq_data_1	dd	?
cd2_seq_data_2	dd	?
cd_voices	dd	0					;space for voice data
back_voc_space	dd	0					;space for background data

end32data






start32code
	extrn	show_screen:near
	extrn	fade_up_esi:near


do_the_cd_intro	proc

;	While gibbo is up load in the first sequence stuff

	mov	eax,65536				;make up space for backgrounds
	call	my_malloc
	mov	[back_voc_space],eax

	load_voc 00
	load_to_cd cd_pal,[temp_pal]
	load_to_cd cd_1_log,[work_screen]
	load_seq 1
	load_background 59499				;fire crackle

	mov	eax,gibb_time				;keep gibbo up for 2 seconds
	call	wait_relative
	jc	key_pressed_ebx

;	Fade in and start the first sequence					seq 1

	cd_fade_down 0

	start_voc 0					;old man was trying
	play_background
	load_voc 01
	wait_voc 0

	start_voc 1					;evil oh i see evil
	play_background

	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 1

	start_sequence 1				;start off sequence 1

	load_voc 02
	wait_voc 1
	start_voc 2					;Evil born beneath the city
	play_background

	load_seq 2					;load sequence 2 while 1 running
	load_voc 03

	;wait_sequence cd_1
	wait_voc 2

	start_sequence 2
	start_voc 3					;I see it growing
	play_background

	load_voc 04

	wait_voc 3

	start_voc 4					;Scheming in the dark
	play_background

	load_seq 3					;load sequence 3 while 2 running
	load_voc 05

	wait_sequence cd_2
	wait_voc 4

	start_voc 5					;And now the evil spreads
	play_background

	mov	[relative_50hz_count],0			;Start sequence in middle of voc
	mov	eax,100
	call	wait_relative
	start_sequence 3

	load_voc 06
	wait_voc 5
	start_voc 6					;It sends deadly feelers
	play_background

	load_seq 5					;load sequence 5 while 3 running
	load_voc 07

	wait_sequence cd_3
	wait_voc 6

	start_voc 7					;Accross the gap
	start_sequence 5
	play_background

	load_voc 08
	wait_voc 7
	start_voc 8					;I'd seen him do this a hundred times
	play_background
	load_voc 09
	wait_voc 8
	start_voc 9					;After all, he'd been a father
	play_background

	load_seq 7					;load sequence 7 while 5 running
	load_voc 10

	wait_sequence cd_5
	wait_voc 9

	start_voc 10					;And what does this evil want here
	start_sequence 7
	play_background

	load_to_cd cd_11_pal,[temp_pal]
	load_to_cd cd_11_log,[work_screen]
	load_seq 11					;load sequence 11 while 10 running
	load_voc 11

	wait_voc 10
	start_voc 11					;Oh my son I fear
	play_background

	cd_fade_down 11
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 11

	load_voc 12

	wait_sequence cd_7
	wait_voc 11

	start_voc 12					;Oh my son I fear
	play_background

	mov	[relative_50hz_count],0			;Start sequence in middle of voc
	mov	eax,80
	call	wait_relative

	start_sequence 11

	load_voc 13

	wait_voc 12

	start_voc 13					;That was when joey piped up
	play_background

	load_seq 13					;load sequence 13 while 11 running
	load_voc 14
	load_background 59498				;fire crackle to heli start

	wait_sequence cd_11
	wait_voc 13

	start_voc 14					;Foster sensors detect
	start_sequence 13
	play_background

	load_voc 15
	load_to_cd cd_15_pal,[temp_pal]
	load_to_cd cd_15_log,[work_screen]

	wait_sequence cd_13
	wait_voc 14

	start_voc 15					;the evil is nearly here
	play_background
	cd_fade_down 15
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 15

	load_voc 16
	wait_voc 15
	start_voc 16					;It sounded more like a copter
	play_background

	load_to_cd cd_17_log,[work_screen]
	load_seq 17					;load sequence 17 while 15 running
	load_voc 17

	wait_voc 16

	start_voc 17					;Next thing all hell let loose

	mov	[relative_50hz_count],0			;Start sequence in middle of voc
	mov	eax,40
	call	wait_relative

	call	show_screen

	load_voc 18
	load_background 59497				;Loud heli

	wait_voc 17

	start_sequence 17
	start_voc 18					;Run foster run
	play_background

;	load_seq 19					;load sequence 19 while 18 running
	load_voc 19
	load_to_cd cd_19_pal,[temp_pal]
	load_to_cd cd_19_log,[work_screen]
	play_background
	load_background 59496				;loud heli to quiet

	wait_sequence cd_17
	wait_voc 18

	cd_fade_down 17
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 19

	start_voc 19					;Foster zzzt help
	play_background

	load_voc 20
	load_to_cd cd_20_log,[work_screen]
	load_background 59495				;quiet heli

	wait_voc 19

;	start_sequence 19
	start_voc 20					;make my body move faster next time
	play_background

	cd_fade_down 19
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 20

;	load_seq 20					;load sequence 20 while 19 running
	load_voc 21
	load_to_cd cd_21_log,[work_screen]

	play_background
	wait_sequence cd_19
	wait_voc 20

;	start_sequence 20
	start_voc 21					;He was only a robot but I loved the guy
	play_background

	cd_fade_down 20
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 21

;	load_seq 22					;load sequence 22 while 20 running
	load_voc 22
	load_background 59494				;heli whine

	wait_sequence cd_20
	wait_voc 21

;	start_sequence 22
	start_voc 22					;Then as suddenly
	play_background

	load_voc 23

;	wait_sequence cd_22
	wait_voc 22

	start_voc 23					;moments silence
	cd_fade_down 23					;fudd to black

	load_to_cd cd_23_pal,[temp_pal]
;	load_to_cd cd_23_log,[work_screen]
;	load_seq 23
	load_to_cd cd_24_log,[work_screen]
	load_voc 24

	wait_voc 23

	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 23
;	start_sequence 23


;	wait_sequence cd_23

	start_voc 24					;whoever is in charge
	call	show_screen

	load_voc 25
	wait_voc 24
	start_voc 25					;Now
	load_voc 26
	wait_voc 25
	start_voc 26

	load_seq 27
	load_voc 27
	load_to_cd cd_27_pal,[temp_pal]
	load_to_cd cd_27_log,[work_screen]

	wait_voc 26

	cd_fade_down 26
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 27

	start_voc 27

	;load_voc 28
	;wait_voc 27
	;start_voc 28
	;load_voc 29
	;wait_voc 28
	load_voc 29
	wait_voc 27

	start_voc 29
	load_voc 30
	wait_voc 29
	start_voc 30
	load_voc 31
	wait_voc 30

	start_sequence 27
	start_voc 31

	load_voc 32
	wait_voc 31
	start_voc 32
	load_voc 33
	wait_voc 32
	start_voc 33
	load_voc 34
	wait_voc 33
	start_voc 34
	load_voc 35
	wait_sequence 27
	wait_voc 34

	start_voc 35

	load_seq 35
	load_voc 36
	load_to_cd cd_35_pal,[temp_pal]
	load_to_cd cd_35_log,[work_screen]

	wait_voc 35

	start_voc 36

	cd_fade_down 34
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 35

	load_voc 37

	wait_voc 36

	start_sequence 35
	start_voc 37

	load_seq 37
	load_voc 38

	wait_sequence 35
	wait_voc 37

	start_voc 38
	start_sequence 37

	load_voc 39

	wait_sequence 37
	wait_voc 38

	start_voc 39

	load_voc 40
	load_to_cd cd_40_pal,[temp_pal]
	load_to_cd cd_40_log,[work_screen]

	wait_voc 39

	cd_fade_down 39
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 40

	start_voc 40
	load_voc 41
	wait_voc 40
	start_voc 41
	load_voc 42
	wait_voc 41
	start_voc 42

	load_voc 43
	load_to_cd cd_43_pal,[temp_pal]
	load_to_cd cd_43_log,[work_screen]

	wait_voc 42

	cd_fade_down 42
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 43

	start_voc 43

	;load_voc 44
	load_seq 43

	wait_voc 43

	;start_voc 44
	start_sequence 43

	load_voc 45
	load_to_cd cd_45_pal,[temp_pal]
	load_to_cd cd_45_log,[work_screen]

	wait_sequence 43
	;wait_voc 44

	start_voc 45

	cd_fade_down 44
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 45

	load_seq 45
	load_voc 46

	wait_voc 45

	start_sequence 45
	start_voc 46

	load_voc 47
	load_to_cd cd_47_pal,[temp_pal]
	load_to_cd cd_47_log,[work_screen]

	wait_sequence 45
	wait_voc 46

	cd_fade_down 46
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 47
	start_voc 47

	load_voc 48
	load_to_cd cd_48_pal,[temp_pal]
	load_to_cd cd_48_log,[work_screen]

	wait_voc 47

	start_voc 48
	cd_fade_down 47
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 48

	load_seq 48
	load_voc 49

	wait_voc 48

	start_sequence 48
	start_voc 49

	load_voc 50
	wait_voc 49
	start_voc 50

	load_seq 49
	load_voc 51

	wait_sequence 48
	wait_voc 50

	start_voc 51
	start_sequence 49

	load_voc 52
	wait_voc 51
	start_voc 52
	load_voc 53
	wait_voc 52
	start_voc 53
	load_voc 54
	load_seq 50
	wait_voc 53
	wait_sequence 49

	start_voc 54
	start_sequence 50

	load_voc 55

	wait_sequence 50
	wait_voc 54

	start_voc 55

	load_to_cd cd_55_pal,[temp_pal]
	load_to_cd cd_55_log,[work_screen]
	load_voc 56

	wait_voc 55
	start_voc 56

	cd_fade_down 55
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 55

	load_voc 57
	wait_voc 56
	start_voc 57

	load_voc 58
	load_to_cd cd_58_pal,[temp_pal]
	load_to_cd cd_58_log,[work_screen]

	wait_voc 57

	cd_fade_down 57
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 58

	start_voc 58
	load_voc 59
	wait_voc 58
	start_voc 59

	load_seq 58

	wait_voc 59

	load_voc 60
	start_voc 60
	load_voc 61
	wait_voc 60
	start_voc 61
	load_voc 62
	wait_voc 61
	start_voc 62

	start_sequence 58

	load_voc 63
	wait_voc 62
	start_voc 63
	load_voc 64
	wait_voc 63
	start_voc 64

	load_voc 65

	wait_sequence 58
	wait_voc 64

	start_voc 65
	cd_fade_down 65

	load_voc 66
	load_to_cd cd_66_pal,[temp_pal]
	load_to_cd cd_66_log,[work_screen]

	wait_voc 65

	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 66

	start_voc 66
	load_voc 67
	wait_voc 66

	start_voc 67

	load_to_cd cd_67_pal,[temp_pal]
	load_to_cd cd_67_log,[work_screen]

	cd_fade_down 66
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 67

	load_voc 68
	wait_voc 67
	start_voc 68

	load_seq 69
	load_voc 69
	load_to_cd cd_69_pal,[temp_pal]
	load_to_cd cd_69_log,[work_screen]

	wait_voc 68

	start_voc 69

	cd_fade_down 68
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 69

	load_voc 70
	wait_voc 69

	start_sequence 69
	start_voc 70

	load_voc 71

	wait_voc 70

	cd_fade_down 71
	start_voc 71

	load_to_cd cd_72_pal,[temp_pal]
	load_to_cd cd_72_log,[work_screen]

	wait_voc 71

	call	show_screen
	mov	esi,[temp_pal]
	call	set_palette

	load_voc 72
	start_voc 72

	load_to_cd cd_73_pal,[temp_pal]
	load_to_cd cd_73_log,[work_screen]
	load_voc 73

	wait_voc 72

	cd_fade_down 72
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 73

	start_voc 73
	load_voc 74
	wait_voc 73
	start_voc 74
	load_voc 75
	wait_voc 74
	start_voc 75

	load_to_cd cd_76_pal,[temp_pal]
	load_to_cd cd_76_log,[work_screen]

	cd_fade_down 75
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 76

	printf "==============================================================="

	load_voc 76
	wait_voc 75
	start_voc 76
	load_voc 77
	wait_voc 76
	start_voc 77

	load_seq 100
	load_to_cd cd_78_pal,[temp_pal]
	load_to_cd cd_78_log,[work_screen]
	load_voc 78

	wait_voc 77

	cd_fade_down 77
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 77

	start_voc 78

	load_voc 79
	wait_voc 78
	start_voc 79
	load_voc 80
	wait_voc 79
	start_voc 80
	start_sequence 100
	load_voc 81
	wait_voc 80
	start_voc 81
	load_voc 82
	wait_voc 81
	start_voc 82
	load_voc 83
	wait_voc 82

	load_to_cd cd_101_log,[work_screen]
	load_seq 101

	wait_sequence 100

	call	show_screen
	start_sequence 101

	start_voc 83
	load_voc 84
	wait_voc 83
	start_voc 84
	load_voc 85
	wait_voc 84
	start_voc 85
	load_voc 86
	wait_voc 85

	load_to_cd cd_102_log,[work_screen]
	load_seq 102

	wait_sequence 101

	call	show_screen
	start_sequence 102

	start_voc 86
	load_voc 87

	load_to_cd cd_103_pal,[temp_pal]
	load_to_cd cd_103_log,[work_screen]
	load_seq 103

	wait_sequence 102

	cd_fade_down 102
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 103

	start_sequence 103

	wait_voc 86
	start_voc 87

	load_to_cd cd_104_pal,[temp_pal]
	load_to_cd cd_104_log,[work_screen]
	load_seq 104

	wait_sequence 103

	mov	eax,2
	call	fn_start_music

	cd_fade_down 103
	call	show_screen
	mov	esi,[temp_pal]
	cd_fade_up 104

	start_sequence 104

	load_seq 105

	wait_sequence 104

	start_sequence 105

	wait_sequence 105

;--------------------------------------------------------------------------------------------------


	clear	ebx			;no key was pressed
key_pressed_ebx:	ret

key_pressed_eax:	mov	ebx,eax
	ret


do_the_cd_intro	endp


end32code

	end
