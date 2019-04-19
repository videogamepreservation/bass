	include include.asm




start32code
	extrn	get_tbit:near


get_text_char	proc

	include decoder.asm

get_text_char	endp


end32code

	end
