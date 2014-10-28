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

void put(int data);
void delete(int data);

node* del_node(node *n, int data);
node* node_init(int data);
node* put_node(node *n, int data);
node* del_min(node *n);
node* get_min(node *n);
void display(node *n);

int main()
{
    put(4);
    put(3);
    put(1);
    put(2);

    delete(2);
    display(root);

    return 0;
}

void delete(int data)
{ 
    root = del_node(root, data);
}

node* del_node(node *n, int data)
{ 
    if(!n) return NULL;
    if(data > n->data) n->right = del_node(n->right, data);
    else if(data < n->data) n->left = del_node(n->left, data);
    else
    {
        if(!n->right) return n->left;
        if(!n->left) return n->right;

        struct node *t = n;

        n = get_min(n->right);
        n->right = del_min(n->right);
        n->left = t->left;
    }

    return n;
}

node* get_min(node *n)
{
    if(!n) return NULL;
    if(!n->left) return n;
    else return get_min(n->left);
}

node* del_min(node *n)
{
    if(!n) return NULL;
    if(!n->left) 
    {
        node *t = n->right;
        free(n);
        return t;
    }
    else n->left = del_min(n->left);

    return n;
}

void display(node *n)
{ 
    if(!n) return;

    printf("%d\n", n->data); 
    display(n->left);
    display(n->right);
}

void put(int data)
{
    root = put_node(root, data);
}

node* put_node(node *n, int data)
{ 
    if(!n) return node_init(data);
    if(data > n->data) 
        n->right = put_node(n->right, data);
    else if(data < n->data)
        n->left = put_node(n->left, data);
    else 
        n->data = data;

    return n;
}

node* node_init(int data)
{
    node *n = malloc(sizeof(node));

    n->data = data;
    n->left = n->right = NULL;

    return n;
} 
