; Sound Cartridge RAM Tester v0.6 by GDX


#include "MAIN-ROM.ASM"
#include "SYS-VAR.ASM"

CR	equ	0Dh
LF	equ	0Ah

	org	0100h

	jp	START

TITLE_TXT:
	db	"Sound Cartridge RAM Tester v0.6",LF,CR,LF,"$",0
Prim_SLT:
	db	0	; Current primary slot number
Sec_SLT:
	db	1	; Current secondary slot number
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
	call	SCCDetect
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
	jr	z,PrimSLT
	
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

PrimSLT:
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
	ld	(05000h),a	; Select the segment 0 at page 4000h-5FFFh

	ld	a,3
	ld	(0B000h),a	; Select the segment 0 at page A000h-BFFFh

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
; SCC+ detection routine by gdx
; Input: None
; Output: A = SCC Slot ID if found else 0
;	  F = Carry is 0 if SCC found else 1
;	  Page 8000h-BFFFh = First SCC+ found slot or random slot if SCC not found
; Changes: All registers
;------------------------------------------

SCCDetect:
	call	Slt_Num_conv
	ld	c,a		; C = Current slot number
	jr	nz,SltPrim	; Jump if not primary slot
	ld	a,3
	ld	(Sec_SLT),a	; Sec_SLT =3 if primary slot to skip secondary slots
SltPrim:
	ld	a,c
	call	CHK_SLT
	ld	a,c		; A = Current slot number
	ret	nc		; Back if SCC+ found

	ld	a,(Sec_SLT)
	inc	a
	and	3		; Sec_SLT = 0~3 only
	ld	(Sec_SLT),a
	jr	nz,SCCDetect	; Jump if Sec_SLT = 0

	cp	3
	ld	a,(Prim_SLT)
	jr	nz,ContIfnot3	; Jump if Sec_SLT <> 3
	cp	3
	jr	z,SCCDetectEnd
ContIfnot3:
	inc	a
	ld	(Prim_SLT),a
	jp	SCCDetect	; Jump if all slots are not scanned
SCCDetectEnd:
	xor	a
	scf
	ret
	
CHK_SLT:
	push	bc
	
	ld	h,080h
	call	ENASLT

	ld	a,020h
	ld	(0BFFEh),a	; Set ROM mode for all page & SCC+ mode
	
	ld	hl,0AFFFh
	ld	d,(hl)
	ld	a,d		; Store the value
	cpl
	ld	(hl),a
	ld	a,(hl)
	cp	d
	jr	nz,SCCpNotFnd	; Jump if the read value remains the same

	ld	hl,0B800h
	ld	e,(hl)
	ld	a,e		; Store the value
	cpl
	ld	(hl),a
	ld	a,(hl)
	jr	nz,SCCpNotFnd	; Jump if the read value remains the same

	ld	a,080h
	ld	(0B000h),a	; Enable the SCC+ registers

	ld	a,255
	ld	(hl),a
	ld	a,(hl)
	cp	255
	jr	nz,SCCpNotFnd	; Jump if the read value is not 255
	inc	a
	ld	(hl),a
	ld	a,(hl)
	or	a	
	jr	nz,SCCpNotFnd	; Jump if the read value is not 0

	xor	a
	jr	SCRCH_End
SCCpNotFnd:
	scf
SCRCH_End:
	ld	a,d
	ld	(0AFFFh),a
	ld	(hl),e
	pop	bc
	ret
	
; Convert Prim_SLT and Sec_SLT values to slot number format
; Entry: Prim_SLT, Sec_SLT
; Output: A = Slot number (FxxxPPSS)
; Modify: A, BC, HL

Slt_Num_conv:
	ld	a,(Prim_SLT)
	ld	c,a
	ld	b,0
	ld	hl,EXPTBL
	add	hl,bc
	ld	a,(hl)
	and	80h
	ld	a,c
	ret	z		; Back if primary slot

	ld	a,(Sec_SLT)
	rlca
	rlca
	or	c
	or	080h
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