.intel_syntax noprefix
.data
print_int_format: .string        "%lld"
n1:     .fill   8000
num1:   .fill   8
        .fill   8000
num2:   .fill   8
res:    .fill   8000
        .fill 8000
div2_res: .fill 8
mul_temp_res: .fill 8000
mod_temp_res: .fill 8000
size1:  .fill   8
size2:  .fill   8
little_1: .fill 8000
little_1_backup: .fill 8000
little_2: .fill 8000
max:      .fill 8
min:      .fill 8
max_num:  .fill 8
sign1:      .fill 8
sign2:      .fill 8
res_sign:   .fill 8
res2_sign:   .fill 8
temp_res:   .fill 8
div_size:   .fill 8
yes:    .fill 8

.text
.globl asm_main
# .extern printf
# .extern scanf

# assume num1: r12:r13 
#        num2: r14:r15
# result: r12:r13

sum:
    mov rax, -8000
    neg rax
    mov rbp, 0
set_res_to_zero_sum:
    mov rbx, 0
    mov res[rbp], rbx
    add rbp, 8
    sub rax, 8
    cmp rax, 0
    jnz set_res_to_zero_sum

    mov rax, 1 # to store 1
    mov r11, sign1
    mov r12, sign2
    cmp r11, 0
    je pos1
neg1:
    cmp r12, 0
    je neg1pos2
neg12:
    mov res_sign, rax
    jmp rest
neg1pos2:
    mov rax, 0
    mov sign1, rax
    call sub

    mov r13, max
    neg r13
    add r13, 8
#    mov rdi, r13
#    call print_int
#    call print_nl
check_res:
    sub r13, 8
    cmp r13, -8
    je done_change
    mov rdi, res[r13]
#    mov rdi, r13
#    call print_int
#    call print_nl
    cmp rdi, 0
    je check_res
    add r13, 8
#    call print_int
    mov rax, res_sign
    cmp rax, 0
    je change
    mov rax, 0
    mov res_sign, rax
    jmp done_change
change:
    mov rax, 1
    mov res_sign, rax   
done_change:
    ret    

pos1:
    cmp r12, 0
    je rest
pos1neg2:
    mov rax, 0
    mov sign2, rax
    call sub
    ret 

rest:
    mov rbp, 0
    mov rdx, max
    mov rax, 0   # carry
loop_sum:    
    mov rbx, little_1[rbp]
    mov rcx, little_2[rbp]
    add rbx, rcx
    add rbx, rax
    mov rax, 0
    cmp rbx, 10
    jb continue_sum
    mov rax, 1
    sub rbx, 10
continue_sum:
    mov res[rbp], rbx
    add rbp, 8
    add rdx, 8
    cmp rdx, 8
    je done_sum
    jmp loop_sum
done_sum:    
    ret


sub:
    mov rax, 0
    mov res_sign, rax
    # az inja 
    mov rax, 1 # to store 1
    mov r11, sign1
    mov r12, sign2
    cmp r11, 0
    je spos1
sneg1:
    cmp r12, 0
    je sneg1pos2
sneg12:
    mov rax, 0
    mov sign2, rax
    call sum
    ret
sneg1pos2:
    mov rax, 0
    mov sign1, rax
    mov rax, 1
    mov res_sign, rax
    call sum
    ret    
spos1:
    cmp r12, 0
    je rest_sub
spos1neg2:
    mov rax, 0
    mov sign2, rax
    mov res_sign, rax
    call sum
    ret    

rest_sub:
    mov rbp, 0
    mov rdx, max
    mov rax, 0   # borrow
loop_sub:
    mov rbx, little_1[rbp]
    mov rcx, little_2[rbp]
#    mov rdi, rbx
#    ret
    sub rbx, rcx
    sub rbx, rax
    mov rax, 0
    cmp rbx, 0
    jge continue_sub
    mov rax, 1
    add rbx, 10
continue_sub:
    mov res[rbp], rbx
    add rbp, 8
    add rdx, 8
    cmp rdx, 8
    je done_sub
    jmp loop_sub
done_sub:
    cmp rax, 0
#    mov rdi, rax
#    ret
    je done_sub2
