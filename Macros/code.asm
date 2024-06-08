; Macro for printing content to stdout
%macro print 2
  mov edx, %1                   ; Length of the content
  mov ecx, %2                   ; content
  mov ebx, 1                    ; file descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt
%endmacro

section .data
  msg1 db "Hello Everyone!!!!", 0xA, 0xD
  len1 equ $- msg1

  msg2 db "Super Dooper!!!!", 0xA 0xD
  len2 equ $- msg2

  msg3 db "1234567890!@#$%^&*()", 0xA, 0xD
  len3 equ $- msg3

section .bss

section .text
  global _start

_start:
  ; Printing the Messages
  print len1, msg1
  print len2, msg2
  print len3, msg3

  ; Exiting the Program
  mov ebx, 0                    ; No Errors; Return 0
  mov eax, 1                    ; sys_exit
  int 0x80                      ; Kernel Interrupt
