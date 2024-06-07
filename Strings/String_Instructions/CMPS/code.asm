section .data
  string1 db "Hello, World!"
  string1_len equ $- string1

  string2 db "Hello, World!"
  string2_len equ $- string2

  equ_msg db "The Given Strings Are Equal!"
  equ_msg_len equ $- equ_msg

  not_equ_msg db "The Given Strings Are Not Equal!"
  not_equ_msg_len equ $- not_equ_msg

section .bss

section .text
  global _start

_start:
  mov ecx, string2_len                      ; Length of string2
  mov esi, string1                          ; String1
  mov edi, string2                          ; String2

  cld                                       ; resetting the direction flag to 0; setting the direction as left to right
  repe cmpsb                                ; repeats if ecx != 0 and if ZF = 1 ; compares the esi and edi byte by byte and sets ZF=0 if esi != edi
  jecxz _if_equal                           ; Jump if ecx is equal to 0

_if_not_equal:
  ; Printing the Not Equal Message
  mov edx, not_equ_msg_len                  ; Length of the Not Equal Message
  mov ecx, not_equ_msg                      ; Not Equal Message
  mov ebx, 1                                ; File Descriptor (stdout)
  mov eax, 4                                ; sys_write
  int 0x80                                  ; kernel interrupt
  jmp _exit                                 ; Jumping to the _exit procedure

_if_equal:
  ; Printing the Equal Message
  mov edx, equ_msg_len                      ; Length of the Equal Message
  mov ecx, equ_msg                          ; Equal Message
  mov ebx, 1                                ; File Descriptor (stdout)
  mov eax, 4                                ; sys_write
  int 0x80                                  ; Kernel Interrupt

_exit:
  ; Exiting the Program
  mov ebx, 0                                ; No Errors, Return 0
  mov eax, 1                                ; sys_exit
  int 0x80                                  ; Kernel Interrupt
