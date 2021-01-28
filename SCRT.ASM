; Sound Cartridge RAM Tester v0.5 by GDX


#include "MAIN-ROM.ASM"
#include "SYS-VAR.ASM"

CR	equ	0Dh
LF	equ	0Ah

	org	0100h

	jp	START

TITLE_TXT:
	db	"Sound Cartridge RAM Tester v0.5",LF,CR,LF,"$",0
SCC_SLT:
	db	0	; Slot ID of the SCC
NUM_OF_SEG:
	db	0	; Number of segment to check
SegNum:
	dw	0	; Page number
RowNumber:
	db	0	; Row number
START:
	ld	de,TITLE_TXT
	call	PRINT

	ld	c,053h		; "S"
	call	Param_Srch
	jr	nz,No_ParamS

	inc	hl
	ld	a,(hl)
	and	0FCh
	cp	30h
	jp	nz,Bad_Param	; Jump if the parmeter < 0 or > 3
	ld	a,(hl)
	and	3
	ld	b,a		; Store the primary slot number to B
	inc	hl
	ld	a,(hl)
	cp	02Dh		;"-"
	ld	a,b
	ld	(SCC_SLT),a
	jr	nz,NotSec_SLT
	inc	hl
	ld	a,(hl)
	and	0FCh
	cp	30h
	jp	nz,Bad_Param	; Jump if the parmeter < 0 or > 3
	ld	a,(hl)
	and	3
	rlca
	rlca
	or	80h
	or	b
	ld	(SCC_SLT),a	
NotSec_SLT:
	push	af
	ld	de,SEL_SLT_TXT
	call	PRINT
	pop	af

	jr	Slot_OK

No_ParamS:
	call	SCCDETECT
	jp	c,NO_SCC
	ld	(SCC_SLT),a	

	push	af
	ld	de,SCC_SLT_TXT
	call	PRINT
	pop	af
Slot_OK:
	and	3
	add	a,030h
	ld	e,a
	ld	c,2	; Print a character (primary slot number)
	call	BDOS

	ld	a,(SCC_SLT)	
	and	80h
	jr	z,Prim_SLT
	
	ld	e,"-"
	ld	c,2	; Print a character
	call	BDOS

	ld	a,(SCC_SLT)
	and	0ch
	rrca
	rrca
	add	a,030h
	ld	e,a
	ld	c,2	; Print a character (secondary slot number)
	call	BDOS

Prim_SLT:
	ld	de,CHK_RAM_TXT
	call	PRINT

	ld	a,(SCC_SLT)
	ld	h,040h
	call	ENASLT		; Select the SCC slot at page 4000h-7FFFh
	ld	a,(SCC_SLT)
	ld	h,080h
	call	ENASLT		; Select the SCC slot at page 8000h-BFFFh

;
; Write the segment number in all the RAM of the corresponding segment
;
	di
	ld	a,255
	ld	(SegNum),a
SEG_INIT_LP:
	xor	a
	ld	(0bffeh),a	; ROM mode
	ld	a,(SegNum)
	ld	(05000h),a	; Select a segment at page 4000h-5FFFh
	ld	a,001h
	ld	(0bffeh),a	; RAM mode for the page 4000h-5FFFh

	ld	a,(SegNum)
	ld	hl,04000h
	ld	de,04000h+1
	ld	bc,01FFFh
	ld	(hl),a
	ldir

	dec	a
	ld	(SegNum),a
	cp	255
	jr	nz,SEG_INIT_LP

;
; Compare the segment number with ther RAM content
;
	ld	de,Horz0123_TXT
	call	PRINT
	ld	a,(SCC_SLT)
	ld	h,040h
	call	ENASLT		; Select the SCC slot at page 4000h-7FFFh

	xor	a
	ld	(SegNum),a
ROW_TST_LP:
	ld	a,(RowNumber)
	add	a,030h
	cp	03Ah
	jr	c,HEXA	; Jump if A < "A"
	add	a,7
HEXA:
	call	CharPrint	; Row number
SEG_TST_LP:
	xor	a		; ROM mode
	ld	(0bffeh),a
	ld	a,(SegNum)
	ld	(05000h),a	; Select a segment at page 4000h-5FFFh
	ld	a,001h
	ld	(0bffeh),a	; RAM mode for the page 4000h-5FFFh

	ld	hl,04000h
	ld	bc,02000h
	ld	a,(SegNum)
ByteTST_LP:
	cpi
	jr	nz,Byte_Wrong	; Jump A <> (HL)
	jp	pe,ByteTST_LP	; Jump if BC <> 0

	ld	a,"O"
	call	CharPrint

	jp	NextSEG

Byte_Wrong:
	ld	a,"X"
	call	CharPrint

NextSEG:
	ld	a,(SegNum)
	and	0Fh
	cp	15
	jr	nz,NoRET	; Jump if A = 15

	ld	a,(RowNumber)
	inc	a
	ld	(RowNumber),a

	ld	a,(SegNum)
	inc	a
	ld	(SegNum),a
	or	a
	jr	z,RAM_TST_OK	; Jump if SegNum = 255

	ld	a,LF
	call	CharPrint
	ld	a,CR
	call	CharPrint

	jp	ROW_TST_LP
NoRET:
	ld	a,(SegNum)
	inc	a
	ld	(SegNum),a
	jp	SEG_TST_LP

RAM_TST_OK:

; Fill the last segment RAM with 55h

	xor	a
	ld	(0bffeh),a	; ROM mode
	ld	a,0FFh
	ld	(05000h),a	; Select the segment 0FFh at page 4000h-5FFFh
	ld	a,001h
	ld	(0bffeh),a	; RAM mode for the page 4000h-5FFFh

	ld	hl,04000h
	ld	de,04000h+1
	ld	bc,01FFFh
	ld	(hl),055h
	ldir

