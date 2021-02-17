; Labels of variables and area work system

; BASIC interpreter

AUTFLG	equ	0F6AAh		; Mode flag for AUTO
AUTINC	equ	0F6ADh		; Line incremention for AUTO
AUTLIN	equ	0F6ABh		; Current line number for AUTO
BASROM	equ	0FBB1h		; BASIC program in ROM flag
CONLO	equ	0F66Ah		; Value of constant stored by the CHRGTR routine
CONSAV	equ	0F668h		; Token of constant stored by the CHRGTR routine
CONTXT	equ	0F666h		; Temporary save of the text pointer by the CHRGTR routine
CONTYP	equ	0F669h		; Type of constant stored used by the CHRGTR routine
DONUM	equ	0F665h		; Flag for the number encoding after GOTO, GOSUB and THEN
DORES	equ	0F664h		; Flag that indicates if stored keyword can be tokenized or not
DOT	equ	0F6B5h		; Current line number displayed by LIST
ENDFOR	equ	0F6A1h		; Next address of the instruction FOR
ENDPRG	equ	0F40Fh		; Contains the codes of program line end or to resume when ON ERROR GOTO is used (5 bytes)
ENSTOP	equ	0FBB0h		; Flag to resume execution of a BASIC program
ERRFLG	equ	0F414h		; Number of the last error occurred in BASIC
ERRLIN	equ	0F6B3h		; Line number where last error in BASIC
ERRTXT	equ	0F6B7h		; Pointer to the error message
INTCNT	equ	0FCA2h		; Decreasing counter of the ON INTERVAL = x GOSUB instruction 
INTFLG	equ	0FC9Bh		; Interrupt flag 
INTVAL	equ	0FCA0h		; Value of the interval of the BASIC ON INTERVAL = x GOSUB instruction 
OLDLIN	equ	0F6BEh		; Current line number when the execution of STOP or END instruction, or by pressing CTRL+STOP
OLDTXT	equ	0F6C0h		; Old text pointer of the interpreter
ONEFLG	equ	0F6BBh		; Error flag for the ON ERROR GOTO instruction
ONELIN	equ	0F6B9h		; Line number defined by the ON ERROR GOTO instruction
ONGSBF	equ	0FBD8h		; Flag for the BASIC ON KEY/STOP/SPRITE/STRIG/INTERVAL GOSUB instructions
OPRTYP	equ	0F664h		; Operator type (See also DORES)
PTRFLG	equ	0F6A9h		; Line number to convert to pointer flag
REQSTP	equ	0FC6Ah		; Flag for for STOP trap (same as TRPTBL+30)
RNDX	equ	0F857h		; Last random number generated
RTYCNT	equ	0FC9Ah		; Used internally by BASIC for the interrupt control
RUNBNF	equ	0FCBEh		; Flag for the BLOAD instruction
SAVSTK	equ	0F6B1h		; Saving of the stack address when an error so that the RESUME instruction since restart a BASIC program
SAVTXT	equ	0F6AFh		; Saving of the text pointer during an error for the RESUME instruction
SAVVOL	equ	0FB39h		; Saving the sound volume of the 3 PSG voices during a pause (stop)
SUBFLG	equ	0F6A5h		; Flag for an table of the DEFUSR instruction 
SWPTMP	equ	0F7BCh		; Current first operand used in the SWAP instruction
TEMP	equ	0F6A7h		; Temporary storage for FOR ~ NEXT, INPUT, LET and ^C
TEMP2	equ	0F6BCh		; Temporary storage for the formula evaluation routine 
TEMP3	equ	0F69Dh		; Temporary storage used for garbage collector or by USR function
TEMP8	equ	0F69Fh		; Temporary storage used for garbage collector
TEMP9	equ	0F7B9h		; Temporary pointer of the garbage collector
TEMPPT	equ	0F678h		; Temporary descriptor pointer of the Basic
TEMPST	equ	0F67Ah		; Temporary storage area to store string descriptors
TRCFLG	equ	0F7C4h		; Tracing flag for the TRON/TROFF instructions
TRPTBL	equ	0FC4Ch		; Table for ON KEY/STOP/SPRITE/STRIG/INTERVAL GOSUB instructionS
TTYPOS	equ	0F661h		; Virtual cursor position used internally by PRINT instruction
VLZADR	equ	0F419h		; Address of the character replaced by the VAL instruction.
VLZDAT	equ	0F41Bh		; Character replaced by the VAL instruction

