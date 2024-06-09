%macro print 2
  mov edx, %1               ; Length of the message
  mov ecx, %2               ; Message
  mov ebx, 1                ; File Descriptor (stdout)
  mov eax, 4                ; sys_write
  int 0x80                  ; Kernel Interrupt
%endmacro

section .data
  pathname dd "/home/thamizhiniyan/Documents/Assembly_Programming/File_Management/Creating_Writing_file/file.txt"

  ; Closing the file
  mov ebx, eax                      ; File Descriptor (Response from writing the file)
  mov eax, 6                        ; sys_close
  int 0x80                          ; Kernel Interrupt

  file_content dd "Contents of the File is Written Successfully!!!!"
  file_content_length equ $- file_content

section .bss

section .text
  global _start

_start:
  ; Creating the file
  mov edx, 644o                     ; File Permissions in octal format
  mov ecx, 101o                     ; result of (O_CREAT or O_WRONLY) in octal format
  mov ebx, pathname                 ; Path of the file with name
  mov eax, 5                        ; sys_open
  int 0x80                          ; Kernel Call

  ; Writing to the file
  mov edx, file_content_length      ; Length of the content buffer
  mov ecx, file_content             ; content
  mov ebx, eax                      ; File descriptor (Response from creating the file)
  mov eax, 4                        ; sys_write
  int 0x80                          ; Kernel Interrupt

  ; Exiting the Program
  mov ebx, 0                        ; No Errors; return 0
  mov eax, 1                        ; sys_exit
  int 0x80                          ; Kernel Interrupt