; Check the last segment RAM content

	ld	hl,04000h
	ld	bc,02000h
	ld	a,055h
ByteTST_LLP:
	cpi
	jr	nz,LST_Seg_Wrong	; Jump A <> (HL)
	jp	pe,ByteTST_LLP	; Jump if BC <> 0
	jr	LST_Seg_Checked
LST_Seg_Wrong:
	ld	a,8		; BS (To write "X" over the "O" if present)
	call	CharPrint
	ld	a,"X"
	call	CharPrint
LST_Seg_Checked:
	ei
	ld	a,LF
	call	CharPrint
	ld	a,CR
	call	CharPrint

	xor	a
	ld	(0bffeh),a	; SCC mode
	ld	(04000h),a	; Select the segment 0 at page 4000h-5FFFh

	ld	a,(RAMAD1)
	ld	h,040h
	call	ENASLT		; Select the RAM slot at page 4000h-7FFFh
	ld	a,(RAMAD2)
	ld	h,080h
	call	ENASLT		; Select the RAM slot at page 8000h-BFFFh

	ld	de,COMPLETED_TXT
	call	PRINT

	rst	0

NO_SCC:
	ld	a,(RAMAD1)
	ld	h,040h
	call	ENASLT		; Select the RAM slot at page 4000h-7FFFh
	ld	a,(RAMAD2)
	ld	h,080h
	call	ENASLT		; Select the RAM slot at page 8000h-BFFFh

	ld	de,NOT_FND_TXT
	call	PRINT
	rst	0	; Back to the DOS

PRINT:
	ld	c,9	; Print a string
	jp	BDOS

Bad_Param:
	ld	de,Bad_Param_TXT
	call	PRINT
	rst	0	; Back to the DOS

;------------------------------------------
; SCC+ detection routine by NYYRIKKI & GDX
; Input: None
; Output: A = SCC+ Slot ID if found else 0
;	  C = 0 if SCC+ found else 1
;	  Page 8000h-BFFFh = SCC+ slot or random slot if SCC not found
; Changes: All registers
;------------------------------------------

SCCDETECT:
	ld	d,0ffh
	ld	hl,EXPTBL
MAIN_LP:
	inc	d
	ld	a,4
	cp	d
	scf
	ret	z
	
	ld	a,(hl)
	inc	hl
	and	080h
	jr	z,MAIN_TST
	call	SUBTST
	jr	c,MAIN_LP
	ret
MAIN_TST:
	ld	a,d
	call	CHK_SLT
	jr	c,MAIN_LP
	ld	a,d
	ret
;-----------------------
SUBTST:
	ld	e,0fch
SUBTST_LP:
	ld	a,4
	add	a,e
	cp	16
	scf
	ret	z
	ld	e,a
	or	d
	or	080h
	ld	c,a
	call	CHK_SLT
	jr	c,SUBTST_LP
	ld	a,c
	ret
CHK_SLT:
	push	bc
	push	de
	push	hl
	
	ld	h,080h
	call	ENASLT

	ld	a,020h
	ld	(0bffeh),a	; Set ROM mode for all page & SCC+ mode
	
	ld	a,(0B000h)
	ld	d,a
	ld	a,082h
	ld	(0B000h),a
	ld	hl,0B800h
	ld	e,(hl)
	xor	a
	ld	(hl),a
	ld	a,(hl)
	or	a
	jr	nz,NoSCC
	dec	a
	ld	(hl),a
	ld	a,(hl)
	inc	a
	jr	nz,NoSCC
	ld	a,(0B000h)
	cp	082h
	jr	z,NoSCC
	xor	a
	jr	EXIT_TST
NoSCC:
	ld	(hl),e
	ld	a,d
	ld	(0B000h),a
	scf
EXIT_TST:
	pop	hl
	pop	de
	pop	bc
	ret

; Print a character and restore the SCC slot at page 4000h-7FFFh
; Input: A = Character code

CharPrint:
	push	hl
	push	de
	push	bc
	ld	e,a
	ld	c,2	; Print a character
	call	BDOS

	ld	a,(SCC_SLT)
	ld	h,040h
	call	ENASLT		; Select the SCC slot at page 4000h-7FFFh

	pop	bc
	pop	de
	pop	hl
	ret

; -- Parameter search routine
; Entry: C = Character used as option (A~Z or a~z)
; Output: F = NZ if Parameter not found
; Modify: AF, BC, HL

Param_Srch:
	ld	a,c
	or	020h		; Upper case
	ld	c,a
	ld	hl,DMA
	ld	b,(hl)
	inc	b
ParamBCL:
	inc	hl
	ld	a,(hl)
	cp	02Fh		; Seek '/' character
	jr	nz,SLSH_NTFND	; Jump if '/' is not found
	inc	hl
	ld	a,(hl)
	or	020h		; Upper case
	cp	c		; Compare found character with the input character
	ret	z		; Back if character is found
SLSH_NTFND:
	djnz	ParamBCL
	ret

SEL_SLT_TXT:
	db	"Selected slot is $"
SCC_SLT_TXT:
	db	"SCC+ cartridge is in slot $"
NOT_FND_TXT:
	db	"SCC+ cartridge not found.$"
Bad_Param_TXT:
	db	"Bad parameter!",LF,CR,"$"
CHK_RAM_TXT:
	db	LF,CR,"SCC+ RAM checking...",LF,CR,"$"
COMPLETED_TXT:
	db	"Test completed. X=Bad segment",LF,CR,"$"
Horz0123_TXT:
	db	" 0123456789ABCDEF",LF,CR,"$"