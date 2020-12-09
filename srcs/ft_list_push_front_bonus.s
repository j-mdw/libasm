# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_push_front_bonus.s                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:54:39 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:54:42 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: void ft_list_push_front(t_list **begin_list, void *data)  ;
;       t_list: struct {                                                            ;
;                    void    *data;                                                 ;
;                    t_list  *next;                                                 ;
;                    }	                                                            ;
;	Expected input:	rdi = **begin_list, rsi = *data                                 ;
;	Expected output: n/a                                                            ;
;	Clobbers:	rax, rcx                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern  malloc
                    global  ft_list_push_front
                    section .text

ft_list_push_front: push    rdi                 ; saving rdi (arg1)
                    push    rsi                 ; saving rsi (arg2)
                    mov     rdi, 16             ; size of a t_list element
                    call    malloc              ; allocates 16 bytes, returns address of first byte in rax
                    cmp     rax, 0              ; check if malloc returns 0 (= error)
                    jz      func_end            ; if malloc returned 0, return
                    pop     qword [rax]         ; saving arg2 (= void *data) in rax's bytes [0-8]
                    pop     rdi                 ; popping arg1 into rdi
                    mov     rcx, [rdi]          ; saving address of previous begin_list in rcx
                    mov     [rax + 8], rcx      ; saving rcx in rax bytes 8 - 15
                    mov     [rdi], rax          ; new allocated block saved at list begin

func_end:           ret                         ; return
