;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
			; Set GPIO P1.0 to be an output
			; Bit set instruction
			; #1 = first instruction set in PA1. so bit 0 in PA1.0

			BIS.B#1, &PADIR_L

			; Set output on GPIO P1.0 to high voltage
			BIS.B#1, &PAOUT_L

			; Set output on GPIO P1.0 to low voltage
			; bit clear instruction
			BIC.B#1, &PAOUT_L
			; And repeat.
MainLoop:
			BIS.B#1, &PAOUT_L
			BIC.B#1, &PAOUT_L
			JMP MainLoop
			NOP

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
