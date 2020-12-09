# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_write.s                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:56:12 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:56:21 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: ssize_t ft_write(int fd, const void *buf, size_t count);  ;
;	Expected input:	rdi = fd, rsi = buf, rdx = count                                ;
;	Expected output: rax                                                            ;
;	Clobbers:	rax, rcx                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern  __errno_location

            global  ft_write
            section .text

ft_write:   mov     rax, 1              ; set rax to 1 (syscall index for write)
            syscall                     ; write syscall, with arguments rdi = fd,
                                        ; rsi = buf and rdx = count
            xor     rcx, rcx            ; set rcx to 0
            cmp     rax, rcx            ; compare the return value to 0
            jl     error                ; if lower than 0, an error occurred
            ret                         ; else, return

error:      
            not     rax                 ; changing sign of rax 1/2
            inc     rax                 ; changing sign of rax 2/2
            mov     rcx, rax            ; error code into rax
            call    __errno_location    ; getting address of errno
            mov     [rax], rcx          ; saving error code at errno location
            mov     rax, -1             ; set rax to -1 (return value for error)
            ret                         ; return
