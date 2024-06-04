section .data
  newline db 0xA

section .bss
  num resb 1

section .text
  global _start                     ; Must be declared for using gcc

_start:
  mov ecx, 10                       ; Initialising a counter of value 10
  mov eax, "1"

    L1:
      mov [num], eax                    ; Storing the number
      push ecx                          ; Pushing eax into the stack
    
      ; Printing the Number
      mov edx, 1                        ; Size of the number
      mov ecx, num                      ; number
      mov ebx, 1                        ; file descriptor (stdout)
      mov eax, 4                        ; sys_write
      int 0x80                          ; Kernel Interrupt
      
      ; Printing the Newline
      mov edx, 1                        ; Size of the newline
      mov ecx, newline                  ; newline
      mov ebx, 1                        ; file descriptor (stdout)
      mov eax, 4                        ; sys_write
      int 0x80                          ; Kernel Interrupt
    
      ; Incrementing the num
      mov eax, [num]                    ; moving number into eax register
      sub eax, "0"                      ; ASCII to Decimal
      inc eax                           ; Incermenting eax
      add eax, "0"                      ; Decimal to ASCII
    
      ; Reterieving ecx value from stack
      pop ecx                           ; Pop the stack and storing the value in ecx
      dec ecx                           ; Decrementing ecx
      jnz L1                            ; jumping to L1 if ecx is not 0

  ; Exiting the Program
  mov ebx, 0                        ; no errors; return 0    
  mov eax, 1                        ; sys_exit
  int 0x80
  
