# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strdup.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:55:47 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:55:48 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: char *ft_strdup(const char *s)        ;
;	Expected input:	rdi = s                                     ;
;	Expected output: rax                                        ;
;	Clobbers:	rax, rcx, rdx                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern  malloc
extern  ft_strlen
extern  ft_strcpy

            global  ft_strdup
            section .text

ft_strdup:  push    rdi         ; saving rdi (= str to duplicate)
            call    ft_strlen   ; len of rdi
            mov     rdi, rax    ; saving strlen return value in rdi
            call    malloc      ; allocating len bytes
            mov     rdi, rax    ; saving address of allocated bytes in rdi
            pop     rsi         ; popping saved str into rsi
            call    ft_strcpy   ; copying rsi = str in rdi = allocated memory
            ret                 ; return