; Controlers

PADX	equ	0FC9Dh		; X-coordinate from paddle controller
PADY	equ	0FC9Ch		; Y-coordinate from paddle controller
XSAVE	equ	0FAFEh		; X-coordinate for Mouse/Trackball/Lightpen (MSX2~)
YSAVE	equ	0FB00h		; Y-coordinate for Mouse/Trackball/Lightpen (MSX2~)

; Data recorder (see also CASPRV)

CS120	equ	0F3FCh		; Work area for the data recorder
CS240	equ	0F3FCh		; Work area for the data recorder
HEADER	equ	0F40Ah		; Settings for the tape player 
HIGH	equ	0F408h		; Settings for the data recorder signal
LOW	equ	0F406h		; Settings for the data recorder signal
LOWLIM	equ	0FCA4h		; Duration of the LO/HI cycle
WINWID	equ	0FCA5h		; Minimum allowable start bit duration

; Disk driver

BREAKV	equ	0F325h		; Routine address for the CTRL+C handler
DEVICE	equ	0FD99h		; Flag to know if the SHIFT key was pressed at startup
DRVINF	equ	0FB21h		; Number of physical disk controlled by each interface and slot number of its Disk-ROM 
DRVINT	equ	0FB29h		; Slot number and address of each interrupt handler on the disk interfaces
HIMSAV	equ	0F349h		; Work area address for the Disk-ROM
MASTERS	equ	0F348h		; Slot number of the master Disk-ROM
NMBDRV	equ	0F347h		; Number of connected logical drives (0~7)
RAMAD0	equ	0F341h		; Main RAM slot number for the page 0000h~3FFFh
RAMAD1	equ	0F342h		; Main RAM slot number for the page 4000h~7FFFh
RAMAD2	equ	0F343h		; Main RAM slot number for the page 8000h~BFFFh
RAMAD3	equ	0F344h		; Main RAM slot number for the page C0000h~FFFFh
ROMBDOS	equ	0F37Dh		; Call to BDOS routine from the Disk-BASIC environment

; Displaying

