#include <stdio.h>
#include <stdlib.h>
#define M 97

struct node
{
    char *key;
    char *val;
    struct node *next;
};

typedef struct node node;

int hash_code(const char str[]);
int hash(const char str[]);
int length(const char str[]);

node *st[M];
void put(char *key, char *val);
char* get(char *key);

node *node_init(char *key, char *val, node *next);

int main()
{
    put("a", "when");
    put("b", "I");
    put("c", "was");
    put("d", "young");

    printf("%s\n", get("d")); 

    return 0;
}

char* get(char *key)
{
    int i = hash(key);
    node *x;
    for(x = st[i]; x != NULL; x = x->next)
    {
        if(x->key == key)
            return x->val;
    }
    return NULL; 
}

void put(char *key, char *val)
{ 
    int i = hash(key);
    node *x;
    for(x = st[i]; x != NULL; x = x->next)
    {
        if(x->key == key)
        {
            x->val = val;
            return;
        }
    }
    st[i] = node_init(key, val, st[i]);
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

node *node_init(char *key, char *val, node *next)
{
    node *n = malloc(sizeof(node));

    n->key = key;
    n->val = val;
    n->next = next;

    return n;
}
