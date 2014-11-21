#include <stdio.h>

int hash_code(const char str[]);
int length(const char str[]);
int hash(const char str[], int M);

int main()
{ 
    printf("%d\n", hash_code("abc")); 
    printf("%d\n", hash_code("hello")); 
    printf("%d\n", hash("hello", 10)); 
    return 0;
}

int hash(const char str[], int M)
{ 
    return hash_code(str) & 0x7fffffff % M;
}

int hash_code(const char str[])
{
    int hash = 0;
    int len = length(str);

    for(int i = 0; i < len; i++)
        hash = str[i] + 31 * hash; 

    return hash;
}

int length(const char str[])
{
    int len = 0;
    while(str[++len]);
    return len;
}