ACPAGE	equ	0FAF6h		; Destination page number (MSX2~)
ARG	equ	0F847h		; Argument (16 bytes)
ASPCT1	equ	0F40Bh		; 256/aspect ratio for CIRCLE
ASPCT2	equ	0F40Dh		; 256*aspect ratio for CIRCLE
ASPECT	equ	0F931h		; Aspect ratio of the circle for CIRCLE
ATRBAS	equ	0F928h		; Current sprite attribute table address
ATRBYT	equ	0F3F2h		; Tracing attribute (Plot color)
BAKCLR	equ	0F3EAh		; Background color
BDRCLR	equ	0F3EBh		; Border color
BRDATR	equ	0FCB2h		; Border color of PAINT
CENCNT	equ	0F933h		; Counter used by CIRCLE
CGPBAS	equ	0F924h		; Current pattern generator table address
CGPNT	equ	0F91Fh		; Current character font location (3 bytes)
CLINEF	equ	0F935h		; Flag to draw line to circle center
CLMLST	equ	0F3B2h		; Value (LINLEN-(LINLEN MOD 14)-14) used by PRINT
CLOC	equ	0F92Ah		; Cursor location
CMASK	equ	0F92Ch		; Graphic cursor mask or ordinate
CNPNTS	equ	0F936h		; Point to be plottted
CNSDFG	equ	0F3DEh		; Flag for function keys display
CODSAV	equ	0FBCCh		; Character code under the cursor
CPCNT	equ	0F939h		; Number of points in 1/8 of circle
CPCNT8	equ	0F93Bh		; Number of points in the circle
CPLOTF	equ	0F938h		; Plot polarity flag for CIRCLE
CRCSUM	equ	0F93Dh		; CRC Sum of the circle
CRTCNT	equ	0F3B1h		; Number of lines of current text screen
CSAVEM	equ	0F944h		; Mask of the first pixel of different color for PAINT
CSCLXY	equ	0F941h		; Scale of X & Y for CIRCLE
CSRSW	equ	0FCA9h		; Cursor display switch
CSRX	equ	0F3DDh		; X-coordinate of text cursor
CSRY	equ	0F3DCh		; Y-coordinate of text cursor
CSTCNT	equ	0F93Fh		; Number of points of the starting angle for CIRCLE
CSTYLE	equ	0FCAAh		; Cursor style flag
CURLIN	equ	0F41Ch		; Current execution line number of BASIC program
CXOFF	equ	0F945h		; X offset from center for PAINT
CYOFF	equ	0F947h		; Y offset from center for PAINT
CSAVEA	equ	0F942h		; Address of the first pixel of different color for PAINT
DPPAGE	equ	0FAF5h		; Displayed page number (MSX2~)
DRWANG	equ	0FCBDh		; Parameter for DRAW rotation
DRWFLG	equ	0FCBBh		; DRAW flag
DRWSCL	equ	0FCBCh		; Parameter for DRAW scaling
DSCPTR	equ	0F699h		; Pointer to the "Ok" message
DSCTMP	equ	0F698h		; Length and position of the "Ok" message
FNKSTR	equ	0F87Fh		; Contains the function key characters to display
FNKSWI	equ	0FBCDh		; Flag to indicate whether displayed function keys are F1-F5 or F6-F10
FORCLR	equ	0F3E9h		; Draw/Text color
GRPACX	equ	0FCB7h		; X-coordinate for the graphic print
GRPACY	equ	0FCB9h		; Y-coordinate for the graphic print
GRPATR	equ	0F3CDh		; SCREEN 2 sprite attribute table address
GRPCGP	equ	0F3CBh		; SCREEN 2 pattern generator table address
GRPCOL	equ	0F3C9h		; SCREEN 2 color table address
GRPHED	equ	0FCA6h		; Heading for the output of graphic characters
GRPNAM	equ	0F3C7h		; SCREEN 2 pattern name table address
GRPPAT	equ	0F3CFh		; SCREEN 2 sprite generator table address
GXPOS	equ	0FCB3h		; Graphic cursor abscissa
GYPOS	equ	0FCB5h		; Graphic cursor ordinate
LFPROG	equ	0F954h		; Set to 1 when the filling of the BASIC PAINT instruction progresses to the left
LINL32	equ	0F3AFh		; Columns number in SCREEN 1
LINL40	equ	0F3AEh		; Columns number in SCREEN 0
LINLEN	equ	0F3B0h		; Columns number in current text screen 
LINTTB	equ	0FBB2h		; Table of 24 flags for each displayed line at screen
LINWRK	equ	0FC18h		; Work area to display the line of function keys
LOGOPR	equ	0FB02h		; Logical operator to perform when drawing or graphic copy
LOHADR	equ	0F94Bh		; Leftmost position of an LH (PAINT instruction)
LOHCNT	equ	0F94Dh		; Size of a LH excursion (PAINT instruction)
LOHDIR	equ	0F94Ah		; New paint direction required by an LH excursion (PAINT instruction)
LOHMSK	equ	0F949h		; Leftmost position of an LH excursion (PAINT instruction)
MAXDEL	equ	0F92Fh		; End of work area for the graphic routines
MAXUPD	equ	0F3ECh		; Work area for CIRCLE instruction
MINDEL	equ	0F92Dh		; Work area for the graphic routines
MINUPD	equ	0F3EFh		; Work area for CIRCLE instruction
MLTATR	equ	0F3D7h		; SCREEN 3 sprite attribute table address
MLTCGP	equ	0F3D5h		; SCREEN 3 pattern generator table address
MLTCOL	equ	0F3D3h		; SCREEN 3 color table address
MLTNAM	equ	0F3D1h		; SCREEN 3 pattern name tabte address
MLTPAT	equ	0F3D9h		; SCREEN 3 sprite generator table address
MODE	equ	0FAFCh		; Current screen mode
MOVCNT	equ	0F951h		; Number of movements returned by the filling routine of the PAINT instruction
NAMBAS	equ	0F922h		; Address of the current character table or Bitmap in VRAM
OLDSCR	equ	0FCB0h		; Text screen mode used before switching to a graphic mode
PATBAS	equ	0F926h		; Address of the current sprite generator table in VRAM
PATWRK	equ	0FC40h		; Character returned by the Main-Rom routine GETPAT (00105h)
PDIREC	equ	0F953h		; Direction in which the work instruction PAINT 
RTPROG	equ	0F955h		; Progression to the right of the filling by PAINT instruction of Basic 
SCRMOD	equ	0FCAFh		; Current screen mode
SKPCNT	equ	0F94Fh		; Number of skips returned by the filling routine of the Basic's PAINT instruction
T32ATR	equ	0F3C3h		; SCREEN 1 sprite attribute table address
T32CGP	equ	0F3C1h		; SCREEN 1 pattern generator table address
T32COL	equ	0F3BFh		; SCREEN 1 color table address
T32NAM	equ	0F3BDh		; SCREEN 1 pattern name table address
T32PAT	equ	0F3C5h		; SCREEN 1 sprite generator table address
TXTATR	equ	0F3B9h		; Unused
TXTCGP	equ	0F3B7h		; SCREEN 0 pattern generator table address
TXTCOL	equ	0F3B5h		; SCREEN 0 color table address
TXTNAM	equ	0F3B3h		; SCREEN 0 pattern name tabte address
TXTPAT	equ	0F3BBh		; Unused
TXTTAB	equ	0F676h		; Start address of the BASIC program to load

