section .data
  source db "abcedefgh", 0
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
    lodsb                               ; Loads (cut and paste) a byte from esi to al register
    add al, 03                          ; shifting characters
    stosb                               ; Copies the value in al register to the location mentioned in edi register
    loop _loop                          ; loop till all the characters from the source are processed

  cld                                   ; reset the destination flag to 0
  rep movsb                             ; 

  ; Printing the destination
  mov edx, 20                           ; Length of the destination
  mov ecx, destination                  ; destination
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  ; Exiting the Program
  mov ebx, 0                            ; No Errors, return 0
  mov eax, 1                            ; sys_exit
  int 0x80                              ; Kernel Interrupt
