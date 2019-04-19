	include include.asm




;--------------------------------------------------------------------------------------------------



;-------------------------------------------------------------------------------
; PROPACK 8086 Source Code for Unpacking RNC Method 1 Packed Files (flat model)
;
; Copyright (c) 1991-93 Rob Northen Computing, UK. All Rights Reserved.
;
; File: RNC_1FMM.ASM (masm version)
;
; Date: 21.04.93
;-------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; UnpackM1 (flat model version, 32-bit addressing)
;
;     Function  Uncompresses an RNC Method 1 Packed File in memory
;
;       Syntax  long UnpackM1(void far *input, void far *output, int key)
;
;      Remarks  Unpack uncompresses an RNC packed file held in the input buffer
;               and writes the uncompressed version of the file to the output
;               buffer. This function performs no disk access. The packed file
;               must be loaded into the input buffer prior to calling this
;               function. Similarly the output buffer is not written to disk
;               after the decompression has taken place.
;
;               input is the memory address of the input buffer containing the
;               RNC packed file and output is the memory address of the output
;               buffer where the uncompressed version of the file is to be
;               written.
;
;               int key is the value of the key used when the RNC file was
;               packed, if any other value is used the uncompression will fail.
;               If no key was used when the RNC file was packed then the value
;               passed in int key is ignored.
;
;               Unpack can be called with the input buffer equal to the output
;               buffer, in which case the compressed version of the file will
;               be overwritten by the uncompressed version.
;
; Return Value  If successful Unpack returns the length of the uncompressed
;               file. On failure Unpack returns a zero or a negative error code:
;
;                0 = the input buffer does not point to an RNC packed file
;               -1 = the   packed data in the  input buffer has a CRC error
;               -2 = the unpacked data in the output buffer has a CRC error
;
; To Call from Assembler,
;
;               push    key             ; word
;               push    output          ; dword
;               push    input           ; dword
;               call    UnpackM1
;               add     esp,10
;
; On exit,
;       carry flag = result, 0 = success, 1 = fail
;       AX = length of unpacked file in bytes OR error code (low word)
;       DX = length of unpacked file in bytes OR error code (high word)
;            0 = the input buffer does not point to an RNC packed file
;           -1 = the   packed data in the  input buffer has a CRC error
;           -2 = the unpacked data in the output buffer has a CRC error
;------------------------------------------------------------------------------

;                .386
;
;				.MODEL FLAT

;-------------------------------------------------------------------------------
; Conditional Assembly Flags
;-------------------------------------------------------------------------------

CHECKSUMS       EQU     1               ; set this flag to 1 if you require
                                        ; the data to be validated

PROTECTED       EQU     0               ; set this flag to 1 if you are unpacking
                                        ; files packed with the "-K" option

;-------------------------------------------------------------------------------
; Return Codes
;-------------------------------------------------------------------------------

NOT_PACKED      EQU     0
PACKED_CRC      EQU     -1
UNPACKED_CRC    EQU     -2

;-------------------------------------------------------------------------------
; Other Equates
;-------------------------------------------------------------------------------

TABLE_SIZE      EQU     16*8
MIN_LENGTH      EQU     2
HEADER_LEN      EQU     18

;-------------------------------------------------------------------------------
; Macros
;-------------------------------------------------------------------------------

getrawREP       MACRO
                IFE PROTECTED
                rep     movsb
                ELSE
getrawREP2:
                lodsb
                xor     al,BYTE PTR key
                stosb
                loop    getrawREP2
                ror     key,1
                ENDIF
                ENDM

;-------------------------------------------------------------------------------
; Data Segment
;-------------------------------------------------------------------------------

start32data
;                .DATA

raw_table		db      TABLE_SIZE dup(?)
pos_table		db      TABLE_SIZE dup(?)
len_table		db      TABLE_SIZE dup(?)
                IF CHECKSUMS
crc_table		db      200h dup(?)
                ENDIF

unpack_len      dd  0
pack_len        dd  0
pack_paras      dw  0
counts          dw  0
bit_buffl       dw  0
bit_buffh       dw  0
blocks          db  0
bit_count       db  0
                IF CHECKSUMS
crc_u           dw  0
crc_p           dw  0
                ENDIF

end32data

;-------------------------------------------------------------------------------
; Code Segment
;-------------------------------------------------------------------------------

start32code
;                .CODE

                PUBLIC C UnpackM1

