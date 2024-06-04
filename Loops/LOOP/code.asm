section .data
  newline db 0xA

section .bss
  num resb 1

section .text
  global _start

_start:
  mov ecx, 10
  mov eax, '1'

    l1:
      mov [num], eax
      push ecx
    
      ; Printing the number
      mov edx, 1
      mov ecx, num
      mov ebx, 1
      mov eax, 4
      int 0x80
    
      ; Priting the newline
      mov edx, 1
      mov ecx, newline
      mov ebx, 1
      mov eax, 4
      int 0x80
    
      ; Incrementing the number
      mov eax, [num]
      sub eax, '0'
      inc eax
      add eax, '0'
    
      pop ecx
      loop l1

  ; Exiting the program
  mov ebx, 0                        ; no errors; return 0
  mov eax, 1                        ; sys_exit
  int 0x80
