#include <stdio.h>
#include <stdlib.h>

#define N 100

typedef struct
{
    int key;
    char *value; 
} symbol;

static symbol *st[N];
static int count = 0;

void put(int key, char* value);
char* get(int key);
int size();
void delete(int key);
int contains(int key);
void print();

symbol* create_symbol(int key, char* value);

int main()
{
    put(1, "a");
    put(2, "b");
    put(5, "e");
    put(4, "d");
    put(3, "c");

    print();

    printf("%s\n", get(2));
    return 0;
} 

void print()
{
    for(int i = 0; i < count; i++)
        printf("key:%d , value:%s\n", st[i]->key, st[i]->value);
}

char* get(int key)
{ 
    int lo = 0, hi = count - 1, mid = lo + (hi - lo) / 2;
    while(lo < hi)
    {
        if(key == st[mid]->key)
            return st[mid]->value;
        else if(key > st[mid]->key)
            lo = mid;
        else
            hi = mid;

        mid = lo + (hi - lo) / 2; 
    }

    return NULL;
}

void put(int key, char* value)
{ 
    if(count == 0)
    {
        st[count++] = create_symbol(key, value);
        return;
    }

    if(key > st[count - 1]->key) 
    {
        st[count++] = create_symbol(key, value);
        return;
    } 

    if(key < st[0]->key)
    {
        count++;
        for(int i = count - 1; i > 0; i--)
            st[i] = st[i - 1];
        st[0] = create_symbol(key, value);
        return;
    } 

    int lo = 0, hi = count - 1, mid = lo + (hi - lo) / 2;
    while(lo < hi - 1)
    { 
        if(key == st[mid]->key)
        {
            st[mid]->value = value;
            return;
        }
        else if(key > st[mid]->key)
            lo = mid;
        else
            hi = mid;

        mid = lo + (hi - lo) / 2;
    }

    count++;
    for(int i = count - 1; i > mid; i--)
        st[i] = st[i - 1];
    st[mid + 1] = create_symbol(key, value);
}

symbol* create_symbol(int key, char* value)
{
    symbol *s = malloc(sizeof(symbol));
    s->key = key;
    s->value = value;

    return s; 
}

int size()
{
    return count;
}
