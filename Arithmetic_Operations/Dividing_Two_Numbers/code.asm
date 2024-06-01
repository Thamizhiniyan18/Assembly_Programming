section .data
  msg db "6 divided by 2 gives:", 0xA, 0xD
  len equ $- msg

  msg1 db "The Quotient is:", 0xA, 0xD
  len1 equ $- msg1

  msg2 db "The Remainder is:", 0xA, 0xD
  len2 equ $- msg2

  newline db 0xA, 0xD
  lenNewLine equ $- newline

section .bss
  quotient resb 1
  remainder resb 1

section .text
  global _start                     ; Must be declared for using gcc

_start:
  mov ax, 6                         ; Moving Dividend to the 16 bit ax register
  mov bl, 2                         ; Moving Divisor to the 8 bit bl register
  div bl                            ; Performing the Division
  add al, '0'                       ; Integer to ASCII
  mov [quotient], al                ; Storing the quotient
  add ah, '0'                       ; Integer to ASCII
  mov [remainder], ah               ; Storing the remainder

  ; Printing the Message
  mov edx, len                      ; Length of the Message
  mov ecx, msg                      ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the Quotient Message
  mov edx, len1                     ; Length of the Message
  mov ecx, msg1                     ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the Quotient
  mov edx, 1                        ; Length of the quotient
  mov ecx, quotient                 ; Quotient
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; kernel interrupt

  ; Printing a newline
  mov edx, lenNewLine               ; Length of the Newline
  mov ecx, newline                  ; NewLine
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; kernel interrupt

  ; Printing the Remainder Message
  mov edx, len2                     ; Length of the Message
  mov ecx, msg2                     ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the Remainder
  mov edx, 1                        ; Length of the remainder
  mov ecx, remainder                ; Remainder
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Exiting the Program
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt  