; Files (Data recorder, BASIC interpreter, Disk BASIC, etc)

FILNAM	equ	0F866h		; File name (6 or 11 bytes)
FILNM2	equ	0F871h		; Second file name (11 bytes)
FILTAB	equ	0F860h		; File data address
FLBMEM	equ	0FCAEh		; Loading flag: 0 if a BASIC program is loading
FLGINP	equ	0F6A6h		; Data address of the selected file
MAXFIL	equ	0F85Fh		; Maximum number of files allowed
NLONLY	equ	0F87Ch		; Flag other than 0 when loading a program
NULBUF	equ	0F862h		; Address of the Disk-BASIC SAVE and LOAD instructions
SAVEND	equ	0F87Dh		; End address specified by the BSAVE instruction of BASIC
SAVENT	equ	0FCBFh		; Start address specified by the BSAVE instruction of BASIC
PTRFIL	equ	0F864h		; Data address of the selected file 
RSFCB	equ	0FB04h		; Address of the FCB (File Control Block) of the RS-232C. 
RUNFLG	equ	0F866h		; Execution flag for the LOAD instruction

; Keyboard and controllers triggers

BUFMIN	equ	0F55Dh		; Work area for INPUT
CAPST	equ	0FCABh		; CAPS key status
BUF	equ	0F55Eh		; Buffer to store characters displayed to screen under BASIC in direct mode (258 bytes)
CHRCNT	equ	0FAF9h		; Character counter in the Roma-Kana cache. (MSX2~)
CLIKFL	equ	0FBD9h		; Flag to know if the click has already occurred
CLIKSW	equ	0F3DBh		; Key click switch
ENDBUF	equ	0F660h		; Flag to prevent overflow of BUF
ESCCNT	equ	0FCA7h		; Escape sequence counter used by the CHPUT routine
FSTPOS	equ	0FBCAh		; First character address entered by the INLIN (00B1h) and QINLIN (00B4h) routines
GETPNT	equ	0F3FAh		; Address of the first character code of the current line in the KEYBUF cache
INSFLG	equ	0FCA8h		; Insertion mode flag
KANAMD	equ	0FCADh		; Flag to indicate if the keyboard is Kana or JIS type
KANAST	equ	0FCACh		; Kana mode flag
KBFMIN	equ	0F41Eh		; Flag to indicate if a direct declaration error occurs
KBUF	equ	0F41Fh		; Crunch Buffer
KEYBUF	equ	0FBF0h		; Default keyboard buffer 
NEWKEY	equ	0FBE5h		; New status of each row of the keyboard matrix
OLDKEY	equ	0FBDAh		; Previous status of each row of the keyboard matrix
PUTPNT	equ	0F3F8h		; Address of the first free location in the KEYBUF cache
REPCNT	equ	0F3F7h		; Key repetition counter
ROMA	equ	0FAFAh		; Characters in the buffer used for Romaji-Kana conversion
SCNCNT	equ	0F3F6h		; Counter for the interval between two keyboard scans
SFTKEY	equ	0FBEBh		; Same as NEWKEY+6 (GRAPH, CTRL,SHIFT)
TRGFLG	equ	0F3E8h		; Status of controllers triggers and the space key

; Macro language

