#include <stdio.h>
#include <stdlib.h>

#define M 100

int hash(const char str[]);
int hash_code(const char str[]);
int length(const char str[]);

void put(char *key, char *val);
char *get(char *key);

char *vals[M];
char *keys[M];

int main()
{
    put("a", "when");
    put("b", "I");
    put("c", "was");
    put("d", "young");

    printf("%s\n", get("a")); 
    printf("%s\n", get("d")); 

    return 0;
}

void put(char *key, char *val)
{
    int i;
    for(i = hash(key); keys[i] != NULL; i = (i + 1) % M)
        if(keys[i] == key)
            break;

    keys[i] = key;
    vals[i] = val;
}

char *get(char *key)
{ 
    for(int i = hash(key); keys[i] != NULL; i = (i + 1) % M)
        if(keys[i] == key)
            return vals[i];

    return NULL;
}

int hash(const char str[])
{
    return (hash_code(str) & 0x7fffffff) % M;
}

int hash_code(const char str[])
{
    int hash = 0;
    int len = length(str);
    for(int i = 0; i < len; i++)
        hash = str[i] + hash * 31;
    return hash;
}

int length(const char str[])
{
    int len = 0;
    while(str[++len]);
    return len;
}
