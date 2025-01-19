format ELF64 executable  ; executable creates exe. leave it out if you want an .o file for linking
; segment readable executable ; optional segment


entry _start

; ==================== print method  ==================
; put value in rdi register, then call this and it
; prints the number
;
print:
    mov     r9, -3689348814741910323
    sub     rsp, 40
    mov     BYTE [rsp+31], 32  ; 10 for return, 32 for space
    lea     rcx, [rsp+30]
.L2:
    mov     rax, rdi
    lea     r8, [rsp+32]
    mul     r9
    mov     rax, rdi
    sub     r8, rcx
    shr     rdx, 3
    lea     rsi, [rdx+rdx*4]
    add     rsi, rsi
    sub     rax, rsi
    add     eax, 48
    mov     BYTE [rcx], al
    mov     rax, rdi
    mov     rdi, rdx
    mov     rdx, rcx
    sub     rcx, 1
    cmp     rax, 9
    ja      .L2
    lea     rax, [rsp+32]
    mov     edi, 1
    sub     rdx, rax
    xor     eax, eax
    lea     rsi, [rsp+32+rdx]
    mov     rdx, r8
    mov     rax, 1
    syscall
    add     rsp, 40
    ret


; ==================== main aka start =================
_start:
  ; int3 ; for debug
  ; initialize rcx to 5
  mov r15, 1 ; use r15 as a good reg which is not used often for a counter

again:
  cmp r15, 20 ; do it 20 times
  jg over ; also lte, gte, here we need greater than.
    mov rdi, r15 ; put counter in rdi
    call print ; print method used to print actual value of a register to stdout

    mov rax, 1 ; write call for a simple message string
    mov rdi, 1 ; 1==stdout, 2=stderr
    mov rsi, message
    mov rdx, message_len
    syscall    ; syscall write to print stdout
    inc r15    ; inc : +=1, dec : -=1
  jmp again

over:
  mov rax, 60 ; exit call
  mov rdi, 0
  syscall


message: file "message.txt"
message_len = $-message

; public _start   ; use when not having executable but lib and you want to 
; export start as a function in a .o file.
