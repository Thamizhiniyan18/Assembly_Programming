section .data
  source db "Hello, World!"
  source_len equ $- source

section .bss
  destination resb 20

section .text
  global _start

_start:
  mov ecx, source_len               ; Length of the String ( counter for rep )
  mov esi, source                   ; Source
  mov edi, destination              ; Destination
  cld                               ; resetting the direction flag to 0
  rep movsb                         ; moving source to destination byte by byte

  ; Printing the Destination
  mov edx, 20                       ; Length of the Destination
  mov ecx, destination              ; Destination
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Exiting the Program
  mov ebx, 0                        ; No Errors, return 0
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt
