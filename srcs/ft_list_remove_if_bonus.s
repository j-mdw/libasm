# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_remove_if_bonus.s                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:54:50 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:54:52 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: void    ft_list_remove_if(t_list **begin_list, \          ;
;                       void *data_ref, int (*cmp)(), void (*free_fct)(void *));    ;
;       t_list: struct {                                                            ;
;                    void    *data;                                                 ;
;                    t_list  *next;                                                 ;
;                    }	                                                            ;
;   Expected input:	rdi = t_list **begin_list, rsi = int (*cmp)()                   ;
;                   rdx = int (*cmp)(), rcx = void (*free_fct)(void *)              ;
;	Expected output: n/a                                                            ;
;	Clobbers:	rax, rcx                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern      ft_strlen
extern      ft_strcmp
                    global  ft_list_remove_if
                    section .text

ft_list_remove_if:  push    rbp                         ; saving bp
                    mov     rbp, rsp                    ; align sp and bp
                    sub     rsp, 64                     ; % 16
                    mov     qword [rbp - 32], rdi       ; saving arg1 in [24 - 32]
                    mov     qword [rbp - 24], rsi       ; saving arg2 in [16 - 24]
                    mov     qword [rbp - 16], rdx       ; saving arg3 in [8 - 16]
                    mov     qword [rbp - 8], rcx        ; saving arg4 in [0 - 8]
                    mov     rdx, qword [rdi]            ; loading address of 1st elem
                    mov     qword [rbp - 40], rdx       ; saving it in [32 - 40]
                    mov     qword [rbp - 48], qword 0   ; set [40 - 48] to 0
    check_elem:    
                    mov     rdx, qword [rbp - 40]       ; loading current elem in rdx
                    cmp     rdx, 0                      ; if current elem is
                                                        ; Null, end of list reached
                    jz      func_end                    ; end of function
                    
                    mov     rdi, qword [rdx]            ; saving elem->data in rdi before func call
                    mov     rsi, qword [rbp - 24]       ; setting rsi to arg2
                    call    qword [rbp - 16]            ; calling compare function
                    cmp     rax, 0                      ; if zero, we want to call free            
                    jz      remove_elem                 ; jmp to remove the elem

                    mov     rdx, qword [rbp - 40]       ; loading current elem into rdx
                    mov     qword [rbp - 48], rdx       ; saving 'previous elem' in [rbp - 48]
                    mov     rdx, qword [rdx + 8]        ; address of next element
                    mov     qword [rbp - 40], rdx       ; saving address of next elem in [rbp - 40] = address of current elem
                    jmp     check_elem                  ; loop

remove_elem:        mov     rdi, qword [rbp - 40]       ; element to be deleted
                    mov     rdi, qword [rdi]            ; setting rdi to elem->data
                    call    qword [rbp - 8]             ; calling free function
                    cmp     qword [rbp - 48], 0         ; check if we're at begining of list
                    jz      remove_first_elem
                    jnz     remove_other_elem

remove_first_elem:  mov     rdx, qword [rbp - 32]       ; loading begin_list into rdx
                    mov     rdi, qword [rbp - 40]       ; element to be deleted in rdi
                    mov     rcx, [rdi + 8]              ; elem_to_delete->next
                    mov     [rdx], rcx                  ; saving elem_to_delete->next at list start
                    mov     qword [rbp - 40], rcx       ; saving elem_to_delete->next as new current elem
                    call    qword [rbp - 8]             ; calling free function
                    jmp     check_elem                  ; checking next element

remove_other_elem:  mov     rdi, qword [rbp - 40]       ; element to be deleted in rdi
                    mov     rdx, [rdi + 8]              ; loading elem_to_delete->next into rdx
                    mov     qword [rbp - 40], rdx       ; setting new current elem to elem_to_delete->next
                    mov     rcx, qword [rbp - 48]       ; loading elem located before elem_to_delete into rcx
                    mov     qword [rcx + 8], rdx        ; setting prev_elem->next to elem_to_delete->next
                    call    qword [rbp - 8]             ; calling free function
                    jmp     check_elem                  ; checking next element

func_end:           leave                               ; releasing space
                    ret                                 ; returning
