#include "libasm.h"
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

void
    clear_buf(char *buf, int size)
{
    int i = 0;
    while (i < size)
    {
        buf[i] = 0;
        i++;
    }
}

void    ft_myfree(void *ptr)
{
    free(ptr);
}

int main(void)
{
    char p0[] = "abc";
    char p1[] = "abcabc";
    char p2[] = "abcdefg";
    char p3[] = "";
	char p4[] = "ab\xff";
    int i = 100;
    char buff[i];

    clear_buf(buff, i);


    printf("### STRLEN ###\n\n");

    printf("My res: |%lu|%lu|%lu|%lu|%lu|\n", ft_strlen(p0), ft_strlen(p1), ft_strlen(p3), ft_strlen("1"), ft_strlen(""));
    printf("Lib C : |%lu|%lu|%lu|%lu|%lu|\n", strlen(p0), strlen(p1), strlen(p3), strlen("1"), strlen(""));


    printf("\n\n### STRCMP ###\n\n");

    printf("My res: |%d|%d|%d|%d|%d|%d|\n", ft_strcmp(p0, p1), ft_strcmp(p0, p0), ft_strcmp(p1, p0), ft_strcmp(p0, p3), ft_strcmp(p3, p3), ft_strcmp(p4, p0));
    printf("Lib C : |%d|%d|%d|%d|%d|%d|\n", strcmp(p0, p1), strcmp(p0, p0), strcmp(p1, p0), strcmp(p0, p3), strcmp(p3, p3), strcmp(p4, p0));


    printf("\n\n### STRCPY ###\n\n");

    printf("My res: |%s|\n", ft_strcpy(buff, p0));
    printf("My res: |%s|\n", ft_strcpy(buff, p1));
    printf("My res: |%s|\n", ft_strcpy(buff, p3));
    printf("My res: |%s|\n", ft_strcpy(p3, p3));
    printf("My res: |%s|\n", strcpy(p2, p2 + 3));


    printf("Lib C : |%s|\n", strcpy(buff, p0));
    printf("Lib C : |%s|\n", strcpy(buff, p1));
    printf("Lib C : |%s|\n", strcpy(buff, p3));
    printf("Lib C : |%s|\n", strcpy(p3, p3));
    char p5[] = "abcdefg";
    printf("Lib C : |%s|\n", strcpy(p5, p5 + 3));


    printf("\n\n### WRITE ###\n\n");

    printf("My write: |%zd|\n", ft_write(1, "Oh chilele\n", 11));
    printf("My write: |%zd|\n", ft_write(1, "\n", 2));
    printf("My write: |%zd|\n", ft_write(1, "Bombo\n", 0));
    printf("My write: |%zd|\n", ft_write(1, "", 2));
    printf("My write: |%zd|\n", ft_write(1, "test", 4));
    printf("My write: |%zd|\n", ft_write(1, "test", 2));
    printf("My write: |%zd|\n", ft_write(1, NULL, 2));
    printf("**\n");
    printf("Unistd: |%zd|\n", write(1, "Oh chilele\n", 11));
    printf("Unistd: |%zd|\n", write(1, "\n", 2));
    printf("Unistd: |%zd|\n", write(1, "Bombo\n", 0));
    printf("Unistd: |%zd|\n", write(1, "", 2));
    printf("Unistd: |%zd|\n", write(1, "test", 4));
    printf("Unistd: |%zd|\n", write(1, "test", 2));
    printf("Unistd: |%zd|\n", write(1, NULL, 2));

    printf("\n** WRITE ERROR **\n\n");
    printf("My res: |%zd|\n", ft_write(1, NULL, 2));
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    printf("My res: |%zd|\n", ft_write(-1, buff, 2));
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    printf("My res: |%zd|\n", ft_write(1, buff, -122));
    printf("Errno: %d\n", errno);
    perror("Error in read:");

    printf("Unistd: |%zd|\n", write(1, NULL, 2));
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    printf("Unistd: |%zd|\n", write(-1, buff, 2));
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    printf("Unistd: |%zd|\n", write(1, buff, -122));
    printf("Errno: %d\n", errno);
    perror("Error in read:");

    printf("\n\n### READ ###\n\n");

    clear_buf(buff, i);
    int fd1 = open("read_test.txt", O_RDWR);
    printf("My read: |%zd|\n", ft_read(fd1, buff, 10));
    printf("My read: |%s|\n", buff);
    clear_buf(buff, i);
    printf("My read: |%zd|\n", ft_read(fd1, buff, 20));
    printf("My read: |%s|\n", buff);
    clear_buf(buff, i);
    printf("My read: |%zd|\n", ft_read(fd1, buff, 30));
    printf("My read: |%s|\n", buff);
    clear_buf(buff, i);
    printf("My read: |%zd|\n", ft_read(fd1, buff, 40));
    printf("My read: |%s|\n", buff);
    clear_buf(buff, i);
    printf("My read: |%zd|\n", ft_read(fd1, buff, 50));
    printf("My read: |%s|\n", buff);
    clear_buf(buff, i);
    printf("My read: |%zd|\n", ft_read(fd1, buff, 0));
    printf("My read: |%s|\n", buff);
    close(fd1);

    fd1 = open("read_test.txt", O_RDWR);
    printf("Lib C: |%zd|\n", read(fd1, buff, 10));
    printf("Lib C: |%s|\n", buff);
    clear_buf(buff, i);
    printf("Lib C: |%zd|\n", read(fd1, buff, 20));
    printf("Lib C: |%s|\n", buff);
    clear_buf(buff, i);
    printf("Lib C: |%zd|\n", read(fd1, buff, 30));
    printf("Lib C: |%s|\n", buff);
    clear_buf(buff, i);
    printf("Lib C: |%zd|\n", read(fd1, buff, 40));
    printf("Lib C: |%s|\n", buff);
    clear_buf(buff, i);
    printf("Lib C: |%zd|\n", read(fd1, buff, 50));
    printf("Lib C: |%s|\n", buff);
    clear_buf(buff, i);
    printf("Lib C: |%zd|\n", read(fd1, buff, 0));
    printf("Lib C: |%s|\n", buff);
    close(fd1);

    printf("\n** READ STDIN **\n\n");

    clear_buf(buff, i);
    printf("My read: %zd\n", ft_read(0, buff, 10));
    printf("My read: %s\n", buff);
    clear_buf(buff, i);
    printf("C read : %zd\n", read(0, buff, 10));
    printf("C read : %s\n", buff);

    printf("\n** READ ERROR **\n\n");

    fd1 = open("read_test.txt", O_RDWR);
    printf("My read: |%zd|\n", ft_read(-5, buff, 10));
    printf("My read: |%s|\n", buff);
    printf("Errno: %d\n", errno);
    perror("Error in read:");

    printf("My read: |%zd|\n", ft_read(fd1, buff, -10));
    printf("My read: |%s|\n", buff);
    printf("Errno: %d\n", errno);
    perror("Error in read:");

    printf("My read: |%zd|\n", ft_read(fd1, NULL, 10));
    printf("My read: |%s|\n", buff);
    printf("Errno: %d\n", errno);
    perror("Error in read:");

    printf("C read: |%zd|\n", read(-5, buff, 10));
    printf("C Char read: |%s|\n", buff);
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    printf("C read: |%zd|\n", read(fd1, buff, -10));
    printf("C Char read: |%s|\n", buff);
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    printf("C read: |%zd|\n", read(fd1, NULL, 10));
    printf("C Char read: |%s|\n", buff);
    printf("Errno: %d\n", errno);
    perror("Error in read:");
    close(fd1);

    printf("\n\n** STRDUP **\n\n");

    char dup0[] = "Nous les nains";
    char dup1[] = "Bla bla bla... \n vous nous fatiguez";
    char dup2[] = "Bla bla \0bla... \n vous nous fatiguez";
    char dup3[] = "";

    char *s = ft_strdup(dup0);
    printf("My dup: %s\n", s);
    free(s);
    s = ft_strdup(dup1);
    printf("My dup: %s\n", s);
    free(s);
    s = ft_strdup(dup2);
    printf("My dup: %s\n", s);
    free(s);
    s = ft_strdup(dup3);
    printf("My dup: %s\n", s);
    free(s);

    printf("\n\n** ATOI_BASE **\n\n");

    char str0[] = "Enchat";

    printf("Atoi_base: %d\n", ft_atoi_base("1", "0123456789"));
    printf("Atoi_base: %d\n", ft_atoi_base("0", "0123456789"));
    printf("Atoi_base: %d\n", ft_atoi_base("1000", "0123456789"));
    printf("Atoi_base: %d\n", ft_atoi_base("1234", "0123456789"));
    printf("Atoi_base: %d\n", ft_atoi_base("9876", "0123456789"));
    printf("Atoi_base: %d\n", ft_atoi_base("8877", "0123456789"));

    printf("Atoi_base: %d\n", ft_atoi_base("ff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("ffff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("ffffff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("7fffffff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("ffffffff", "0123456789abcdef"));

    printf("Atoi_base: %d\n", ft_atoi_base("-ff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("-+-ffff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("---ffffff", "0123456789abcdef"));
    printf("Atoi_base: %d\n", ft_atoi_base("ba", "abcdefghij"));
    printf("Atoi_base: %d\n", ft_atoi_base("bcd", "abcdefghij"));
    printf("Str_checks: %d\n", ft_atoi_base("       \n", "1423"));

    printf("\nExpected alternate -1/1\n\n");
    printf("Str_checks: %d\n", ft_atoi_base("\n-a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("+a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("---a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("--a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("-+--a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("+--+a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("\n-a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("\n\f\r\t \n  \v+++a", "1a234"));
    printf("Str_checks: %d\n", ft_atoi_base("-4\n", "1423"));

    printf("\nExpected base errors = 0\n\n");
    // printf("Base_checks: %d\n", ft_atoi_base(str0, "    afas.dfk     jhaelkgh12abc"));
    // printf("Base_checks: %d\n", ft_atoi_base(str0, "12345678901"));
    printf("Base_checks: %d\n", ft_atoi_base("", ""));
    printf("Base_checks: %d\n", ft_atoi_base("1", "1"));
    printf("Base_checks: %d\n", ft_atoi_base("1", "123 "));
    printf("Base_checks: %d\n", ft_atoi_base("1", "     1"));
    printf("Base_checks: %d\n", ft_atoi_base("1", "1  "));
    printf("Base_checks: %d\n", ft_atoi_base("1", "2\n1"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "112"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "1232"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "000000000"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "121234+"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "12abcdefg-"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "12abc-+"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "12abc--"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "12abcdefw    +"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "12+abc"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "+++12abc"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "+-+12abc"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "+as.dfkjhaelkgh12abc"));
    printf("Base_checks: %d\n", ft_atoi_base(str0, "-    afas.dfk     jhaelkgh12abc"));

    printf("\n str Error: expecting 0\n\n");
    printf("Str_checks: %d\n", ft_atoi_base("", "abc"));

    printf("Atoi_base: %d\n", ft_atoi_base("        \n", "0123456789"));

    printf("\n\nFT_LIST_PUSH_FRONT\n\n");

    t_list  elem1;
    t_list  elem2;

    elem1.data = "9abcd1";
    elem2.data = "5efgh3";
    elem1.next = &elem2;
    elem2.next = NULL;
    t_list  *beg_list = &elem1;
    char    *str1 = "8ijkl5";
    char    *str2 = "8g";
    char    *str_mal1 = (char *)malloc(3);
    str_mal1[0] = '8';
    str_mal1[1] = 'g';
    str_mal1[2] = 0;

    char    *str_mal2 = (char *)malloc(3);
    str_mal2[0] = '8';
    str_mal2[1] = 'g';
    str_mal2[2] = 0;

    printf("Before push: |%s|%p|%p|\n", beg_list->data, beg_list, beg_list->next);
    ft_list_push_front(&beg_list, str_mal1);
    ft_list_push_front(&beg_list, str_mal2);
    printf("Elem1: |%s|%p|\n", beg_list->data, beg_list->next);
    printf("Elem2: |%s|%p|\n", beg_list->next->data, beg_list->next->next);
    printf("Elem3: |%s|%p|\n", beg_list->next->next->data, beg_list->next->next->next);
    printf("Elem3: |%s|%p|\n", beg_list->next->next->next->data, beg_list->next->next->next->next);

    printf("\n\nLIST SIZE\n\n");
    printf("List size: |%d|%d|%d|%d|\n", ft_list_size(beg_list), ft_list_size(beg_list->next), ft_list_size(beg_list->next->next), ft_list_size(NULL));

    printf("\n\nLIST SORT\n\n");
    ft_list_sort(&(beg_list), ft_strcmp);
    printf("Elem1: |%s|%p|\n", beg_list->data, beg_list->next);
    printf("Elem2: |%s|%p|\n", beg_list->next->data, beg_list->next->next);
    printf("Elem3: |%s|%p|\n", beg_list->next->next->data, beg_list->next->next->next);
    printf("Elem3: |%s|%p|\n", beg_list->next->next->next->data, beg_list->next->next->next->next);

    printf("\n\nLIST REMOVE\n\n");

    ft_list_remove_if(&beg_list, "8g", ft_strcmp, ft_myfree);
    printf("Elem1: |%s|%p|\n", beg_list->data, beg_list->next);
    printf("Elem2: |%s|%p|\n", beg_list->next->data, beg_list->next->next);
    // printf("Elem3: |%s|%p|\n", beg_list->next->next->data, beg_list->next->next->next);


    t_list *lst_ptr = malloc(sizeof(t_list));
    char *data = (char *)malloc(sizeof(3));
    t_list *lst_ptr2 = malloc(sizeof(t_list));
    char *data2 = (char *)malloc(sizeof(3));
    data[0] = '0';
    data[1] = '3';
    data[2] = 0;
    data2[0] = '0';
    data2[1] = '3';
    data2[2] = 0;
    lst_ptr->data = data;
    lst_ptr->next = lst_ptr2;

    lst_ptr2->data = data2;
    lst_ptr2->next = NULL;

    ft_list_remove_if(&lst_ptr, "03", ft_strcmp, ft_myfree);
    printf("Freed list pointer: %p\n", lst_ptr);
    printf("\n\n####### THE END ########");
    // printf("Content: |%s|%p|\n", lst_ptr->data, lst_ptr->next);


    return (0);
}