MCLFLG	equ	0F958h		; Flag to indicate if the current macro language conversion table is for DRAW or PLAY instruction
MCLLEN	equ	0FB3Bh		; Length of the macro being analyzed
MCLPTR	equ	0FB3Ch		; Address of the macro being analyzed
MCLTAB	equ	0F956h		; Address of the current macro language conversion table for DRAW or PLAY instruction 

; Math and BASIC variables

ARYTA2	equ	0F7B5h		; End point of array variable search
ARYTAB	equ	0F6C4h		; Array variables area address
DAC	equ	0F7F6h		; Decimal accumulator
DATLIN	equ	0F6A3h		; Current line number of DATA
DATPTR	equ	0F6C8h		; Pointer to next data to read with READ
DECCNT	equ	0F7F4h		; Work area for divisions
DECTMP	equ	0F7F0h		; Work area to convert decimal integer to floating point number
DECTM2	equ	0F7F2h		; Work area for divisions
DEFTBL	equ	0F6CAh		; Type table of BASIC variables (26 bytes)
DIMFLG	equ	0F662h		; Array flag for DIM
FACLO	equ	0F7F8h		; Interer value or string location in the DAC
FBUFFR	equ	0F7C5h		; Buffer of mathematical routines
FNKFLG	equ	0FBCEh		; Ten flags for BASIC's KEY (x) ON/OFF/STOP instruction 
FRETOP	equ	0F69Bh		; End address of the character string table
HOLD	equ	0F83Eh		; Work area for performing digital operators
HOLD2	equ	0F836h		; Work area for performing digital operators
HOLD8	equ	0F806h		; Work area for the decimal multiplication 
JIFFY	equ	0FC9Eh		; Increasing counter of the TIME instruction
STREND	equ	0F6C6h		; End address of the BASIC's variables area
VALTYP	equ	0F663h		; Variable type that is currently in DAC
VARTAB	equ	0F6C2h		; Address of the BASIC's variables area 

; Memory

