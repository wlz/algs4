#include <stdio.h>
#include <stdlib.h>

struct node
{
    int key;
    char *value;
    struct node *left;
    struct node *right;
    int count;
};

typedef struct node node;

static node* root = NULL;

void put(int key, char* value);
char* get(int key);
void delete(int key);
int contains(int key);
int is_empty();
int size();
char* max_value();
char* min_value();
int floor(int key);
int ceiling(int key);

node* create_node(int key, char* value);
node* put_node(node* n, int key, char* value);
char* get_node(node* n, int key);
void print();
void print_node(node* n);
int contains_node(node* n, int key);
int size_node(node* n);
char* max_value_node(node* n);
char* min_value_node(node* n);
node* floor_node(node* n, int key);
node* ceiling_node(node* n, int key);

int main()
{
    put(3, "bbb");
    put(1, "aaa");
    put(2, "ccc");
    put(2, "222");
    put(4, "mmm");
    put(6, "nnn");
    put(5, "hhh");

    printf("%s\n", get(2));
    printf("%d\n", contains(1));
    printf("%d\n", contains(5));

    printf("is_empty: %d\n", is_empty());
    printf("size = %d\n", size()); 

    printf("%s\n", max_value()); 
    printf("%s\n", min_value()); 

    printf("%d\n", floor(5)); 
    printf("%d\n", floor(6)); 

    printf("%d\n", ceiling(5)); 
    printf("%d\n", ceiling(6)); 

    print();
    return 0;
}

int floor(int key)
{
    node* n = floor_node(root, key);
    if(!n) return -1; 
    else return n->key; 
}

node* floor_node(node* n, int key)
{ 
    if(!n) return NULL;

    if(key == n->key) return n;
    else if(key < n->key) return floor_node(n->left, key); 
    else
    {
        node* np = floor_node(n->right, key);
        if(!np) return n;
        else return np;
    }
} 

int ceiling(int key)
{
    node *n = ceiling_node(root, key);
    if(!n) return -1;
    else return n->key;
}

node* ceiling_node(node* n, int key)
{ 
    if(!n) return NULL;

    if(key == n->key) return n;
    else if(key > n->key) return ceiling_node(n->right, key);
    else
    {
        node* np = ceiling_node(n->left, key);
        if(!np) return n;
        else return np;
    }
}

char* max_value()
{
    return max_value_node(root);
}

char* max_value_node(node* n)
{ 
    if(!n) return NULL;
    if(!n->right) return n->value;
    else return max_value_node(n->right);
}

char* min_value()
{
    return min_value_node(root);
}

char* min_value_node(node* n)
{ 
    if(!n) return NULL;
    if(!n->left) return n->value;
    else return min_value_node(n->left);
}

int size()
{
    return size_node(root);
}

int size_node(node* n)
{ 
    if(n == NULL) return 0;
    else return n->count;
}

int is_empty()
{
    return root == NULL;
}

int contains(int key)
{
    return contains_node(root, key);
}

int contains_node(node* n, int key)
{
    if(!n) return 0;
    if(key > n->key) return contains_node(n->right, key);
    else if(key < n->key) return contains_node(n->left, key);
    else return 1; 
}

void print()
{ 
    print_node(root);
}

void print_node(node* n)
{
    if(!n) return;
    else
    {
        printf("key: %d, value: %s\n", n->key, n->value);
        print_node(n->left);
        print_node(n->right);
    }
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
    if(!n) return create_node(key, value);
    else if(key > n->key) n->right = put_node(n->right, key, value);
    else if(key < n->key) n->left = put_node(n->left, key, value);
    else n->value = value;
    n->count = 1 + size_node(n->left) + size_node(n->right);

    return n;
}

node* create_node(int key, char* value)
{
    node* n = malloc(sizeof(node));
    n->key = key;
    n->value = value;
    n->left = NULL;
    n->right = NULL;
    n->count = 0;

    return n;
}