UnpackM1        PROC NEAR C	USES esi edi ds es,input:dword,output:dword

                IF PROTECTED
				ARG     key        :WORD    ; must be added to above
                ENDIF

                cld
                push    ds
                pop     es                  ; ensure es=ds

                IF CHECKSUMS
                call    init_crc
                ENDIF

                mov     esi,input           ; pointer to packed file
                lodsw
                cmp     ax,4e52h
                jne     not_pack
                lodsw
                cmp     ax,0143h
                jne     not_pack
                call    read_long           ; read unpacked file length
                mov     unpack_len,eax
                call    read_long           ; read packed file length
                mov     pack_len,eax
                mov     bl,[esi+5]
                mov     BYTE PTR blocks,bl

                IF CHECKSUMS
                call    read_long           ; read crc's
                mov     crc_p,ax
                ror     eax,16
                mov     crc_u,ax
                add     esi,HEADER_LEN-16
                mov     ecx,pack_len
                call    crc_block           ; find packed data crc
                cmp     crc_p,bx
                jne     pack_crc            ; branch if bad packed data CRC
                mov     eax,pack_len
                mov     esi,input
                add     esi,HEADER_LEN
                ELSE
                add     esi,HEADER_LEN-12
                ENDIF

                add     eax,HEADER_LEN
                mov     edx,input           ; input_lo
                mov     ebx,output          ; output_lo
                add     edx,eax             ; input_hi
                cmp     edx,ebx
                jbe     unpack3             ; branch if input_hi <= output_lo
                mov     edi,input
                xor     eax,eax
                mov     al,[edi+16]         ; unpack bufsiz
                add     eax,unpack_len
                add     ebx,eax             ; output_hi
                cmp     ebx,edx             ; branch if output_hi <= input_hi
                jbe     unpack3
                mov     esi,edx
                mov     edi,ebx
                sub		esi,4
                sub		edi,4
                mov     ecx,pack_len
                shr     ecx,2
                std
                rep     movsd
                add		esi,4
                add		edi,4
                mov     cx,WORD PTR pack_len
                and     cx,0003h
                jcxz    unpack2
                dec		esi
                dec		edi
                rep     movsb
				inc		esi
				inc		edi
unpack2:
                cld
                mov     esi,edi
unpack3:
                mov     edi,output
                mov     bit_count,0         ; init bits in buffer
                mov     ax,[esi]
                mov     bit_buffl,ax        ; init next two bytes
                mov     al,2
                call    input_bits          ; input lock and key bits
unpack4:
                mov     edx,OFFSET raw_table
                call    make_huftable       ; create raw codes table
                mov     edx,OFFSET pos_table
                call    make_huftable       ; create offset codes table
                mov     edx,OFFSET len_table
                call    make_huftable       ; create length codes table
                mov     al,16
                call    input_bits          ; input counts
                mov     counts,ax
                jmp     unpack6
unpack5:
                mov     edx,OFFSET pos_table
                call    input_value         ; input offset
                push    cx
                mov     edx,OFFSET len_table
                call    input_value         ; input length
                add     cx,MIN_LENGTH
                xor     eax,eax
                pop     ax
                inc     ax
                mov     edx,esi
                mov     esi,edi
                sub     esi,eax
                rep     movsb               ; ds:si -> es:di
                mov     esi,edx
unpack6:
                mov     edx,OFFSET raw_table
                call    input_value         ; input count
                jcxz    unpack7            ; branch if count=0
                getrawREP
                mov     cl,bit_count
                mov     ax,[esi]
                mov     bx,ax
                rol     ax,cl
                mov     dx,1
                shl     dx,cl
                dec     dx
                and     bit_buffl,dx
                and     dx,ax
                mov     ax,[esi+2]
                shl     bx,cl
                shl     ax,cl
                or      ax,dx
                or      bit_buffl,bx
                mov     bit_buffh,ax
unpack7:
                dec     counts
                jne     unpack5             ; branch if block not done
                dec     BYTE PTR blocks
                jne     unpack4

                IF CHECKSUMS
                mov     esi,output
                mov     ecx,unpack_len
                call    crc_block
                cmp     crc_u,bx
                jne     pack_crc            ; branch if bad unpacked data CRC
                ENDIF

                mov     eax,unpack_len
                clc
                jmp     unpack_end
not_pack:
                mov     eax,NOT_PACKED
                jmp     unpack_cwd
pack_crc:
                mov     eax,PACKED_CRC
                jmp     unpack_cwd
unpack_crc:
                mov     eax,UNPACKED_CRC
unpack_cwd:
                stc
unpack_end:
                ret
UnpackM1        ENDP

;------------------------------------------------------------------------------
; read next long word from packed file converting to little endian
; on exit,
;       eax = dword
;------------------------------------------------------------------------------
read_long       PROC
                lodsd
                xchg    ah,al
                rol     eax,16
                xchg    ah,al
                ret
read_long       ENDP

;------------------------------------------------------------------------------
; input value from packed data
; on entry,
;       dx = offset to huffman table in work segment
; on exit,
;       cx = value
;------------------------------------------------------------------------------
input_value     PROC
                xchg    edx,esi
                mov     cx,bit_buffl
input_value2:
                lodsw
                mov     bx,ax
                and     bx,cx
                lodsw
                cmp     ax,bx
                jne     input_value2
                mov     cx,[esi+16*4-4]
                xchg    edx,esi
                mov     al,ch               ; code bit length
                call    input_bits
                xor     ch,ch
                cmp     cl,2
                jb      input_value3        ; branch if 0 or 1
                dec     cl
                mov     al,cl
                call    input_bits
                mov     bx,1
                shl     bx,cl
                or      ax,bx
                mov     cx,ax
input_value3:
                ret
