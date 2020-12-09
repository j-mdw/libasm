# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_sort_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:55:09 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:55:10 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: void ft_list_sort(t_list **begin_list, int (*cmp)())      ;
;       t_list: struct {                                                            ;
;                    void    *data;                                                 ;
;                    t_list  *next;                                                 ;
;                    }	                                                            ;
;   Expected input:	rdi = t_list **begin_list, rsi = int (*cmp)()                   ;
;	Expected output: n/a                                                            ;
;	Clobbers:	rax, rcx                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern          ft_list_size

                global  ft_list_sort
                section .text

ft_list_sort:   push    rbp                         ; saving bp
                mov     rbp, rsp                    ; aligning bp and sp
                sub     rsp, 64                     ; reserving 64 bytes (% 16)
                mov     qword [rbp - 8], rdi        ; saving rdi in bytes [0 - 8]
                mov     qword [rbp - 16], rsi       ; saving rsi in bytes [8 - 16]
                mov     rdi, [rdi]                  ; setting rdi to the address of the first elem of the list
                call    ft_list_size                ; getting size of list, which takes rdi as argument
                cmp     rax, 2                      ; check if less than 2 elem...
                jl      func_end                    ; ...in which case, nothing to sort
                mov     qword [rbp - 24], rax       ; moving list size to bytes [16 - 24]

                ; in sort_loop, we know for sure that we have at least 2 elements
                ; so it is not required to check at this stage if elem or
                ; elem->next exists as we know they do. This will subsequently
                ; be done in 'move_next'
sort_loop:      dec     qword [rbp - 24]            ; loop runs n-1 time
                cmp     qword [rbp - 24], 0         ; checking if rcx is 0
                jl      func_end                    ; sorting is complete
                mov     r8, qword [rbp - 8]         ; lst_begin**
                mov     r8, [r8]                    ; address of elem 1 in r8
                mov     r9, [r8 + 8]                ; address of next elem in r9
                mov     qword [rbp - 32], qword 0   ; setting bytes [24 - 32] to 0

loop_compare:   mov     rdi, [r8]                   ; setting rdi for function call
                mov     rsi, [r9]                   ; setting rsi for function call
                call    qword [rbp - 16]            ; calling function passed in arg2
                sub     eax, 0                      ; comparing function call return value to 0 - setting flags
                jg      switch_elem                 ; if first elem greater than 2nd elem, switch them

move_next:      mov     qword [rbp - 32], qword r8  ; setting bytes [24 - 32] (='previous elem') to r8
                mov     r8, r9                      ; moving r8 to next elem
                mov     r9, [r9 + 8]                ; moving r9 to the elem after it
                cmp     r9, 0                       ; is the next elem 0? Meaning we reached end of list
                jz      sort_loop                   ; then go back to 'sort_loop'
                jnz     loop_compare                ; if not end of list, compare elems in r8 and r9

switch_elem:    mov     rax, [r9 + 8]               ; storing address of next elem pointed to by r9
                mov     [r8 + 8], rax               ; saving address of r9 next elem to r8 next elem
                mov     [r9 + 8], r8                ; saving address of r8 to r9 next elem
                cmp     qword [rbp - 32], 0         ; if 0, we're on the 1st element of the list
                je      set_beg_list                ; if 1st elem, we then set *arg1 to it
                jne     set_prev_elem               ; otherwise, we set r12->next to r8

set_beg_list:   mov     rax, qword [rbp - 8]        ; set rax to begin_list**
                mov     [rax], r9                   ; setting 1st elem of the list to be r9
                mov     rdx, r8                     ; switching r8 and r9: 1. saving r8 in rdx
                mov     r8, r9                      ; 2. setting r8 to r9
                mov     r9, rdx                     ; 3. saving address previously saved in rdx into r9                
                jmp     move_next

set_prev_elem:  mov     rax, qword [rbp - 32]       ; setting rax to 'previous elem'
                mov     [rax + 8], r9               ; set previous element's next * to r9
                mov     rax, r8                     ; switching r8 and r9: 1. saving r8 on the stack
                mov     r8, r9                      ; 2. setting r8 to r9
                mov     r9, rax                     ; 3. poping address previously saved in r8 into r9
                jmp     move_next                
    
func_end:       leave                               ; releasing space
                ret                                 ; return
