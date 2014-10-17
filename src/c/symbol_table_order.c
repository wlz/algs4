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

    printf("%s\n", get(3));

    printf("%d\n", contains(0));
    printf("%d\n", contains(1));
    printf("%d\n", contains(5));
    printf("%d\n", contains(6));

    delete(3);
    delete(1);

    print();

    return 0;
} 

void delete(int key)
{
    if(key > st[count - 1]->key || key < st[0]->key)
        return;

    int lo = 0, hi = count - 1, mid = lo + (hi - lo) / 2;
    while(lo <= hi)
    {
        if(key == st[mid]->key)
        {
            count--;
            for(int i = mid; i < count; i++)
                st[i] = st[i + 1];
            st[count] = NULL;
            return;
        }
        else if(key > st[mid]->key) lo = mid + 1;
        else hi = mid - 1;

        mid = lo + (hi - lo) / 2;
    }
}

int contains(int key)
{
    if(key > st[count - 1]->key || key < st[0]->key)
        return 0;

    int lo = 0, hi = count - 1, mid = lo + (hi - lo) / 2;
    while(lo <= hi)
    {
        if(key == st[mid]->key) return 1;
        else if(key > st[mid]->key) lo = mid + 1;
        else hi = mid - 1;

        mid = lo + (hi - lo) / 2; 
    }

    return 0;
}

void print()
{
    for(int i = 0; i < count; i++)
        printf("key:%d , value:%s\n", st[i]->key, st[i]->value);
    printf("\n");
}

char* get(int key)
{ 
    if(key > st[count - 1]->key || key < st[0]->key)
        return NULL;

    int lo = 0, hi = count - 1, mid = lo + (hi - lo) / 2;
    while(lo <= hi)
    {
        if(key == st[mid]->key) return st[mid]->value;
        else if(key > st[mid]->key) lo = mid + 1;
        else hi = mid - 1;

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
    while(lo <= hi)
    { 
        if(key == st[mid]->key)
        {
            st[mid]->value = value;
            return;
        }
        else if(key > st[mid]->key) lo = mid + 1;
        else hi = mid - 1;

        mid = lo + (hi - lo) / 2;
    }

    count++;
    for(int i = count - 1; i > mid; i--)
        st[i] = st[i - 1];
    st[mid] = create_symbol(key, value);
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
