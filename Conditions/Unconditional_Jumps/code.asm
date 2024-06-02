section .data
  msg1 db "Given Numbers are:", 0xA
  len1 equ $- msg1

  msg2 db "The Largest Number is:", 0xA
  len2 equ $- msg2
  
  num1 db "24", 0xA, 0xD
  len_num1 equ $- num1

  num2 db "34", 0xA, 0xD
  len_num2 equ $- num2

  num3 db "12", 0xA, 0xD
  len_num3 equ $- num3

  num4 db "11", 0xA, 0xD
  len_num4 equ $- num4

section .bss
  largest resb 2

section .text
  global _start                     ; Must be declared for using gcc

_start:
  ; Printing msg1
  mov edx, len1                     ; Length of the message
  mov ecx, msg1                     ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the num1
  mov edx, len_num1                 ; Size of the number
  mov ecx, num1                     ; number
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the num2
  mov edx, len_num2                 ; Size of the number
  mov ecx, num2                     ; number
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the num3
  mov edx, len_num3                 ; Size of the number
  mov ecx, num3                     ; number
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the num4
  mov edx, len_num4                 ; Size of the number
  mov ecx, num4                     ; number
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Comparing num1 and num2
  mov ecx, dword [num1]
  sub ecx, '0'                      ; ASCII to Decimal
  mov eax, dword [num2]
  sub eax, '0'                      ; ASCII to Decimal
  cmp ecx, eax
  jg _check_third_num               ; if ecx > [num2]: jump to _check_third_num
  mov ecx, eax                      ; else mov num2 to ecx

_check_third_num:
  mov eax, dword[num3]
  sub eax, '0'                      ; ASCII to Decimal
  cmp ecx, eax
  jg _check_fourth_num              ; if ecx > [num3]: jump to _check_fourth_num
  mov ecx, eax                      ; else mov num3 to ecx

_check_fourth_num:
  mov eax, dword [num4]
  sub eax, '0'                      ; ASCII to Decimal
  cmp ecx, eax
  jg _printing_largest              ; if ecx > [num4]: jump to _printing_largest
  mov ecx, eax                      ; else mov num4 to ecx

_printing_largest:
  add ecx, '0'                      ; Decimal to ASCII
  mov [largest], ecx                ; Storing the largest number

  ; Printing msg2
  mov edx, len2                     ; Length of the message
  mov ecx, msg2                     ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Printing the Largest Number
  mov edx, 2                        ; Size of the number
  mov ecx, largest                  ; largest number
  mov ebx, 1                        ; file descriptor
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt
  jmp _exit                         ; Exiting the program

_exit:
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt
