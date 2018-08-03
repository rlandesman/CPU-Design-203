;---------------------------------------------------------------------
; An expanded "draw_dot" program that includes subrountines to draw
; vertical lines, horizontal lines, and a full background. 
; 
; As written, this programs does the following: 
;   1) draws a the background blue (draws all the tiles)
;   2) draws a red dot
;   3) draws a red horizontal lines
;   4) draws a red vertical line
;
; Author: Bridget Benson 
; Modifications: bryan mealy
;---------------------------------------------------------------------

.CSEG
.ORG 0x10

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU SSEG = 0x81
.EQU LEDS = 0x40
.EQU SWITCH_IN = 0x20
.EQU time_INSIDE = 0x3E
.EQU time_MIDDLE = 0xE0
.EQU time_OUTSIDE = 0xE0

.EQU BG_COLOR       = 0x00             ; Background:  BLACK


;r6 is used for color
;r7 is used for Y
;r8 is used for X
		
;---------------------------------------------------------------------
		 CALL   draw_background         ; draw using default color

main:    ;IN		r31, SWITCH_IN
		; CMP	r31, 0x01
		; BREQ   WARP

		MOV r6, 0xFF

		MOV r7, 0x03


		MOV r30, 0x06 ;   ### 28
		MOV r22, 0x23 ;
		MOV r23, 0x27 ;   ### 25
		MOV r24, 0x23 ;   ### 20
		MOV r26, 0x1C
		MOV r25, 0x10

		MOV r21, 0x10
		MOV r20, 0x18
		MOV r19, 0x13

;		aSTAR1L:



		IN	r31, SWITCH_IN
		CMP	r31, 0x01
		;BREQ   WARPe
		BREQ WARP

		MOV r8, r30
		MOV r7, 0x01
	    CALL draw_dot

		MOV r8, r22 ;
		MOV r7, 0x03
	    CALL draw_dot

		MOV r8, r23 ;
		MOV r7, 0x07
	    CALL draw_dot

		MOV r8, r24 ;
		MOV r7, 0x0E
	    CALL draw_dot

		MOV r8, r26
		MOV r7, 0x14 ; ### 10
	    CALL draw_dot

		MOV r8, r25
		MOV r7, 0x16
	    CALL draw_dot

		MOV r8, r21
		MOV r7, 0x06
	    CALL draw_dot

		MOV r8, r20
		MOV r7, 0x12
	    CALL draw_dot

		MOV r8, r19
		MOV r7, 0x19
	    CALL draw_dot

		CALL originalShip


		BRN main
		 

originalShip:

		 MOV r6, 0xB7
		 ;row 1
		 MOV    r8,0x1B                 
         MOV    r7,0x08                 
         MOV    r9,0x1E                
         CALL   draw_horizontal_line
		 ;MOV r6, 0xB7		 ;row 2
         MOV    r8,0x04                 ; starting x coordinate
         MOV    r7,0x09                 ; start y coordinate
         MOV    r9,0x11                 ; ending x coordinate    changed from 0x12
         CALL   draw_horizontal_line
		 MOV    r8,0x16                 
         MOV    r7,0x09                 
         MOV    r9,0x22                 
         CALL   draw_horizontal_line
		 MOV r6, 0xDB
		 ;row 3
		 MOV    r8,0x05                 
         MOV    r7,0x0A                 
         MOV    r9,0x11                 
         CALL   draw_horizontal_line
		 MOV    r8,0x15                 
         MOV    r7,0x0A                 
         MOV    r9,0x23                 
         CALL   draw_horizontal_line
		 MOV r6, 0xB7
		 ;row 4
		 MOV    r8,0x0E                 
         MOV    r7,0x0B                
         MOV    r9,0x0F                 
         CALL   draw_horizontal_line
		 MOV    r8,0x16                 
         MOV    r7,0x0B                 
         MOV    r9,0x19                 
         CALL   draw_horizontal_line
		 MOV    r8,0x1B                
         MOV    r7,0x0B                 
         MOV    r9,0x1E                 
         CALL   draw_horizontal_line
		 ;row 5
		 MOV    r8,0x0E                 
         MOV    r7,0x0C                 
         MOV    r9,0x0F                 
         CALL   draw_horizontal_line
		 MOV    r8,0x15                
         MOV    r7,0x0C                
         MOV    r9,0x18                 
         CALL   draw_horizontal_line
		 ;row 6
		 MOV    r8,0x0E                 
         MOV    r7,0x0D               
         MOV    r9,0x0F                
         CALL   draw_horizontal_line
		 MOV    r8,0x14                 
         MOV    r7,0x0D                 
         MOV    r9,0x17                 
         CALL   draw_horizontal_line
		 ;MOV r6, 0xB7
		 ;row 7
		 MOV    r8,0x0D                 
         MOV    r7,0x0E                
         MOV    r9,0x18                 
         CALL   draw_horizontal_line
		 ;MOV r6, 0xB7
		 ;row 8
		 MOV    r8,0x0E                 
         MOV    r7,0x0F                 
         MOV    r9,0x18                
         CALL   draw_horizontal_line
		 MOV r6, 0xDB
		 ;row 9
		 MOV    r8,0x10                 
         MOV    r7,0x10                 
         MOV    r9,0x18                 
         CALL   draw_horizontal_line

