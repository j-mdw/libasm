NAME			= libasm.a

SRCS_MAND		:= \
ft_strlen\
ft_strcpy\
ft_strcmp\
ft_write\
ft_read\
ft_strdup\

SRCS_BONUS		:= \
ft_atoi_base\
ft_list_push_front\
ft_list_size\
ft_list_sort\
ft_list_remove_if

S_FILES_MAND	:= \
$(addprefix srcs/, $(addsuffix .s, $(SRCS_MAND)))

S_FILES_BONUS	:= \
$(addprefix srcs/, $(addsuffix _bonus.s, $(SRCS_BONUS)))

OBJS_MAND		= \
$(addprefix objs/, $(addsuffix .o, $(SRCS_MAND)))

OBJS_BONUS		= \
$(addprefix objs/, $(addsuffix _bonus.o, $(SRCS_BONUS)))

H_FILES		= libasm.h

ASM			= nasm

ASM_FLAGS	= -f elf64

RM			= rm -f

ifdef	WITH_BONUS
	OBJS_FILES 	= $(OBJS_MAND) $(OBJS_BONUS)
	S_FILES		= $(S_FILES_MAND) $(S_FILES_BONUS)
else
	OBJS_FILES 	= $(OBJS_MAND)
	S_FILES 	= $(S_FILES_MAND)
endif	

all: $(NAME)

$(NAME): $(OBJS_FILES)
	ar -rcs $(NAME) $(OBJS_FILES)

bonus:	$(OBJS_MAND) $(OBJS_BONUS)
	@$(MAKE) WITH_BONUS=1 all

objs/%.o: srcs/%.s $(H_FILES)
	$(ASM) $(ASM_FLAGS) $< -o $@

clean:
	$(RM) $(OBJS_MAND) $(OBJS_BONUS)

fclean: clean
	$(RM) $(NAME)

re: fclean all
