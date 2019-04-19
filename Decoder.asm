	call	get_tbit
	jc	label_1

	call	get_tbit
	jc	label_2

	call	get_tbit
	jc	label_3

	mov	al,' '
	ret

label_3:	call	get_tbit
	jc	label_4

	mov	al,'e'
	ret

label_4:	mov	al,'a'
	ret

label_2:	call	get_tbit
	jc	label_5

	call	get_tbit
	jc	label_6

	call	get_tbit
	jc	label_7

	mov	al,'o'
	ret

label_7:	mov	al,'s'
	ret

label_6:	call	get_tbit
	jc	label_8

	mov	al,'t'
	ret

label_8:	mov	al,'n'
	ret

label_5:	call	get_tbit
	jc	label_9

	call	get_tbit
	jc	label_10

	mov	al,'.'
	ret

label_10:	mov	al,'i'
	ret

label_9:	mov	al,'r'
	ret

label_1:	call	get_tbit
	jc	label_11

	call	get_tbit
	jc	label_12

	call	get_tbit
	jc	label_13

	call	get_tbit
	jc	label_14

	call	get_tbit
	jc	label_15

	mov	al,0
	ret

label_15:	mov	al,'E'
	ret

label_14:	mov	al,'u'
	ret

label_13:	call	get_tbit
	jc	label_16

	mov	al,'m'
	ret

label_16:	mov	al,'A'
	ret

label_12:	call	get_tbit
	jc	label_17

	call	get_tbit
	jc	label_18

	call	get_tbit
	jc	label_19

	mov	al,'l'
	ret

label_19:	mov	al,'I'
	ret

label_18:	call	get_tbit
	jc	label_20

	mov	al,'d'
	ret

label_20:	mov	al,'R'
	ret

label_17:	call	get_tbit
	jc	label_21

	call	get_tbit
	jc	label_22

	mov	al,'N'
	ret

label_22:	mov	al,'S'
	ret

label_21:	mov	al,'T'
	ret

label_11:	call	get_tbit
	jc	label_23

	call	get_tbit
	jc	label_24

	call	get_tbit
	jc	label_25

	call	get_tbit
	jc	label_26

	call	get_tbit
	jc	label_27

	mov	al,'O'
	ret

label_27:	mov	al,'h'
	ret

label_26:	mov	al,'c'
	ret

label_25:	call	get_tbit
	jc	label_28

	mov	al,'D'
	ret

label_28:	mov	al,'g'
	ret

label_24:	call	get_tbit
	jc	label_29

	call	get_tbit
	jc	label_30

	call	get_tbit
	jc	label_31

	mov	al,'L'
	ret

label_31:	mov	al,'C'
	ret

label_30:	call	get_tbit
	jc	label_32

	mov	al,'p'
	ret

label_32:	mov	al,'U'
	ret

label_29:	call	get_tbit
	jc	label_33

	call	get_tbit
	jc	label_34

	mov	al,'!'
	ret

label_34:	mov	al,'y'
	ret

label_33:	mov	al,'M'
	ret

label_23:	call	get_tbit
	jc	label_35

	call	get_tbit
	jc	label_36

	call	get_tbit
	jc	label_37

	call	get_tbit
	jc	label_38

	call	get_tbit
	jc	label_39

	mov	al,'P'
	ret

label_39:	mov	al,'v'
	ret

label_38:	mov	al,'H'
	ret

label_37:	call	get_tbit
	jc	label_40

	mov	al,'?'
	ret

label_40:	mov	al,'b'
	ret

label_36:	call	get_tbit
	jc	label_41

	call	get_tbit
	jc	label_42

	call	get_tbit
	jc	label_43

	mov	al,39
	ret

label_43:	mov	al,'f'
	ret

label_42:	mov	al,','
	ret

label_41:	call	get_tbit
	jc	label_44

	mov	al,'G'
	ret

label_44:	mov	al,'B'
	ret

label_35:	call	get_tbit
	jc	label_45

	call	get_tbit
	jc	label_46

	call	get_tbit
	jc	label_47

	call	get_tbit
	jc	label_48

	call	get_tbit
	jc	label_49

	mov	al,'V'
	ret

label_49:	mov	al,'k'
	ret

label_48:	mov	al,'F'
	ret

label_47:	call	get_tbit
	jc	label_50

	mov	al,'q'
	ret

label_50:	mov	al,'w'
	ret

label_46:	call	get_tbit
	jc	label_51

	call	get_tbit
	jc	label_52

	call	get_tbit
	jc	label_53

	mov	al,'K'
	ret

label_53:	mov	al,'-'
	ret

label_52:	mov	al,'W'
	ret

label_51:	call	get_tbit
	jc	label_54

	mov	al,'J'
	ret

label_54:	mov	al,'*'
	ret

label_45:	call	get_tbit
	jc	label_55

	call	get_tbit
	jc	label_56

	call	get_tbit
	jc	label_57

	call	get_tbit
	jc	label_58

	mov	al,'z'
	ret

label_58:	mov	al,'Y'
	ret

label_57:	call	get_tbit
	jc	label_59

	mov	al,'j'
	ret

label_59:	mov	al,'+'
	ret

label_56:	call	get_tbit
	jc	label_60

	call	get_tbit
	jc	label_61

	call	get_tbit
	jc	label_62

	mov	al,'Q'
	ret

