format ELF64 executable         ; executable creates exe. leave this out if you want an .o file for linking
; segment readable executable   ; optional segment


entry start    ; entry defines our main starting point label

; ================================ print method ===============================
; put any value in rdi register and call this to print the decimals to stdout 
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

macro print_number var {
  mov rdi, QWORD [var]  ; put counter in rdi
  call print            ; prints value of a register in decimal format to stdout
}


; ============================== forloop macros ===============================
macro for var, start, end {
  mov QWORD [var], start
pos#var#_again:
  cmp QWORD [var], end
  jg pos#var#_over
}

macro endfor var {
  inc QWORD [var]
  jmp pos#var#_again
pos#var#_over:
}


; =========================== generic syscall macros ==========================
macro syscall1 call_id, arg1 {
    mov rax, call_id
    mov rdi, arg1
    syscall
}

macro syscall3 call_id, arg1, arg2, arg3 {
    mov rax, call_id  ; 1 == write call for a simple message string
    mov rdi, arg1     ; 1==stdout, 2=stderr
    mov rsi, arg2     ; message 
    mov rdx, arg3     ; message_len
    syscall           ; syscall execute with above params
}


;====================== write output macro ======================
macro write msg, msg_len {
  syscall3 1, 1, msg, msg_len
}

macro exit exit_code {
  syscall1 60, exit_code
}


; ===================== main starting point of execution ======================
start:
  for counter, 1, 5 
    print_number counter 
    write newline, 1

    for i, 1, 3 
      write message, message_len 
    endfor i
  endfor counter

  exit 0


; ========== allocate data for variables and strings ==========================
counter: dq 0
i: dq 0

message: file "message.txt"
message_len = $-message

newline: db 10



; public start   ; use this line when not having executable but lib and 
                 ; you want to export start as a function in a .o file.
