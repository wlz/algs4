#include <stdio.h>
#include <stdlib.h>

struct node
{ 
    int key;
    char value;
    struct node* left;
    struct node* right; 
    int color;
};

typedef struct node node;

void put(char value);

int is_red(node* n);
node* node_init(char value); 
node* put_node(node* n, char value);

int main()
{
    node* n = node_init('a');
    printf("key: %d, value: %c, is_red: %d\n", n->key, n->value, n->color);
    return 0;
} 

int is_red(node* n)
{ 
    if(!n) return 0;
    return n->color == 1;
}

node* node_init(char value)
{
    node* n = malloc(sizeof(node));

    n->key = (int)value;
    n->value = value;
    n->left = n->right = NULL;
    n->color = 0;

    return n;
}