;-------------------------------------
; OTHER COLORS
;-------------------------------------

		 MOV r6, 0xB2
         MOV    r7, 0x09                ; generic Y coordinate
         MOV    r8, 0x04                ; generic X coordinate
         CALL   draw_dot                
         MOV    r7, 0x0A                ; generic Y coordinate
         MOV    r8, 0x05                ; generic X coordinate
         CALL   draw_dot 
         MOV    r7, 0x09                ; generic Y coordinate
         MOV    r8, 0x05                ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x09                ; generic Y coordinate
         MOV    r8, 0x12                ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x0A                ; generic Y coordinate
         MOV    r8, 0x12                ; generic X coordinate
         CALL   draw_dot
		 MOV    r7, 0x0E                ; generic Y coordinate
         MOV    r8, 0x18                ; generic X coordinate
         CALL   draw_dot                
         MOV    r7, 0x0F                ; generic Y coordinate
         MOV    r8, 0x18                ; generic X coordinate
         CALL   draw_dot 
         MOV    r7, 0x10                ; generic Y coordinate
         MOV    r8, 0x18                ; generic X coordinate
         CALL   draw_dot  

		; MOV r6, 0x92
        ; MOV    r8,0x11                 ; starting x coordinate
        ; MOV    r7,0x10                 ; start y coordinate
        ; MOV    r9,0x13                 ; ending x coordinate
        ; CALL   draw_horizontal_line   

		 MOV r6, 0x00
		 MOV    r8,0x01                 
         MOV    r7,0x09                 
         MOV    r9,0x03                
         CALL   draw_horizontal_line
		 MOV    r8,0x02                
         MOV    r7,0x0A                
         MOV    r9,0x04                
         CALL   draw_horizontal_line
		 MOV    r7, 0x0B                ; generic Y coordinate
         MOV    r8, 0x0D                ; generic X coordinate
         CALL   draw_dot  
         MOV    r7, 0x0C                ; generic Y coordinate
         MOV    r8, 0x0D               ; generic X coordinate
         CALL   draw_dot  	
         MOV    r7, 0x0D               ; generic Y coordinate
         MOV    r8, 0x0D               ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x0E              ; generic Y coordinate
         MOV    r8, 0x0C               ; generic X coordinate
         CALL   draw_dot 	
         MOV    r7, 0x0F              ; generic Y coordinate
         MOV    r8, 0x0D               ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x16              ; generic Y coordinate
         MOV    r8, 0x0F              ; generic X coordinate
         CALL   draw_dot

         MOV    r7, 0x0E              ; generic Y coordinate
         MOV    r8, 0x19               ; generic X coordinate
         CALL   draw_dot 	
         MOV    r7, 0x0F              ; generic Y coordinate
         MOV    r8, 0x19               ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x10              ; generic Y coordinate
         MOV    r8, 0x19             ; generic X coordinate
         CALL   draw_dot

         MOV    r7, 0x0B              ; generic Y coordinate
         MOV    r8, 0x1A               ; generic X coordinate
         CALL   draw_dot 	
         MOV    r7, 0x0C              ; generic Y coordinate
         MOV    r8, 0x19               ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x0D              ; generic Y coordinate
         MOV    r8, 0x18             ; generic X coordinate
         CALL   draw_dot

         MOV    r7, 0x08              ; generic Y coordinate
         MOV    r8, 0x1F               ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x0B             ; generic Y coordinate
         MOV    r8, 0x1F             ; generic X coordinate
         CALL   draw_dot


		 MOV    r8,0x23                
         MOV    r7,0x09                 
         MOV    r9,0x27                
         CALL   draw_horizontal_line
		 MOV    r8,0x24                
         MOV    r7,0x0A                
         MOV    r9,0x27                
         CALL   draw_horizontal_line


		 RET

