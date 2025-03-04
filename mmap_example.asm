format ELF64 executable  ; Specify the output format

entry start    ; entry defines our main starting point label

start:
    ; Call mmap to allocate memory
    mov rax, 9           ; syscall number for mmap
    xor rdi, rdi         ; addr = NULL (let the kernel choose the address)
    mov rsi, 1024000        ; length = 1024 (1 KB)
    mov rdx, 3           ; prot = PROT_READ | PROT_WRITE
    mov r10, 34          ; flags = MAP_PRIVATE | MAP_ANONYMOUS
    xor r8, r8           ; fd = -1 (not backed by a file)
    xor r9, r9           ; offset = 0
    syscall               ; invoke the syscall

    ; Check if mmap failed
    cmp rax, -1
    je .error            ; Jump to error handling if mmap failed

    ; rax now contains the pointer to the allocated memory
    ; You can use the allocated memory here

    ; Exit the program
    mov rax, 60           ; syscall number for exit
    mov rdi, 0            ; exit code 0
    syscall               ; invoke the syscall

.error:
    ; Handle error (exit with code 1)
    mov rax, 60          ; syscall number for exit
    mov rdi, 1           ; exit code 1
    syscall               ; invoke the syscall