label_62:	mov	al,133
	ret

label_61:	mov	al,')'
	ret

label_60:	call	get_tbit
	jc	label_63

	call	get_tbit
	jc	label_64

	mov	al,'Z'
	ret

label_64:	mov	al,139
	ret

label_63:	mov	al,'<'
	ret

label_55:	call	get_tbit
	jc	label_65

	call	get_tbit
	jc	label_66

	call	get_tbit
	jc	label_67

	call	get_tbit
	jc	label_68

	call	get_tbit
	jc	label_69

	mov	al,149
	ret

label_69:	mov	al,126
	ret

label_68:	mov	al,138
	ret

label_67:	call	get_tbit
	jc	label_70

	mov	al,135
	ret

label_70:	mov	al,':'
	ret

label_66:	call	get_tbit
	jc	label_71

	call	get_tbit
	jc	label_72

	call	get_tbit
	jc	label_73

	mov	al,127
	ret

label_73:	mov	al,']'
	ret

label_72:	mov	al,'#'
	ret

label_71:	call	get_tbit
	jc	label_74

	call	get_tbit
	jc	label_75

	mov	al,'x'
	ret

label_75:	mov	al,'X'
	ret

label_74:	mov	al,145
	ret

label_65:	call	get_tbit
	jc	label_76

	call	get_tbit
	jc	label_77

	call	get_tbit
	jc	label_78

	call	get_tbit
	jc	label_79

	call	get_tbit
	jc	label_80

	mov	al,136
	ret

label_80:	mov	al,'`'
	ret

label_79:	mov	al,'2'
	ret

label_78:	call	get_tbit
	jc	label_81

	call	get_tbit
	jc	label_82

	mov	al,'0'
	ret

label_82:	mov	al,131
	ret

label_81:	mov	al,'1'
	ret

label_77:	call	get_tbit
	jc	label_83

	call	get_tbit
	jc	label_84

	call	get_tbit
	jc	label_85

	mov	al,'/'
	ret

label_85:	mov	al,'('
	ret

label_84:	mov	al,'='
	ret

label_83:	call	get_tbit
	jc	label_86

	mov	al,134
	ret

label_86:	mov	al,'^'
	ret

label_76:	call	get_tbit
	jc	label_87

	call	get_tbit
	jc	label_88

	call	get_tbit
	jc	label_89

	call	get_tbit
	jc	label_90

	mov	al,'3'
	ret

label_90:	mov	al,'9'
	ret

label_89:	call	get_tbit
	jc	label_91

	mov	al,152
	ret

label_91:	mov	al,'4'
	ret

label_88:	call	get_tbit
	jc	label_92

	call	get_tbit
	jc	label_93

	call	get_tbit
	jc	label_94

	mov	al,'}'
	ret

label_94:	mov	al,'8'
	ret

label_93:	mov	al,'\'
	ret

label_92:	call	get_tbit
	jc	label_95

	mov	al,'"'
	ret

label_95:	mov	al,144
	ret

label_87:	call	get_tbit
	jc	label_96

	call	get_tbit
	jc	label_97

	call	get_tbit
	jc	label_98

	call	get_tbit
	jc	label_99

	mov	al,'&'
	ret

label_99:	mov	al,141
	ret

label_98:	call	get_tbit
	jc	label_100

	mov	al,'5'
	ret

label_100:	mov	al,'6'
	ret

label_97:	call	get_tbit
	jc	label_101

	call	get_tbit
	jc	label_102

	mov	al,146
	ret

label_102:	mov	al,143
	ret

label_101:	call	get_tbit
	jc	label_103

	mov	al,142
	ret

label_103:	mov	al,147
	ret

label_96:	call	get_tbit
	jc	label_104

	call	get_tbit
	jc	label_105

	call	get_tbit
	jc	label_106

	call	get_tbit
	jc	label_107

	mov	al,140
	ret

label_107:	mov	al,'7'
	ret

label_106:	mov	al,128
	ret

label_105:	call	get_tbit
	jc	label_108

	call	get_tbit
	jc	label_109

	mov	al,129
	ret

label_109:	mov	al,153
	ret

label_108:	call	get_tbit
	jc	label_110

	mov	al,'$'
	ret

label_110:	mov	al,'@'
	ret

label_104:	call	get_tbit
	jc	label_111

	call	get_tbit
	jc	label_112

	call	get_tbit
	jc	label_113

	call	get_tbit
	jc	label_114

	mov	al,'['
	ret

label_114:	mov	al,154
	ret

label_113:	mov	al,'_'
	ret

label_112:	call	get_tbit
	jc	label_115

	mov	al,'>'
	ret

label_115:	mov	al,150
	ret

label_111:	call	get_tbit
	jc	label_116

	call	get_tbit
	jc	label_117

	call	get_tbit
	jc	label_118

	mov	al,130
	ret

label_118:	mov	al,'%'
	ret

label_117:	mov	al,9
	ret

label_116:	call	get_tbit
	jc	label_119

	call	get_tbit
	jc	label_120

	mov	al,156
	ret

label_120:	mov	al,151
	ret

label_119:	call	get_tbit
	jc	label_121

	mov	al,'{'
	ret

label_121:	call	get_tbit
	jc	label_122

	mov	al,148
	ret

label_122:	mov	al,'|'
	ret