warpShip:

		 MOV r6, 0xB7

		 ;row 1
		 MOV    r8,0x1C                 
         MOV    r7,0x08                 
         MOV    r9,0x1F                
         CALL   draw_horizontal_line
		 ;MOV r6, 0xB7		 ;row 2
         MOV    r8,0x01                 ; starting x coordinate
         MOV    r7,0x09                 ; start y coordinate
         MOV    r9,0x11                 ; ending x coordinate    changed from 0x12
         CALL   draw_horizontal_line
		 MOV    r8,0x17                
         MOV    r7,0x09                 
         MOV    r9,0x25                
         CALL   draw_horizontal_line
		 MOV r6, 0xDB
		 ;row 3
		 MOV    r8,0x02                
         MOV    r7,0x0A                 
         MOV    r9,0x11                 
         CALL   draw_horizontal_line
		 MOV    r8,0x16                 
         MOV    r7,0x0A                 
         MOV    r9,0x26                
         CALL   draw_horizontal_line
		 MOV r6, 0xB7
		 ;row 4
		 MOV    r8,0x0D                 
         MOV    r7,0x0B                
         MOV    r9,0x0F                 
         CALL   draw_horizontal_line
		 MOV    r8,0x17                
         MOV    r7,0x0B                 
         MOV    r9,0x1A                
         CALL   draw_horizontal_line
		 MOV    r8,0x1C                
         MOV    r7,0x0B                 
         MOV    r9,0x1F                 
         CALL   draw_horizontal_line
		 ;row 5
		 MOV    r8,0x0D                 
         MOV    r7,0x0C                 
         MOV    r9,0x0F                 
         CALL   draw_horizontal_line
		 MOV    r8,0x16               
         MOV    r7,0x0C                
         MOV    r9,0x19                 
         CALL   draw_horizontal_line
		 ;row 6
		 MOV    r8,0x0D                
         MOV    r7,0x0D               
         MOV    r9,0x0F                
         CALL   draw_horizontal_line
		 MOV    r8,0x15                 
         MOV    r7,0x0D                 
         MOV    r9,0x18                 
         CALL   draw_horizontal_line
		 ;MOV r6, 0xB7
		 ;row 7
		 MOV    r8,0x0C                 
         MOV    r7,0x0E                
         MOV    r9,0x19                 
         CALL   draw_horizontal_line
		 ;MOV r6, 0xB7
		 ;row 8
		 MOV    r8,0x0D                 
         MOV    r7,0x0F                 
         MOV    r9,0x19                
         CALL   draw_horizontal_line
		 MOV r6, 0xDB
		 ;row 9
		 MOV    r8,0x0F                 
         MOV    r7,0x10                 
         MOV    r9,0x19                 
         CALL   draw_horizontal_line

;-------------------------------------
; OTHER COLORS
;-------------------------------------

		 MOV r6, 0xB2
         MOV    r7, 0x09                ; generic Y coordinate
         MOV    r8, 0x01                ; generic X coordinate
         CALL   draw_dot                
         MOV    r7, 0x0A                ; generic Y coordinate
         MOV    r8, 0x02                ; generic X coordinate
         CALL   draw_dot 
         MOV    r7, 0x09                ; generic Y coordinate
         MOV    r8, 0x02                ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x09                ; generic Y coordinate
         MOV    r8, 0x12                ; generic X coordinate
         CALL   draw_dot
         MOV    r7, 0x0A                ; generic Y coordinate
         MOV    r8, 0x12                ; generic X coordinate
         CALL   draw_dot
		 MOV    r7, 0x0E                ; generic Y coordinate
         MOV    r8, 0x19                ; generic X coordinate
         CALL   draw_dot                
         MOV    r7, 0x0F                ; generic Y coordinate
         MOV    r8, 0x19                ; generic X coordinate
         CALL   draw_dot 
         MOV    r7, 0x10                ; generic Y coordinate
         MOV    r8, 0x19                ; generic X coordinate
         CALL   draw_dot  

		 MOV 	r6, 0x00
         MOV    r7, 0x08               ; generic Y coordinate
         MOV    r8, 0x1B                ; generic X coordinate
         CALL   draw_dot 
         MOV    r7, 0x0B                ; generic Y coordinate
         MOV    r8, 0x1B                ; generic X coordinate
         CALL   draw_dot  


		; MOV r6, 0x92
        ; MOV    r8,0x11                 ; starting x coordinate
        ; MOV    r7,0x10                 ; start y coordinate
        ; MOV    r9,0x13                 ; ending x coordinate
        ; CALL   draw_horizontal_line                    		 
		 RET


;--------------------------------------------------------------------

