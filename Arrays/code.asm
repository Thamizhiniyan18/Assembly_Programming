section .data
  msg db "The sum of the array is: "
  len equ $- msg

  array db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  array_len equ $- array

  ten dd 10                             ; constant for division

section .bss
  sum resb 4
  sum_string resb 12                    ; Buffer to store the ASCII representation of the sum

section .text
  global _start

_start:
  xor ecx, ecx                          ; Clear the ecx register
  mov ecx, array_len                    ; Length of the Array
  xor ebx, ebx                          ; Clear the ebx register to store the sum
  mov esi, array                        ; esi points to the array

_add_loop:
  add bl, [esi]                         ; adding the current element value of the array to bl (use bl for 8bit calculation)
  inc esi                               ; Moving the pointer to the next element of the array
  loop _add_loop                        ; decrementing ecx and jumping to _loop
  
  mov [sum], ebx                        ; Storing the sum to the variable
  
  ; Printing the Message
  mov edx, len                          ; Length of the message
  mov ecx, msg                          ; The Message
  mov ebx, 1                            ; File Descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernerl Interrupt

  ; Convert the sum to ASCII String
  mov eax, [sum]                        ; Load the sum to eax register
  xor edi, edi                          ; clear the edi register to use it as index for sum_string

_decimal_to_ascii:
  xor edx, edx                          ; clear edx to hold the remainder
  div dword [ten]                       ; Dividing the eax by 10; eax=quotient; edx=remainder
  add dl, '0'                           ; Convert remainder to ASCII
  mov [sum_string + edi], dl            ; Store the ASCII character in sum_string
  inc edi                               ; Increment the index
  test eax, eax                         ; Check if eax (quotient) is zero
  jnz _decimal_to_ascii                 ; If not zero, repeat the loop

  ; Reversing the String
  mov ecx, edi                          ; ecx = Length of the sum_string
  dec edi                               ; Adjusting the edi register to point the last character of the string
  xor esi, esi                          ; esi = 0; start of the string

_reversing_the_string:
  mov al, [sum_string + esi]               ; first character of the sum_string
  mov bl, [sum_string + edi]               ; last character of the sum_string
  mov [sum_string + esi], bl               ; swapping the first and last character
  mov [sum_string + edi], al               ; swapping the first and last character
  inc esi                               ; Move Forward
  dec edi                               ; Move Backward
  cmp esi, edi                          ; compare positions
  jl _reversing_the_string              ; Repeat the loop until the middle number is reached i.e, repeat if esi < edi

  ; Printing the sum string
  mov edx, ecx                          ; Length of the sum string
  mov ecx, sum_string                   ; sum string
  mov ebx, 1                            ; File Descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt

  ; Exiting the Program
  mov ebx, 0                            ; No Errors, Return 0
  mov eax, 1                            ; sys_exit
  int 0x80                              ; Kernel Interrupt