fix_sub:
    mov rdx, max
    neg rdx
    add rdx, 8
    mov rax, 1
    mov res_sign, rax
    mov rax, 0
    mov rdi, res[rax]
    neg rdi
    add rdi, 10
    mov res[rax], rdi
loop_fix:
    add rax, 8
    cmp rax, rdx
    je done_sub2
    mov rdi, res[rax]
    neg rdi
    add rdi, 9
    mov res[rax], rdi
    jmp loop_fix
done_sub2:
    ret


mul:
    mov rax, -8000
    neg rax

    mov rbp, 0
    mov r11, size1
    neg r11
    mif_1_zero:
    mov rbx, little_1[rbp]
    cmp rbx, 0
    jne set_res_to_zero
    add rbp, 8
    cmp rbp, r11
    jne mif_1_zero
    ret
    
    mov rbp, 0
    mov r11, size2
    neg r11
    mif_2_zero:
    mov rbx, little_2[rbp]
    cmp rbx, 0
    jne set_res_to_zero
    add rbp, 8
    cmp rbp, r11
    jne mif_2_zero
    ret

set_res_to_zero:
    mov rbx, 0
    mov res[rbp], rbx
    add rbp, 8
    sub rax, 8
    cmp rax, 0
    jnz set_res_to_zero

    mov rax, -8000
    neg rax
    mov rbp, 0
set_res_to_zero2:
    mov rbx, 0
    mov mul_temp_res[rbp], rbx
    add rbp, 8
    sub rax, 8
    cmp rax, 0
    jnz set_res_to_zero2
    
    mov rax, 0
    mov res_sign, rax
    mov r11, sign1
    mov r12, sign2
    cmp r11, 0
    je mpos1
mneg1:
    cmp r12, 0
    je mneg1pos2
mneg12:
    mov rax, 0
    mov res_sign, rax
    jmp rest_mul
        mneg1pos2:
    mov rax, 1
    mov res_sign, rax
    jmp rest_mul
    mpos1:
    cmp r12, 0
    je rest_mul
    mpos1neg2:
    mov rax, 1
    mov res_sign, rax

rest_mul:
    mov rbp, 0
    mov r12, 0
    mov rcx, size1
#    neg rcx
    mov rdi, size2
#    neg rdi
    mov rdx, max_num
    cmp rdx, 1
    je mul_loop1
    mov rcx, size2
#    neg rcx
    mov rdi, size1
#    neg rdi
    jmp mul_loop2
mul_loop1:  # max number is 1
    mov r15, 0
    mov r14, little_2[rbp]
    mov r12, 0
    mov rsi, 0
    mov rcx, size1
    mov r13, rbp
shift_mul:
    cmp r13, 0
    je inner_loop1
    mov rax, 0
    mov mul_temp_res[r12], rax
    add r12, 8
    sub r13, 8
    jmp shift_mul

    inner_loop1:
        mov r13, little_1[rsi]
        mov rax, r14
        mul r13  # res: rdx:rax
        add rax, r15  # add with carry
        mov r15, 0
        cmp rax, 10
        jb continue_mul
        mov r13, rax
        mov r15, 10
        cqo
        div r15
        mov r15, rax # carry
        mov rax, rdx # remainder
    continue_mul:
        mov mul_temp_res[r12], rax
        add r12, 8
        add rsi, 8
        add rcx, 8
        cmp rcx, 8
        je done_loop11
        jmp inner_loop1
done_loop11:
    mov rax, 0
addition_loop:
    mov rsi, 0
    mov rdx, -8000
    mov rax, 0   # carry
mloop_sum:    
    mov rbx, mul_temp_res[rsi]
    mov rcx, res[rsi]
    add rbx, rcx
    add rbx, rax
    mov rax, 0
    cmp rbx, 10
    jb mcontinue_sum
    mov rax, 1
    sub rbx, 10
mcontinue_sum:
    mov res[rsi], rbx
    add rsi, 8
    add rdx, 8
    cmp rdx, 0
    je mdone_sum
    jmp mloop_sum
mdone_sum:
#    mov r14, res
    add rbp, 8
    add rdi, 8
    cmp rdi, 0
    je  mul_done
    jmp mul_loop1

