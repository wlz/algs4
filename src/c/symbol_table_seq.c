#include <stdio.h>
#include <stdlib.h>

#define N 100

typedef struct
{
    int key;
    char *value;
} symbol;

static int count = 0;
static symbol *st[N];

void put(int key, char *value);
void delete(int key);
char* get(int key);
int contains(int key);
int is_empty();
int size();

void print();

int main()
{
    put(1, "a");
    put(2, "b");
    put(3, "c");

    delete(1);

    printf("%s\n", get(2));
    print();
} 

int is_empty()
{
    return count == 0;
}

int size()
{
    return count;
}

void delete(int key)
{
    for(int i = 0; i < count; i++)
    {
        if(st[i]->key == key)
        {
            free(st[i]);
            st[i] = st[--count];
        }
    }
}

char* get(int key)
{
    for(int i = 0; i < count; i++)
        if(st[i]->key == key)
            return st[i]->value;
    return NULL;
}

void put(int key, char *value)
{ 
    if(!contains(key))
    {
        symbol *s = malloc(sizeof(symbol));
        s->key = key;
        s->value = value;
        st[count++] = s;
    }
    else
    {
        for(int i = 0; i < count; i++)
            if(st[i]->key == key)
                st[i]->value = value;
    }
}

int contains(int key)
{ 
    for(int i = 0; i < count; i++)
        if(st[i]->key == key)
            return 1;
    return 0; 
}

void print()
{
    for(int i = 0; i < count; i++)
        printf("key: %d, value: %s\n", st[i]->key, st[i]->value);
}