BOTTOM	equ	0FC48h		; Address of the available area under BASIC
CLPRIM	equ	0F3B2h		; Call primary slot routine (14 bytes)
EXBRSA	equ	0FAF8h		; Slot number of SUB-ROM (MSX2~)
EXPTBL	equ	0FCC1h		; Extended slot flags table (4 bytes)
HIMEM	equ	0FC4Ah		; Address of the end of the free RAM area 
MEMSIZ	equ	0F672h		; Address of the end area available under BASIC
MINROM	equ	0FCC1h		; Main-Rom slot number (Don't use this variable)
MNROM	equ	0FCC1h		; Main-Rom slot number
RDPRIM	equ	0F380h		; Read from primary slot routine (5 bytes)
SSLTSL	equ	0FFFFh		; Access address to the secondary slot selection register
SLTATR	equ	0FCC9h		; Table containing the attributes of each Slot 
SLTTBL	equ	0FCC5h		; Current secondary slot table (4 bytes)
SLTWRK	equ	0FD09h		; Table to reserve a RAM work area for ROM applications
STKTOP	equ	0F674h		; End address of the area reserved for the stack
WRPRIM	equ	0F385h		; Write to primary slot routine (7 bytes)

; MSX-DOS

BDOS	equ	0005h		; Call to MSX-DOS functions
DMA	equ	00080h		; Command parameters

; PLAY instruction and the STRTMS routine

FRCNEW	equ	0F3F5h		; Working area size for PLAY instruction
MUSICF	equ	0FB3Fh		; Musical interruption flag
PLYCNT	equ	0FB40h		; Number of macro strings in the PLAY queue 
PRSCNT	equ	0FB35h		; Work area for the PLAY instruction
SAVSP	equ	0FB36h		; Last contents of the SP register saved by PLAY instruction
VCBA	equ	0FB41h		; Area used by the routine STRTMS for the voice 1
VCBB	equ	0FB66h		; Area used by the routine STRTMS for the voice 2
VCBC	equ	0FB8Bh		; Area used by the routine STRTMS for the voice 3
VOICAQ	equ	0F975h		; Queue for the voice 1 of the PLAY instruction
VOICBQ	equ	0F9F5h		; Queue for the voice 2 of the PLAY instruction
VOICBC	equ	0FA75h		; Queue for the voice 3 of the PLAY instruction
VOICEN	equ	0FB38h		; Number of voices currently played by the PLAY instruction

; Printer

LPTPOS	equ	0F415h		; Position of the printer head
NTMSXP	equ	0F417h		; Printer type flag
RAWPRT	equ	0F418h		; Raw print flag

; RS-232C

RSIQLN	equ	0FB06h		; Temporary data used by the RS-232C interface 
RS2IQ	equ	0FAF5h		; RS-232C queue (Removed from the standard from MSX2) 
TOCNT	equ	0FB03h		; Counter used internally by RS-232C routine

; User's function parameters

FUNACT	equ	0F7BAh		; Number of active functions
NOFUNS	equ	0F7B7h		; Flag to know functions have been defined or not by the FN instruction
PARM1	equ	0F6E8h		; Definition of parameters of the FN instruction
PARM2	equ	0F750h		; Zone to save the blocks being created by the FN instruction
PRMLEN	equ	0F6E6h		; Length of the parameters in PARM1 of the FN instruction
PRMLN2	equ	0F74Eh		; Length of the parameters in PARM2 of the FN instruction
PRMPRV	equ	0F74Ch		; Address of the previous parameters of the FN instruction
PRMSTK	equ	0F6E4h		; Address of the previous parameters on the stack of the FN instruction
PRMFLG	equ	0F7B4h		; Flag to know if a search in PARM1 is in progress

; VDP registers backup

RG0SAV	equ	0F3DFh		; VDP register 0 content
RG1SAV	equ	0F3E0h		; VDP register 1 content
RG2SAV	equ	0F3E1h		; VDP register 2 content
RG3SAV	equ	0F3E2h		; VDP register 3 content
RG4SAV	equ	0F3E3h		; VDP register 4 content
RG5SAV	equ	0F3E4h		; VDP register 5 content
RG6SAV	equ	0F3E5h		; VDP register 6 content
RG7SAV	equ	0F3E6h		; VDP register 7 content
RG8SAV	equ	0F3E7h		; VDP register 8 content (MSX2~)
RG9SAV	equ	0F3E8h		; VDP register 9 content (MSX2~)
RG10SAV	equ	0F3E9h		; VDP register 10 content (MSX2~)
RG11SAV	equ	0F3EAh		; VDP register 11 content (MSX2~)
RG12SAV	equ	0F3EBh		; VDP register 12 content (MSX2~)
RG13SAV	equ	0F3ECh		; VDP register 13 content (MSX2~)
RG14SAV	equ	0F3EDh		; VDP register 14 content (MSX2~)
RG15SAV	equ	0F3EEh		; VDP register 15 content (MSX2~)
RG16SAV	equ	0F3EFh		; VDP register 16 content (MSX2~)
RG17SAV	equ	0FFF0h		; VDP register 17 content (MSX2~)
RG18SAV	equ	0FFF1h		; VDP register 18 content (MSX2~)
RG19SAV	equ	0FFF2h		; VDP register 19 content (MSX2~)
RG20SAV	equ	0FFF3h		; VDP register 20 content (MSX2~)
RG21SAV	equ	0FFF4h		; VDP register 21 content (MSX2~)
RG22SAV	equ	0FFF5h		; VDP register 22 content (MSX2~)
RG23SAV	equ	0FFF5h		; VDP register 23 content (MSX2~)
RG25SAV	equ	0FFF4h		; VDP register 21 content (MSX2+~)
RG26SAV	equ	0FFF5h		; VDP register 22 content (MSX2+~)
RG27SAV	equ	0FFF5h		; VDP register 23 content (MSX2+~)
STATFL	equ	0F3E7h		; Contents of the VDP status 0 register

; Various

AVCSAV	equ	0FAF7h		; AV control port (0F7h) content (MSX2+~) 
CASPRV	equ	0FCB1h		; Work area for the data recorder or Pause/R800 LED status on MSX Turbo R
EXTBIO	equ	0FFCAh		; Extended Bios call
PROCNM	equ	0FD89h		; Work area for CALL and OPEN (16 bytes)
QUEBAK	equ	0F971h		; Queues table of replacement character 
QUETAB	equ	0F959h		; Table of PLAY queues and RS-232C interface for MSX1 
QUEUEN	equ	0FB3Eh		; Current queue number 
QUEUES	equ	0F3F3h		; Address of the QUETAB queues table
USRTAB	equ	0F39Ah		; Addresses table of DEFUSR instruction (20 bytes)