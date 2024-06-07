section .data
  string db "Super Dooper"
  string_len equ $- string

  found db "Character Found!"
  found_len equ $- found

  not_found db "Character Not Found!!"
  not_found_len equ $- not_found

section .bss

section .text
  global _start

_start:
  mov ecx, string_len                   ; Length of the String
  mov edi, string                       ; string
  mov al, "D"                           ; Character that we are looking for
  cld                                   ; resetting the direction flag to 0; Setting the direction from left to right
  repne scasb                           ; repeat if ZF! = 0 and CX != 0; stops if ZF=1 or if CX=0; compares the byte from edi register with the byte from al register
  je _found                             ; jump if the byte from edi register is equal to byte from the al register

_not_found:
  ; Printing the Not Found Message
  mov edx, not_found_len                ; length of the not found msg
  mov ecx, not_found                    ; Not Found Message
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt
  jmp _exit                             ; Switching control to the _exit procedure

_found:
  ; Priting the Found Message
  mov edx, found_len                    ; Length of the found message
  mov ecx, found                        ; Found Message
  mov ebx, 1                            ; File Descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

_exit:
  ; Exiting the Program
  mov ebx, 0                            ; No Errors, return 0
  mov eax, 1                            ; sys_exit
  int 0x80                              ; Kernel_Interrupt