mul_loop2:
    mov r15, 0
    mov r14, little_1[rbp]
    mov r12, 0
    mov rsi, 0
    mov rcx, size2
    mov r13, rbp
mshift_mul:
    cmp r13, 0
    je minner_loop1
    mov rax, 0
    mov mul_temp_res[r12], rax
    add r12, 8
    sub r13, 8
    jmp mshift_mul

    minner_loop1:
        mov r13, little_2[rsi]
        mov rax, r14
        mul r13  # res: rdx:rax
        add rax, r15  # add with carry
        mov r15, 0
        cmp rax, 10
        jb mcontinue_mul
        mov r13, rax
        mov r15, 10
        cqo
        div r15
        mov r15, rax # carry
        mov rax, rdx # remainder
    mcontinue_mul:
        mov mul_temp_res[r12], rax
        add r12, 8
        add rsi, 8
        add rcx, 8
        cmp rcx, 8
        je mdone_loop11
        jmp minner_loop1
mdone_loop11:
    mov rax, 0
maddition_loop:
    mov rsi, 0
    mov rdx, -8000
    mov rax, 0   # carry
mmloop_sum:    
    mov rbx, mul_temp_res[rsi]
    mov rcx, res[rsi]
    add rbx, rcx
    add rbx, rax
    mov rax, 0
    cmp rbx, 10
    jb mmcontinue_sum
    mov rax, 1
    sub rbx, 10
mmcontinue_sum:
    mov res[rsi], rbx
    add rsi, 8
    add rdx, 8
    cmp rdx, 0
    je mmdone_sum
    jmp mmloop_sum
mmdone_sum:
#    mov r14, res
    add rbp, 8
    add rdi, 8
    cmp rdi, 0
    je  mul_done
    jmp mul_loop2
mul_done:
    ret


div2:
    mov rax, size1
    mov rbx, size2
    cmp rbx, rax
    je equal
    jg div2_rest
    mov rbp, 0
        final_loopppp:
            mov r12, little_1[rbp]
            mov mod_temp_res[rbp], r12
            add rbp, 8
            cmp rbp, 8000
            jne final_loopppp
    ret

equal:
    mov rdi, 1
    mov yes, rdi
    call div
    ret
    # age size1 > size2
div2_rest:
    mov rax, 0
    mov res2_sign, rax
    mov r11, sign1
    mov r12, sign2
    cmp r11, 0
    je d2pos1
d2neg1:
    cmp r12, 0
    je d2neg1pos2
d2neg12:
    mov rax, 0
    mov res2_sign, rax
    jmp rest_div2
d2neg1pos2:
    mov rax, 1
    mov res2_sign, rax
    jmp rest_div2
d2pos1:
    cmp r12, 0
    je rest_div2
d2pos1neg2:
    mov rax, 1
    mov res2_sign, rax

