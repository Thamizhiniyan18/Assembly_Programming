%macro print 2
  mov edx, %1                           ; Length of the content
  mov ecx, %2                           ; Content
  mov ebx, 1                            ; File Descriptor (stdout)
  mov eax, 4                            ; sys_write
  int 0x80                              ; Kernel Interrupt
%endmacro

section .data
  pathname db "/home/thamizhiniyan/Documents/Assembly_Programming/File_Management/Opening_Reading_file/file.txt"

section .bss
  read_buffer resb 1024

section .text
  global _start

_start:
  ; Opening the file
  mov ecx, 0                        ; O_RDONLY; Open and read only
  mov ebx, pathname                 ; Path to the file
  mov eax, 5                        ; sys_open
  int 0x80                          ; Kernel Interrupt

  ; Reading from the file
  mov edx, 200                      ; Length of the bytes to be read
  mov ecx, read_buffer              ; Buffer to store the content
  mov ebx, eax                      ; File Descriptor (response of opening the file)
  mov eax, 3                        ; sys_read
  int 0x80                          ; Kernel Interrupt
  
  ; Printing the read_buffer
  print 1024, read_buffer

  ; Exiting the Program
  mov ebx, 0                        ; No Errors , return 0
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt
