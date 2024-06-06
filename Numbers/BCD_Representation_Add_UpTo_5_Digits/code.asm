section .data
  msg db "The Sum is: "
  len equ $- msg
  num1 db '45321'
  num2 db '12345'
  sum db '     '
  sum_len equ $- sum

section .bss

section .text
  global _start                 ; Must be declared for using gcc

_start:                         ; tell linker entry point

  mov esi, 4                    ; Pointing to the Right most Digit
  mov ecx, 5                    ; counter for loop
  clc                           ; resets carry flag to 0

  _add_loop:
    mov al, [num1 + esi]        ; Moving the last digit of num1 to al
    adc al, [num2 + esi]        ; Adding the last digit of num2 to al
    aaa                         ; ASCII Adjust after Addition
    pushf                       ; copies the flag register at the top of the stack
    add al, '0'                 ; Decimal to ASCII
    popf                        ; retrieving the value of the flag register from the top of the stack

    mov [sum + esi], al
    dec esi
    loop _add_loop              ; loops through a sequence of instructions until ecx=0

  ; Priting the Message
  mov edx, len                  ; Length of the Message
  mov ecx, msg                  ; Message
  mov ebx, 1                    ; file descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Priting the Sum
  mov edx, sum_len              ; Length of the Sum
  mov ecx, sum                  ; Sum
  mov ebx, 1                    ; file descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt

  ; Exiting the program
  mov ebx, 0                    ; No errors; return 0
  mov eax, 1                    ; sys_exit
  int 0x80                      ; Kernel Interrupt