rest_div2:
    mov rax, size1
    mov rbx, size2
    sub rax, rbx
    neg rax
    xor rdx, rdx
    mov rdi, 8
    div rdi # rax = size1 - size2   
    mov rcx, rax #loop zadan
    mov r11, rax #save the ekhtelaf
    mov r12, r11
    mov r14, r11

    mov rax, size2
    neg rax
    xor rdx, rdx
    mov rdi, 8
    div rdi # rax = size2

    mov rax, r11
    mov rdi, 8
    mul rdi
    mov r11, rax

    mov rbx, size2
    neg rbx
    sub rbx, 8
    mov rbp, rbx
    add rbp, 8

    mov rsi, rbx
    mov r11, rbp
    sub rsi, 8
    sub r11, 8

    loop11:
        add r11, 8
        add rsi, 8
        mov rbp, r11
        mov rbx, rsi
        loop12:
            mov rdi, little_2[rbx]
            mov little_2[rbp], rdi
            sub rbp, 8
            sub rbx, 8
            cmp rbx, -8
            jne loop12
    #    add r11, 8
        loop loop11
        mov rbp, 0
        
    loop22:
        mov rdi, 0
        mov little_2[rbp], rdi
        add rbp, 8
        dec r12
        cmp r12, 0
        jne loop22

    mov r11, 0 # dont change
    inc r14

    call_loop:
        mov rbp, 0
        backup_loop:
            mov r12, little_1[rbp]
            mov little_1_backup[rbp], r12
            add rbp, 8
            cmp rbp, 8000
            jne backup_loop

        call div

        mov r12, res
        mov div2_res[r11], r12
        add r11, 8 
        
        mov rbp, 0
        get_back_num1:
            mov r12, little_1_backup[rbp]
            mov little_1[rbp], r12
            add rbp, 8
            cmp rbp, 8000
            jne get_back_num1

        call my_mod
        
        mov rbp, 0
        save_resmod:
            mov r12, res[rbp]
            mov little_1[rbp], r12
            add rbp, 8
            cmp rbp, 8000
            jne save_resmod
        

        mov rbp, 8
        mov rdx, 0
        taghsim_bar_dah:
            mov r12, little_2[rbp]
            mov little_2[rdx], r12
            add rbp, 8
            add rdx, 8
            cmp rbp, 7992
            jne taghsim_bar_dah

        dec r14
        cmp r14, 0
        jg call_loop
        

    div2_done:
        mov rbp, 0
        final_loopp:
            mov r12, little_1[rbp]
            mov mod_temp_res[rbp], r12
            add rbp, 8
            cmp rbp, 8000
            jne final_loopp


        mov div_size, r11
        sub r11, 8
        mov rbp, 0
        final_loop:
            mov r12, div2_res[r11]
            mov res[rbp], r12
            sub r11, 8
            add rbp, 8
            cmp r11, -8
            jne final_loop
        # save temp res to res
        mov rdi, res2_sign
        mov res_sign, rdi
        ret


div:
    push r14
    push r11
    
    mov rax, 0
    mov rbp, 0
    mov r11, size1
    neg r11
    
    if_1_zero:
    mov rbx, little_1[rbp]
    cmp rbx, 0
    jne baghie
    add rbp, 8
    cmp rbp, r11
    jne if_1_zero
    mov rdi, 0
    mov mod_temp_res, rdi
    pop r11
    pop r14
    ret

baghie:
    mov rax, 0
    mov res_sign, rax
    mov r11, sign1
    mov r12, sign2
    cmp r11, 0
    je dpos1
dneg1:
    cmp r12, 0
    je dneg1pos2
dneg12:
    mov rax, 0
    mov res_sign, rax
    jmp rest_div
dneg1pos2:
    mov rax, 1
    mov res_sign, rax
    jmp rest_div
dpos1:
    cmp r12, 0
    je rest_div
dpos1neg2:
    mov rax, 1
    mov res_sign, rax

rest_div:
    mov r14, res_sign
    mov temp_res, r14
    mov r14, 0 # tedade menha
    mov sign1, r14
    mov sign2, r14
    div_loop:
        call sub
        mov rbx, res_sign
        cmp rbx, 1
        jz div_done
        add r14, 1
        mov rbp, 0
        mov rcx, max
        mov_res_to_number1:
            mov rbx, res[rbp]
            mov little_1[rbp], rbx
            add rbp, 8
            add rcx, 8
            cmp rcx, 0
            jnz mov_res_to_number1
        jmp div_loop

div_done: # javab dakhele r14
    mov rbp, 0
    mov rax, 8000
    div_set_res_to_zero:
        mov rbx, 0
        mov res[rbp], rbx
        add rbp, 8
        sub rax, 8
        cmp rax, 0
        jnz div_set_res_to_zero

    mov rbp, temp_res
    mov res_sign, rbp
    mov rbp, 0
#    mov res[rbp], r14
#    ret
    for_loop_div:
        mov rax, r14
        mov r15, 10
        xor rdx, rdx
        div r15
        mov res[rbp], rdx
        cmp rdx, r14
        je for_base
        add rbp, 8
        mov r14, rax
        jmp for_loop_div
for_base:
    pop r11
    pop r14
    ret