input_value     ENDP

;------------------------------------------------------------------------------
; input data bits from the packed file
; on entry,
;       al = no. of bits to read (1-16)
; on exit,
;       ax = data bits
;------------------------------------------------------------------------------
input_bits      PROC
                push    cx
                mov     cl,al
                mov     ax,bit_buffh        ; bit_buffer (hi word)
                mov     bx,bit_buffl        ; bit buffer (lo word)
                mov     ch,bit_count        ; bit count (0-16)
                mov     dx,1
                shl     dx,cl
                dec     dx
                and     dx,bx               ; mask required bits from buffer
                push    dx                  ; return value
                sub     ch,cl               ; update no. of bits left in buffer
                jae     input_bits3         ; branch if enough bits in buffer
                add     ch,cl
input_bits2:
                xchg    cl,ch
                mov     dx,1
                shl     dx,cl
                dec     dx
                and     dx,ax
                ror     dx,cl
                shr     ax,cl
                shr     bx,cl
                or      bx,dx
                add     esi,2
                mov     ax,[esi]            ; read packed word
                xchg    cl,ch
                sub     cl,ch
                mov     ch,16
                sub     ch,cl
input_bits3:
                mov     dx,1
                shl     dx,cl
                dec     dx
                and     dx,ax
                ror     dx,cl
                shr     ax,cl
                shr     bx,cl
                or      bx,dx
                mov     bit_buffh,ax        ; bit_buffer (hi word)
                mov     bit_buffl,bx        ; bit buffer (lo word)
                mov     bit_count,ch        ; bit count
                pop     ax
                pop     cx
                ret
input_bits      ENDP

;------------------------------------------------------------------------------
; read huffman code bit lengths and create huffman code table
; on entry,
;       edx = offset of start of table in work segment
;------------------------------------------------------------------------------
make_huftable   PROC
                push    edi
                push    edx
                sub     esp,16              ; reserve space for bit lengths
                mov     edi,esp
                mov     al,5
                call    input_bits          ; read no. of codes
                xor     ecx,ecx
                mov     cx,ax
                jcxz    make_huftable7      ; branch if 0 entries
                push    ecx
make_huftable2:
                mov     al,4
                call    input_bits          ; read huffman code bit length
                mov     ss:[edi],al
                inc     edi
                loop    make_huftable2
                pop     ecx
                push    esi
                mov     esi,esp
                add     esi,4
                mov     edi,ss:[esi+16]     ; pointer to huffman table
                mov     al,1                ; init bit length
                xor     bx,bx               ; huff code
                mov     dx,8000h            ; huff base
make_huftable3:
                push    cx                  ; no. of huffman codes
                push    esi
make_huftable4:
                cmp     al,ss:[esi]
                jne     make_huftable6      ; branch if not same bit length
                push    ax
                push    bx
                push    cx
                mov     cl,al
                mov     ax,1
                shl     ax,cl
                dec     ax
                stosw                       ; code mask
                mov     al,cl
                mov     cl,16
                sub     cl,al
                shr     bx,cl
                mov     cl,al
                xor     ax,ax
make_huftable5:
                rcr     bx,1
                rcl     ax,1
                loop    make_huftable5
                stosw                       ; huffman code
                mov     eax,esi
                sub     eax,esp
                sub     ax,16               ; 4 word pushs + 2 dword pushs
                mov     ah,ss:[esi]         ; code bit length
                mov     [edi+16*4-4],ax
                pop     cx
                pop     bx
                pop     ax
                add     bx,dx               ; update huff code
make_huftable6:
                inc     esi
                loop    make_huftable4
                pop     esi
                pop     cx
                shr     dx,1
                inc     al
                cmp     al,17
                jne     make_huftable3
                pop     esi
make_huftable7:
                add     esp,16
                pop     edx
                pop     edi
                ret
make_huftable   ENDP

;------------------------------------------------------------------------------
; initialise the crc lookup table
;------------------------------------------------------------------------------
                IF CHECKSUMS
init_crc        PROC
                mov     edi,OFFSET crc_table
                xor     bx,bx
init_crc2:
                mov     ax,bx
                mov     ecx,8
init_crc3:
                shr     ax,1
                jnc     init_crc4
                xor     ax,0a001h
init_crc4:
                loop    init_crc3
                stosw
                inc     bl
                jne     init_crc2
                ret
init_crc        ENDP

;------------------------------------------------------------------------------
; calculate a 16 bit crc of a block of memory
; on entry,
;       esi = pointer to start of block
;       ecx = size of block in bytes
; on exit,
;       bx = 16 bit crc
;------------------------------------------------------------------------------
crc_block       PROC
                mov     edi,OFFSET crc_table ; pointer to crc table
                xor     ebx,ebx
crc_block2:
                lodsb                        ; read byte from block
                xor     bl,al
                mov     al,bh
                xor     bh,bh
                shl     bx,1
                mov     bx,[edi+ebx]         ; lookup crc value
                xor     bl,al
                loop    crc_block2
                ret
crc_block       ENDP
                ENDIF

end32code

                END


