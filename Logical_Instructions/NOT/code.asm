section .data

section .bss
  res resb 3  ; Reserve 3 bytes to store the result and the null terminator

section .text
  global _start                     ; Must be declared for using gcc

_start:
  mov eax, 0b01010011               ; Move 01010011 (83) to eax register
  not eax                           ; Bitwise NOT operation, eax = 0b10101100
  and eax, 0xff                     ; Mask to keep only the lower 8 bits, eax = 0b10101100 (172)
  
  ; Convert the result to ASCII string
  mov ebx, eax                      ; Copy eax to ebx for processing
  add bl, '0'                       ; Convert the lower byte to ASCII
  mov [res], bl                     ; Store the ASCII character in res
  
  mov byte [res+1], 0xA             ; Add newline character
  mov byte [res+2], 0x0             ; Add null terminator

  ; Printing the result
  mov edx, 2                        ; Size of the result plus newline
  mov ecx, res                      ; Result
  mov ebx, 1                        ; File descriptor (stdout)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Exiting the Program
  mov eax, 1                        ; sys_exit
  xor ebx, ebx                      ; Exit code 0
  int 0x80                          ; Kernel Interrupt
