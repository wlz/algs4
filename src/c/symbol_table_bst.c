#include <stdio.h>
#include <stdlib.h>

struct node
{
    int key;
    char* value;
    struct node *left;
    struct node *right;
};

typedef struct node node;

static node* root = NULL;

void put(int key, char* value);
char* get(int key);

node* create_node(int key, char* value);
node* put_node(node* n, int key, char* value);
char* get_node(node* n, int key);

int main()
{
    put(1, "aaa");
    put(3, "bbb");
    put(2, "ccc");

    printf("%s\n", get(3));

    return 0;
}

char* get(int key)
{ 
    return get_node(root, key);
}

char* get_node(node* n, int key)
{
    if(!n) return NULL;

    if(key == n->key) return n->value;
    else if(key > n->key) return get_node(n->right, key);
    else return get_node(n->left, key); 
}

void put(int key, char* value)
{
    root = put_node(root, key, value);
}

node* put_node(node* n, int key, char* value)
{
    if(!n)  
        return create_node(key, value);
    else if(key > n->key) n->right = put_node(n->right, key, value);
    else if(key < n->key) n->left = put_node(n->left, key, value);
    else n->value = value;

    return n;
}

node* create_node(int key, char* value)
{
    node* n = malloc(sizeof(node));
    n->key = key;
    n->value = value;

    return n;
}