my_mod:
    push r14
    push r11
    mov rax, 0
    mov rbp, 0
    mov r11, size1
    neg r11
    if_1_zerom:
    mov rbx, little_1[rbp]
    cmp rbx, 0
    jne baghiem
    add rbp, 8
    cmp rbp, r11
    jne if_1_zerom
    pop r11
    pop r14
    ret
baghiem:
    mov rax, 0
    mov res_sign, rax
    mov r11, sign1
    mov r12, sign2
    cmp r11, 0
    je mdpos1
mdneg1:
    cmp r12, 0
    je mdneg1pos2
mdneg12:
    mov rax, 0
    mov res_sign, rax
    jmp rest_mod
mdneg1pos2:
    mov rax, 1
    mov res_sign, rax
    jmp rest_mod
mdpos1:
    cmp r12, 0
    je rest_mod
mdpos1neg2:
    mov rax, 1
    mov res_sign, rax

rest_mod:
    mov r14, res_sign
    mov temp_res, r14
    mov r14, 0 # tedade menha
    mov sign1, r14
    mov sign2, r14
    mod_loop:
        call sub
        mov rbx, res_sign
        cmp rbx, 1
        jz mod_done
        add r14, 1
        mov rbp, 0
        mov rcx, max
        mod_res_to_number1:
            mov rbx, res[rbp]
            mov little_1[rbp], rbx
            add rbp, 8
            add rcx, 8
            cmp rcx, 0
            jnz mod_res_to_number1
        jmp mod_loop

mod_done:
    mov rbp, 0
    mov rax, 8000
    mod_set_res_to_zero:
        mov rbx, 0
        mov res[rbp], rbx
        add rbp, 8
        sub rax, 8
        cmp rax, 0
        jnz mod_set_res_to_zero

    mov rbp, temp_res
    mov res_sign, rbp
#    mov res[rbp], r14
#    ret
    mov rbp, 0
    mov rcx, -8000
    fmod_res_to_number1:
        mov rbx, little_1[rbp]
        mov res[rbp], rbx
        add rbp, 8
        add rcx, 8
        cmp rcx, 0
        jnz fmod_res_to_number1
        pop r11
        pop r14
        ret

print_int:
    push rsi
    push rax

    sub rsp, 8
    mov rsi, rdi
    mov rdi, offset print_int_format
    mov rax, 1 # setting rax (al) to number of vector inputs
    call printf
    add rsp, 8

    pop rax
    pop rsi
    ret

print_nl:
    sub rsp, 8

    mov rdi, 10
    call putchar
    
    add rsp, 8 # clearing local variables from stack

    ret

read_char:
    sub rsp, 8

    call getchar

    add rsp, 8 # clearing local variables from stack

    ret

print_char:
    sub rsp, 8

    call putchar
    
    add rsp, 8 # clearing local variables from stack
    ret

clear_memory:
    mov rax, -8000
    neg rax
    mov rbp, 0
main_set_res_to_zero:
    mov rbx, 0
    mov mul_temp_res[rbp], rbx
    mov num1[rbp], rbx
    mov num2[rbp], rbx
    mov little_1[rbp], rbx
    mov little_2[rbp], rbx
    mov res[rbp], rbx
    add rbp, 8
    sub rax, 8
    cmp rax, 0
    jnz main_set_res_to_zero
    ret
asm_main:
	push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    # --------------------------------------------------
    mov rbp, -8
    mov r15, 1 # to store 1
#    mov r14, 0 # to store 0

main_start:
    mov rbp, -8
    mov r14, 0
    mov max, r14
    mov min, r14
    mov sign1, r14
    mov sign2, r14
    mov res_sign, r14
    call read_char
    mov r12, rax
    call read_char
    cmp r12, 'q'
    jz done2
#    cmp rbx, 'x'
#    jz mul
#    cmp rbx, '/'
#    jz div
#    jmp main_start

input_num1:
    call read_char
    cmp rax, '\n'
    je input_num2
    cmp rax, '-'
    jne pos
    mov r15, 1
    mov sign1, r15
    jmp input_num1
pos:
    sub rax, 48
    mov num1[rbp], rax
    sub rbp, 8
    jmp input_num1

input_num2:
    add rbp, 8
    mov size1, rbp
#    mov rdi, size1
#    call print_int
    mov rbp, -8
