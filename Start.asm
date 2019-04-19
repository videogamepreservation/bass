include_version_info equ 1
	include include.asm




start32data

%exe_version	byte	"&@Date"
%	db	"&@Time"

finger_print	db	fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12,fp13,fp14,fp15,fp16,fp17
	db	0

end32data


start32save_data

start_of_save_data	dd	?					;store for save game data size

%save_version	db	"&@Date"
%	db	"&@Time"
save_version_end	db	0 dup (0)

	db	"(C) Revolution Software Ltd 1993.",0

	db	"System 2 written by David Sykes and Tony Warriner",10,13
	db	"All PC code (bar music drivers) written by David Sykes",10,13

current_version	db	current_version_text
replay_version	db	current_version_text2

	db	2,1,2,8,7,4

	db	fp1+22
	db	0
	db	fp2+22
	db	250,52
	db	fp3+44
	db	67,111,222
	db	fp4+99
	db	77,91,250,66
	db	fp5+88
	db	184
	db	fp6
	db	9,9,9
	db	fp7+50
	db	100,65,239,83,1,239
	db	fp8+71
	db	71
	db	fp9
	db	-7,-20
	db	fp10+17
	db	3,6,9,12,15
	db	fp11+18
	db	76
	db	fp12+7
	db	6,6,6
	db	fp13+19
	db	fp14+19
	db	fp15+19
	db	fp16+19
	db	fp17+19


end32save_data

	end
