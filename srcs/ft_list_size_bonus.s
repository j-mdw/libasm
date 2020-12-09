# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_list_size_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:55:00 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:55:02 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: int ft_list_size(t_list *begin_list)                      ;
;       t_list: struct {                                                            ;
;                    void    *data;                                                 ;
;                    t_list  *next;                                                 ;
;                    }	                                                            ;
;	Expected input:	rdi = t_list *begin_list                                        ;
;	Expected output: eax                                                            ;
;	Clobbers:	rax, rcx                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                global  ft_list_size
                section .text

ft_list_size:   xor     rcx, rcx        ; setting rcx to 0 (used to count nb of elem in list)

func_loop:      cmp     rdi, 0          ; checking if rdi is Null
                jz      func_end        ; if Null, end of list has been reached
                inc     rcx             ; +1 element
                mov     rdi, [rdi + 8]  ; setting rdi to address of next elem
                jmp     func_loop       ; looping

func_end:       mov     rax, rcx        ; set rax to nb of elem found
                ret                     ; return
