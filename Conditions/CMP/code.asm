section .data
  input_1_msg db "Enter the first number (0-9): "
  len_1_msg equ $- input_1_msg

  input_2_msg db "Enter the second number (0-9): "
  len_2_msg equ $- input_2_msg

  equal_msg db "The Given Numbers are Equal!"
  len_equal_msg equ $- equal_msg

  not_equal_msg db "The Given Numbers are Not Equal!"
  len_not_equal_msg equ $- not_equal_msg

section .bss
  num1 resb 1
  num2 resb 1

section .text
  global _start                     ; Must be declared for using gcc

_start:
  ; Input 1 Message
  mov edx, len_1_msg                ; Size of the message
  mov ecx, input_1_msg              ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Reading the first number
  mov edx, 2                        ; Size of the input (1 char + newline)
  mov ecx, num1                     ; storing the input in num1
  mov ebx, 0                        ; file descriptor (stdin)
  mov eax, 3                        ; sys_read
  int 0x80                          ; Kernel Interrupt

  ; Input 2 Message
  mov edx, len_2_msg                ; size of the message
  mov ecx, input_2_msg              ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Reading the second number
  mov edx, 2                        ; Size of the input (1 char + newline)
  mov ecx, num2                     ; storing the input in num2
  mov ebx, 0                        ; file descriptor (stdin)
  mov eax, 3                        ; sys_read
  int 0x80                          ; Kernel Interrupt

  ; Comparing the Numbers
  mov al, [num1]
  sub al, '0'                       ; ASCII to Decimal
  mov bl, [num2]
  sub bl, '0'                       ; ASCII to Decimal
  cmp eax, ebx                      ; Comparing the numbers
  je if_zero                        ; If the numbers are equal then call the if_zero function

  ; If the numbers are not equal then continue
  ; Printing the Not Equal Message
  mov edx, len_not_equal_msg        ; Length of the message
  mov ecx, not_equal_msg            ; message
  mov ebx, 1                        ; file descriptor
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt
  jmp exit_function                 ; Calling the exit_function

if_zero:
  mov edx, len_equal_msg            ; Length of the message
  mov ecx, equal_msg                ; Message
  mov ebx, 1                        ; file descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt
  jmp exit_function                 ; Calling the exit_function

exit_function:
  ; Exiting the Program
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt
