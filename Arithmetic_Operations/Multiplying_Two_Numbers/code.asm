section .data
  msg db "The Product of 4 * 2 is:", 0XA, 0xD
  len equ $- msg

section .bss
  res resb 1

section .text
  global _start                 ; Must be declard for using gcc

_start:
  mov al, 4                     ; Moving multiplicand to the A register
  mov bl, 2                     ; Moving multiplier to the D register
  mul bl                        ; Performing the Multiplication
  add al, '0'                   ; Integer to ASCII
  mov [res], al                 ; Storing the result in res

  ; Printing the Message
  mov edx, len                  ; Length of the Message
  mov ecx, msg                  ; Message
  mov ebx, 1                    ; file descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Printing the result
  mov edx, 1                    ; Length of the messsage
  mov ecx, res                  ; Message to be printed
  mov ebx, 1                    ; file descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Exiting the Program
  mov eax, 1                    ; sys_exit
  int 0x80                      ; Kernel Interrupt
