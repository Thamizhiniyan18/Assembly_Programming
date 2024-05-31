section .data
  msg1 db "Enter the first number:", 0xA, 0xD
  len1 equ $- msg1

  msg2 db "Enter the second number:", 0xA, 0xD
  len2 equ $- msg2

  msg3 db "Sum of the numbers:", 0xA, 0xD
  len3 equ $- msg3

section .bss
  num1 resb 2
  num2 resb 2
  res resb 1

section .text
  global _start

_start:
  ; Printing msg1
  mov edx, len1                 ; Length of the message
  mov ecx, msg1                 ; Message
  mov ebx, 1                    ; file descriptor (STDOUT)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Reading num1
  mov edx, 2                    ; Length of the input
  mov ecx, num1                 ; Variable
  mov ebx, 0                    ; file descriptor (STDIN)
  mov eax, 3                    ; sys_read
  int 0x80                      ; Kernel Interrupt

  ; Printing msg2
  mov edx, len2                 ; Length of the message
  mov ecx, msg2                 ; Message
  mov ebx, 1                    ; File Descriptor (STDOUT)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Reading num2
  mov edx, 2                    ; Length of the input
  mov ecx, num2                 ; Variable
  mov ebx, 0                    ; File Descriptor (STDIN)
  mov eax, 3                    ; sys_read
  int 0x80                      ; Kerenel Interrupt

  ; Performing the Addition
  mov ebx, [num2]
  sub ebx, '0'                  ; ASCII to Decimal

  mov eax, [num1]
  sub eax, '0'                  ; ASCII to Decimal

  add eax, ebx
  add eax, '0'                  ; Decimal to ASCII
  
  ; Storing the result in res
  mov [res], eax

  ; Printing msg3
  mov edx, len3                 ; Length of the message
  mov ecx, msg3                 ; Message
  mov ebx, 1                    ; file Descriptor (STDOUT)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Printing res
  mov edx, 1                    ; Length of the result
  mov ecx, res                  ; Result
  mov ebx, 1                    ; file descriptor (STDOUT)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Exiting the Program
  mov eax, 1                    ; sys_exit
  int 0x80                      ; Kernel Interrupt