WARP:	
		;CALL draw_Background
		;CALL drawShip

		MOV r6, 0xFF

		MOV r7, 0x03
		;MOV r8, 0x28

		MOV r30, 0x06
		MOV r22, 0x23 ;
		MOV r23, 0x27 ;
		MOV r24, 0x23 ;
		MOV r26, 0x1C
		MOV r25, 0x10

		MOV r21, 0x10
		MOV r20, 0x18
		MOV r19, 0x13

		STAR1L:

		IN r31, SWITCH_IN
		CMP r31, 0x00
		BREQ escm

		MOV r8, r30
		MOV r7, 0x01
	    CALL draw_dot

		MOV r8, r22 ;
		MOV r7, 0x03
	    CALL draw_dot

		MOV r8, r23 ;
		MOV r7, 0x07
	    CALL draw_dot

		MOV r8, r24 ;
		MOV r7, 0x0E
	    CALL draw_dot

		MOV r8, r26
		MOV r7, 0x14
	    CALL draw_dot

		MOV r8, r25
		MOV r7, 0x16
	    CALL draw_dot

		MOV r8, r21
		MOV r7, 0x06
	    CALL draw_dot

		MOV r8, r20
		MOV r7, 0x12
	    CALL draw_dot

		MOV r8, r19
		MOV r7, 0x19
	    CALL draw_dot

		;CALL warpShip

		CALL drawShip
		

		IN r31, SWITCH_IN
		CMP r31, 0x03
		BREQ warp2
		CALL pause2
		ret2:





		MOV r6, 0x00

		MOV r8, r30
		MOV r7, 0x01
	    CALL draw_dot

		MOV r8, r22 ; 0x29
		MOV r7, 0x03
	    CALL draw_dot

		MOV r8, r23 ; 0x28
		MOV r7, 0x07
	    CALL draw_dot

		MOV r8, r24 ; 0x27
		MOV r7, 0x0E
	    CALL draw_dot

		MOV r8, r26
		MOV r7, 0x14
	    CALL draw_dot

		MOV r8, r25
		MOV r7, 0x16
	    CALL draw_dot

		MOV r8, r21
		MOV r7, 0x06
	    CALL draw_dot

		MOV r8, r20
		MOV r7, 0x12  ; was 10
	    CALL draw_dot

		MOV r8, r19
		MOV r7, 0x19  ; 
	    CALL draw_dot

		;CALL warpShip

		CALL drawShip

		MOV r6, 0xFF
		;SUB r8, 0x01
		;CMP r8, 0x00

		SUB r30, 0x01
		CMP r30, 0x00
		;BREQ STAR1
		BREQ S1

		
s_1: 
		SUB r22, 0x01 ;
		CMP r22, 0x00 ;
		;BREQ STAR1
		BREQ S2
s_2:
		SUB r23, 0x01 ;
		CMP r23, 0x00 ;
		;BREQ STAR1
		BREQ S3
s_3:
		SUB r24, 0x01 ;
		CMP r24, 0x00 ;
		;BREQ STAR1
		BREQ S4
s_4:
		SUB r26, 0x01
		CMP r26, 0x00
		;BREQ STAR1
		BREQ S5
s_5:
		SUB r25, 0x01
		CMP r25, 0x00
		;BREQ STAR1
		BREQ S6

s_6:
		SUB r21, 0x01
		CMP r21, 0x00
		BREQ S7

s_7:
		SUB r20, 0x01
		CMP r20, 0x00
		BREQ S8

s_8:
		SUB r19, 0x01
		CMP r19, 0x00
		BREQ S9


		BRN STAR1L

P

S1:		MOV r30, 0x27 ; 20
		BRN s_1
S2:		MOV r22, 0x27 ; 23
		BRN s_2
S3:		MOV r23, 0x27 ; 27
		BRN s_3
S4:		MOV r24, 0x27 ; 23
		BRN s_4
S5:		MOV r26, 0x27 ; 1C
		BRN s_5
S6:		MOV r25, 0x27 ; 10
		BRN s_6


S7:		MOV r21, 0x27 ; 10
		BRN s_7
S8:		MOV r20, 0x27 ; 18
		BRN s_8
S9:		MOV r19, 0x27 ; 10
		
		BRN STAR1L
   
;--------------------------------------------------------------------
;-  Subroutine: draw_horizontal_line
;-
;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
;-
;-  Parameters:
;-   r8  = starting x-coordinate
;-   r7  = y-coordinate
;-   r9  = ending x-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r8,r9
;--------------------------------------------------------------------
draw_horizontal_line:
        ADD    r9,0x01          ; go from r8 to r15 inclusive

draw_horiz1:
        CALL   draw_dot         ; 
        ADD    r8,0x01
        CMP    r8,r9
        BRNE   draw_horiz1
        RET