input_loop:
    call read_char
    cmp rax, '\n'
    je input_done
    cmp rax, '-'
    jne pos2
    mov r15, 1
    mov sign2, r15
    jmp input_loop
pos2:
    sub rax, 48
    mov num2[rbp], rax
    sub rbp, 8
    jmp input_loop

input_done:
    add rbp, 8
    mov size2, rbp
    mov rbp, size1
    mov rax, 0
loop:
    mov rdi, num1[rbp]
    mov little_1[rax], rdi
    add rax, 8
    cmp rbp, 0
    je loop2
#    call print_int
    add rbp, 8
    jmp loop

loop2:
    mov rbp, size2
    mov rax, 0
loop3:
    mov rdi, num2[rbp]
    mov little_2[rax], rdi
    add rax, 8
    cmp rbp, 0
    je done
#    call print_int
    add rbp, 8
    jmp loop3

done:
#    mov rdi, size1
#    call print_int
#    mov rdi, size2
#    call print_int
    mov rax, 2
    mov max_num, rax
    mov rdx, size2
    mov rax, size1
    cmp rdx, size1
    jle set1
    mov rax, 1
    mov max_num, rax
    mov rax, size2
    mov rdx, size1
set1:
    mov min, rax
    mov max, rdx
    cmp r12, '+'
    jz summ
    cmp r12, '-'
    jz subb
    cmp r12, '*'
    jz mull
    cmp r12, '/'
    jz divv
    cmp r12, '%'
    jz modd
    jmp main_start

modd:
    mov r13, sign1
    mov rdi, 0
    if_equal:
        mov rbp, little_1[rdi]
        cmp little_2[rdi], rbp
        jne restmod
        add rdi, 8
        cmp rdi, 8000
        jne if_equal
        mov r12, 0
        mov res, r12
        mov res_sign, r13
        jmp print_res
        
restmod:
    mov rdi, 0
    mov yes, rdi
    call div2
    mov rdi, 1
    cmp rdi, yes
    jne noo
    call my_mod
    mov res_sign, r13
    jmp print_res
noo:
    mov rbp, 0
    final_looppp:
        mov r12, mod_temp_res[rbp]
        mov res[rbp], r12
        add rbp, 8
        cmp rbp, 8000
        jne final_looppp

    mov res_sign, r13
    jmp print_res
mull:
    call mul
    jmp print_res
#    call print_int

divv:
    call div2
#    call my_mod
#    call print_int
#    call print_nl
#    jmp print_res
#    call div
    jmp print_res



subb:
#    mov rdi, little_1
#    call print_int
#    mov rdi, max
#    call print_int
#    mov rdi, min
#    call print_int
    call sub
#    call print_int
#    call print_nl
    jmp print_res

summ:
#    mov rdi, sign1
#    call print_int
#    mov rdi, sign2
#    call print_int
    call sum

print_res:
    mov r13, max
    neg r13
    add r13, r13
    add r13, 8
#    mov rdi, r13
#    call print_int
#    call print_nl
    mov rbx, max
    mov rdi, res_sign
    cmp rdi, 0
    je pos_res
    mov rdi, 0
    mov rbp, 0
    zero_res:
        cmp res[rbp], rdi
        jne not_pos_res
        add rbp, 8
        cmp rbp, 8000
        jne zero_res
        jmp pos_res
    not_pos_res:
        mov rdi, '-'
        call print_char
pos_res:
    sub r13, 8
    cmp r13, -8
    je print_zero_done
    mov rdi, res[r13]
#    mov rdi, r13
#    call print_int
#    call print_nl
    cmp rdi, 0
    je pos_res
    add r13, 8
#    call print_int
    
print_loop:
    sub r13, 8
    mov rdi, res[r13]
    call print_int
#    sub r13, 8
    cmp r13, 0
    je print_sum_done
    jmp print_loop
print_zero_done:
    mov rdi, 0
    call print_int
print_sum_done:
    call print_nl
    call clear_memory
    jmp main_start



done2:
    # --------------------------------------------------
    add rsp, 8
	pop r15
	pop r14
	pop r13
	pop r12
    pop rbx
    pop rbp

	ret