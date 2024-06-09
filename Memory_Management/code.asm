%macro print 2
  mov edx, %1                   ; Length of the content
  mov ecx, %2                   ; Content
  mov ebx, 1                    ; File Descriptor (stdout)
  mov eax, 4                    ; sys_write
  int 0x80                      ; Kernel Interrupt
%endmacro

%macro exit 1
  mov ebx, %1                   ; exit code
  mov eax, 1                    ; sys_exit
  int 0x80                      ; Kernel Interrupt
%endmacro

section .data
  success_msg db "Memory Successfully Allocated!!!"
  success_msg_len equ $- success_msg
  
  error_msg db "Error Allocating the Memory!!!"
  error_msg_len equ $- error_msg

section .bss
  initial_break_address resd 1

section .text
  global _start

_start:
  ; Getting the current break address by providing an invalid break address.
  ; This will return the valid break address to the eax register.
  mov ebx, 0                    ; Invalid Break Address
  mov eax, 45                   ; sys_brk
  int 0x80                      ; Kernel Interrupt

  ; Storing the current break address
  mov [initial_break_address], eax

  ; Adding 20480 from the break address to allocate 20kb memory
  add eax, 20480

  ; Allocating 20kb memory on the heap
  mov ebx, eax                  ; Break Address
  mov eax, 45                   ; sys_brk
  int 0x80                      ; Kernel Call

  ; If Error Jumping to the error subroutine
  cmp eax, 0                    ; if eax is a negative value then there is a error in allocating memory
  jl _error                     ; if eax < 0, jump to _error

_if_not_error:
  ; If Not Error, Initialising the newly allocated memory by setting the entire 20kb with 0.
  ; This ensures that any data structures or variables that will be stored in this memory are initialized to zero,
  ; preventing any unpredictable behavior due to leftover data.

  ; setting edi to the initial break address to set each byte to 0 till all 20kb is set to 0
  mov edi, [initial_break_address]  
  mov ecx, 5120                     ; 20480 / 4 = 5120; No of DWORDs(32-bits) required; Counter for rep instruction
  xor eax, eax                      ; clearing eax (setting it to 0)
  rep stosd                         ; reapting the process of setting 0 (DWORD of 0s) by copying eax to edi 5120 times

  ; Printing the success message
  print success_msg_len, success_msg

_exit:
  ; Exiting the Program
  mov ebx, 0                    ; No Errors; return 0
  mov eax, 1                    ; sys_exit
  int 0x80

_error:
  ; Printing the error msg with error code
  print error_msg_len, error_msg
  jmp _exit
