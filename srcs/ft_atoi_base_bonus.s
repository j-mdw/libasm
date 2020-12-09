# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_atoi_base_bonus.s                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jmaydew <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 13:54:28 by jmaydew           #+#    #+#              #
#    Updated: 2020/12/08 13:58:50 by jmaydew          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	C Function prototype: int ft_atoi_base(char *str, char *base)	;
;	Expected input:	rdi = str, rsi = base						    ;
;	Expected output: rax			    							;
;	Clobbers:	rax, rcx, rdx, r8, r9	    						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern          ft_strlen

                global      ft_atoi_base
				section		.text

ft_atoi_base:	push 		rbx						; saving rbx

base_len:       mov         r8, rdi                 ; saving rdi in r8
                mov         rdi, rsi                ; base in rdi 
                call        ft_strlen               ; computing len of base
                cmp         rax, 2                  ; compare base len to 2
                jl          base_error              ; if base len lower than 2, return an error
                mov         r9, rax                 ; setting r9 to len
                mov         rdx, rax                ; setting rdx to len
                mov         bl, '+'                 ; setting bl to '+'
                mov         bh, '-'                 ; setting bh to '-'       

base_char:      dec         rdx                     ; rdx -= 1 (index of last char in base)     
                mov         al, byte [rsi + rdx]    ; set al to base + r9 (= starting at end of string)
                cmp         al, bl                  ; is base + rdx == '+'?
                jz          base_error              ; error
                cmp         al, bh                  ; is base + rdx == '-'?
                jz          base_error              ; error

                mov         rcx, 6                  ; setting rcx to nb of whitespaces for 'rep' instruction
                mov         rdi, whitespaces        ; setting rdi to whitespaces variable 
                repnz       scasb                   ; scans rdi (which contains whitspaces) for al (= base + rdx),
                                                    ; sets ZF if a match is found with al
                jz          base_error              ; error if whitespace found
                cmp         rdx, 0                  ; loops until rdx == 0
                jnz         base_char               ; loop
                xor         rcx, rcx                ; rcx = 0
                xor         rbx, rbx                ; rbx = 0
                mov         bl, byte 1              ; used in coutn_occur
                
base_doubles:   ; rcx used as counter
                mov         al, byte [rsi + rcx]    ; getting one char at a time
                inc         rcx                     ; initially set to 0
                xor         rdx, rdx                ; rdx = 0 
                cmp         al, 0                   ; end of base ?
                jnz         count_occur             ; count how many times a char appears
                xor         rdx, rdx                ; rdx = 0, used in parse_str
                xor         rbx, rbx                ; rbx = 0, used in parse_str
                jmp         parse_str               ; parse str
                
count_occur:    ; rbx used as counter
                mov         dh, byte 0              ; bh = 0
                cmp         al, byte [rsi + rbx]     ; comparing a char to the string, ckecking if it appears more than twice
                sete        dh                      ; if char found, set bh to 1
                add         dl, dh                  ; adding bh to dl, with dl set to 0 before entering count_occur
                cmp         dl, byte 2              ; if dl is 2, we found a char twice
                jz          base_error              ; in which case, error
                inc         rbx                      ; r9 += 1
                cmp         byte [rsi + rbx], byte 0 ; reached end of base?
                jz          base_doubles            ; if so, jump back to base_doubles
                jmp         count_occur             ; loop

base_error:
                xor         rax, rax                ; set rax to 0
                pop         rbx                     ; pop rbx (pushed at beg. of func)
                ret                                 ; return

parse_str:      mov         rcx, 6                  ; number of whitespaces to check
                mov         al, byte [r8 + rdx]     ; load str char into al
                inc         rdx                     ; rdx += 1
                mov         rdi, whitespaces        ; setting rdi to whitespaces variable 
                repnz       scasb                   ; checking if str + rdx is a whitespace
                jz          parse_str               ; parse string
                dec         rdx                     ; rdx -= 1
                mov         rbx, 1                  ; used for int sign

get_sign:       mov         al, byte [r8 + rdx]     ; set al to str + rdx
                inc         rdx                     ; rdx += 1
                cmp         al, byte '-'            ; is str + rdx == '-'
                jz          change_sign             ; if so, change sign
                cmp         al, byte '+'            ; is str + rdx == '+'
                jz          get_sign                ; if so, loop
                cmp         al, 0                   ; end of str?
                jz          func_end                ; return
                dec         rdx                     ; rdx -= 1
                xor         rax, rax                ; used in compute_int to store int
                xor         rcx, rcx                ; used in compute_int for value to add
                mov         rdi, r8                 ; saving str in rdi
                xor         r8, r8                  ; r8 = 0
                jmp         compute_int             ; compute integer

change_sign:    not         rbx                     ; equivalent to *= -1 step 1/2
                inc         rbx                     ; step 2/2
                jmp         get_sign                ; loop

compute_int:    ; rcx = 0
                ; r8 = 0
                ; r9 = base len
                ; rsi = base
                ; rdi = str
                ; rdx = current position in str
                ; ZF = comparison al, '+'
                ; rbx = -1/1 sign
                ; rax = 0, will be used to store expected result/base in decimal
                push        rdx                      ; saving str index before mul
                xor         rdx, rdx                 ; rdx = 0
                mul         r9                       ; multiply rax by base len
                pop         rdx                      ; pop str index                       
                add         rax, rcx                 ; add rcx to rax
                mov         r8b, byte [rdi + rdx]    ; load char in r8b
                cmp         r8b, 0                   ; end of str?
                jz          func_end                 ; if so, return
                inc         rdx                      ; otherwise, move to next char
                xor         rcx, rcx                 ; rcx = 0

char_value:     cmp         r8b, byte [rsi + rcx]    ; is char = base + rcx ? 
                jz          compute_int              ; if yes, compute int
                cmp         byte [rsi + rcx], 0      ; is it end of base?
                jz          func_end                 ; means str[rdx] not found in base, then return
                inc         rcx                      ; else rcx += 1
                jmp         char_value               ; loop

func_end:
                xor         rdx, rdx                 ; set rdx to 0 before mul
                mul         rbx                      ; mul rax by sigh (1/-1)
                pop         rbx                      ; pop rbx (pushed at beg. of func)
                ret                                  ; return

                section     .data
whitespaces:    db          9, 10, 11, 12, 13, 32   ; Whitespaces
