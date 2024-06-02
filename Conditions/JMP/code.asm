section .data
  msg db "Hello Everybody!!!!"
  len equ $- msg

section .bss

section .text
  global _start                 ; Must be declared for using gcc

_start:
  jmp printing_the_message      ; Unconditional Jump
  jmp exiting_the_program       ; Unconditional Jump

printing_the_message:
  mov edx, len                  ; length of the message
  mov ecx, msg                  ; message
  mov ebx, 1                    ; file descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

exiting_the_program:
  mov eax, 1                    ; sys_write
  int 0x80                      ; Kernel Interrupt
