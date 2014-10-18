#include <stdio.h>
#include <stdlib.h>

#define N 100

typedef struct
{
    int key;
    char* value;
} symbol;

static symbol *st[N];
static int count = 0; 

void put(int key, char* value);
char* get(int key); 
void delete(int key);
int contains(int key);
int is_empty();
int size();

void print();
int position(int key, int *ceiling);
void shift(int k, symbol* s);
symbol* create_symbol(int key, char* value);

int main()
{
    put(1, "a");
    put(2, "b");
    put(5, "b");
    put(3, "b");
    put(0, "b");
    put(2, "c");

    print();

    delete(1);

    print();

    return 0;
}

int is_empty()
{
    return count == 0;
}

int size()
{
    return count;
}

int contains(int key)
{
    int c;
    return position(key, &c) != -1; 
}

char* get(int key)
{ 
    int p, c;
    p = position(key, &c);
    if(p != -1)
        return st[p]->value;

    return NULL;
}

void delete(int key)
{
    int p, c;
    p = position(key, &c);
    if(p != -1)
    {
        free(st[p]);
        count--;
        for(int i = p; i < count; i++)
            st[i] = st[i + 1];
    }
}

void print()
{
    for(int i = 0; i < count; i++)
        printf("index: %d, key: %d, value: %s\n", i, st[i]->key, st[i]->value);
    printf("\n");
}

void put(int key, char* value)
{
    if(count == 0 || key > st[count - 1]->key)
        st[count++] = create_symbol(key, value);
    else if(key < st[0]->key)
        shift(0, create_symbol(key, value));
    else
    {
        int p, c;
        p = position(key, &c);
        if(p != -1) st[p]->value = value;
        else shift(c, create_symbol(key, value));
    }
}

int position(int key, int *ceiling)
{
    int lo = 0, hi = count - 1, mid = lo + (hi - lo) / 2;
    while(lo <= hi)
    {
        if(st[mid]->key == key)
        {
            *ceiling = -1;
            return mid;
        }
        else if(key > st[mid]->key) lo = mid + 1;
        else hi = mid - 1;

        mid = lo + (hi - lo) / 2; 
    }

    *ceiling = mid;
    return -1;
}

void shift(int k, symbol *s)
{
    count++;
    for(int i = count - 1; i > k; i--)
        st[i] = st[i - 1];
    st[k] = s;
}

symbol* create_symbol(int key, char* value)
{
    symbol *s = malloc(sizeof(symbol));
    s->key = key;
    s->value = value;

    return s;
}