;--------------------------------------------------------------------


;---------------------------------------------------------------------
;-  Subroutine: draw_vertical_line
;-
;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
;-
;-  Parameters:
;-   r8  = x-coordinate
;-   r7  = starting y-coordinate
;-   r9  = ending y-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r7,r9
;--------------------------------------------------------------------
draw_vertical_line:
         ADD    r9,0x01

draw_vert1:          
         CALL   draw_dot
         ADD    r7,0x01
         CMP    r7,R9
         BRNE   draw_vert1
         RET
;--------------------------------------------------------------------

;---------------------------------------------------------------------
;-  Subroutine: draw_background
;-
;-  Fills the 30x40 grid with one color using successive calls to 
;-  draw_horizontal_line subroutine. 
;- 
;-  Tweaked registers: r13,r7,r8,r9
;----------------------------------------------------------------------
draw_background: 
         MOV   r6,BG_COLOR              ; use default color
         MOV   r13,0x00                 ; r13 keeps track of rows
start:   MOV   r7,r13                   ; load current row count 
         MOV   r8,0x00                  ; restart x coordinates
         MOV   r9,0x27 
 
         CALL  draw_horizontal_line
         ADD   r13,0x01                 ; increment row count
         CMP   r13,0x1D                 ; see if more rows to draw
         BRNE  start                    ; branch to draw more rows
         RET
;---------------------------------------------------------------------
    
;---------------------------------------------------------------------
;- Subrountine: draw_dot
;- 
;- This subroutine draws a dot on the display the given coordinates: 
;- 
;- (X,Y) = (r8,r7)  with a color stored in r6  
;- 
;- Tweaked registers: r4,r5
;---------------------------------------------------------------------
draw_dot: 
           MOV   r4,r7         ; copy Y coordinate
           MOV   r5,r8         ; copy X coordinate

           AND   r5,0x3F       ; make sure top 2 bits cleared
           AND   r4,0x1F       ; make sure top 3 bits cleared
           LSR   r4             ; need to get the bot 2 bits of r4 into sA
           BRCS  dd_add40
t1:        LSR   r4
           BRCS  dd_add80

dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
           OUT   r4,VGA_HADD   ; write top 3 address bits to register
           OUT   r6,VGA_COLOR  ; write data to frame buFFer
           RET

dd_add40:  OR    r5,0x40       ; set bit if needed
           CLC                  ; freshen bit
           BRN   t1             

dd_add80:  OR    r5,0x80       ; set bit if needed
           BRN   dd_out
; --------------------------------------------------------------------
pause:	     MOV     R29, time_OUTSIDE  ;set outside for loop count
outside_for: SUB     R29, 0x01;
			 MOV     R28, time_MIDDLE   ;set middle for loop count
middle_for: SUB     R28, 0x01
			 
			 MOV     R27, time_INSIDE   ;set inside for loop count
inside_for: SUB     R27, 0x01
			 BRNE    inside_for
			 
			 OR      R28, 0x00               ;load flags for middle for counter
			 BRNE    middle_for
			 
			 OR      R29, 0x00               ;load flags for outsde for counter value
			 BRNE    outside_for
			 RET

pause2:	     MOV     R29, 0xD0  ;set outside for loop count
aoutside_for: SUB     R29, 0x01;
			 MOV     R28, 0x30   ;set middle for loop count
amiddle_for: SUB     R28, 0x01
			 
			 MOV     R27, 0x30   ;set inside for loop count
ainside_for: SUB     R27, 0x01
			 BRNE    ainside_for
			 
			 OR      R28, 0x00               ;load flags for middle for counter
			 BRNE    amiddle_for
			 
			 OR      R29, 0x00               ;load flags for outsde for counter value
			 BRNE    aoutside_for
			 RET

escm:
			 CALL   draw_background         ; draw using default color
			 BRN main

warp2:		CALL warp2pause	
			BRN ret2
			

warp2pause:		MOV r0, 0x50
w2_outside_for: SUB     R0, 0x01;
				MOV r1, 0x30
w2_middle_for:  SUB     R1, 0x01
				MOV r2, 0x30
w2_inside_for:  SUB     R2, 0x01
			    BRNE    w2_inside_for
			    OR      R1, 0x00               ;load flags for middle for counter
			    BRNE    w2_middle_for
			    OR      R0, 0x00               ;load flags for outsde for counter value
			    BRNE    w2_outside_for
			    RET

drawShip:	IN r31, SWITCH_IN
			CMP r31, 0x03
			BREQ warps
			CALL originalShip
			RET
	warps:  CALL warpShip
			RET

;WARPe:	CALL draw_background
;		BRN WARP