section .data
  input_msg db "Enter a Number between 0-9: "
  input_len equ $- input_msg

  even_msg db "Given Number is Even.", 0xA, 0xD
  even_len equ $- even_msg

  odd_msg db "Given Number is Odd.", 0xA, 0xD
  odd_len equ $- odd_msg

section .bss
  number resb 2

section .text
  global _start

_start:
  ; Printing the Input Prompt
  mov edx, input_len                    ; Length of the Prompt
  mov ecx, input_msg                    ; Message
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernal Interrupt

  ; Reading the Input and storing it in number
  mov edx, 2                            ; length of the input
  mov ecx, number                       ; Variable to store
  mov ebx, 0                            ; file descriptor (stdin)
  mov eax, 3                            ; sys_read
  int 0x80                              ; Kernal Interrupt

  ; Checking whether the given number is even or odd
  sub byte [number], '0'                ; ASCII to Integer
  mov eax, [number]                     ; moving the number to the eax register
  and eax, 1                            ; Checking if the LSB of eax is 1
  jz even_function                      ; If 0 call even_function Else continue

  ; If 1 printing the odd_msg
  mov edx, odd_len                      ; Length of the message
  mov ecx, odd_msg                      ; Message
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernal Interrupt
  jmp exit_function                     ; Calling the exit function

exit_function:
  ; Exiting the Program
  mov eax, 1                            ; sys_exit
  int 0x80                              ; kernal Interrupt

even_function:
  ; Printing the even_msg
  mov edx, even_len                     ; Length of the message
  mov ecx, even_msg                     ; Message
  mov ebx, 1                            ; file descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt
  jmp exit_function                     ; calling the exit function
