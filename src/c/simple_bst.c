#include <stdio.h>
#include <stdlib.h>

struct node
{
    int data;
    struct node *left;
    struct node *right; 
};

typedef struct node node;

static node *root = NULL;

node* node_init(int data);

int main()
{
    return 0;
}

node* node_init(int data)
{
    node *n = malloc(sizeof(node));

    n->data = data;
    n->left = n->right = NULL;

    return n;
} 
