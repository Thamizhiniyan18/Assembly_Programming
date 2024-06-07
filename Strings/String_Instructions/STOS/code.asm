; Program to convert Upper Case letters to Lower Case letters
section .data
  source db "HELLO WORLD"
  source_len equ $- source

section .bss
  destination resb 20

section .text
  global _start

_start:
  mov ecx, source_len                   ; Length of the source (counter for loop)
  mov esi, source
  mov edi, destination

  _loop:
    lodsb                               ; Loads (cut and paste) a byte from the esi register to al register
    or al, 0x20                         ; converts Upper case letter to lower case
    stosb                               ; Copying the al register value to the location pointed by edi resgister
    loop _loop                          ; Looping till all the characters are processed

  ; printing the destination
  mov edx, 20                           ; Length of the destination
  mov ecx, destination                  ; Destination
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  ; Exiting the Program
  mov ebx, 0                            ; No Errors, return 0
  mov eax, 1                            ; sys_write
  int 0x80                              ; Kernel Interrupt
