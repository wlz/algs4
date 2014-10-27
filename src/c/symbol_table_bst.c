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
node* max_value();
node* min_value();
int board(int key);
int ceiling(int key);
int rank(int key);
void del_min();
int depth();

node* create_node(int key, char* value);
node* put_node(node* n, int key, char* value);
char* get_node(node* n, int key);
void print();
void print_node(node* n);
int contains_node(node* n, int key);
int size_node(node* n);
node* max_value_node(node* n);
node* min_value_node(node* n);
node* board_node(node* n, int key);
node* ceiling_node(node* n, int key);
int rank_node(node* n, int key);
node* del_min_node(node* n);
node* delete_node(node* n, int key);
void display();
node* get_node_path(char *path);
int length(char *path);
void swap(char *pc, int p, int q);
char* get_path(int order);
int depth_node(node *n);
int get_leafs();
void move(int n);
int get_location(char *path);

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

    printf("%s\n", max_value()->value); 
    printf("%s\n", min_value()->value); 

    printf("%d\n", board(5)); 
    printf("%d\n", board(6)); 

    printf("%d\n", ceiling(5)); 
    printf("%d\n", ceiling(6)); 

    printf("%d\n", rank(7)); 
    printf("%d\n", rank(3)); 

    print();
    printf("size = %d\n", size()); 

    del_min(); 
    print(); 
    printf("size = %d\n", size()); 
    print();

    delete(5); 
    print(); 
    printf("size = %d\n", size()); 

    display();

    return 0;
}

void move(int n)
{ 
    for(int i = 0; i < n; i++)
        printf(" "); 
}

int get_location(char *path)
{
    int loc = 35;
    int sw[4] = {13, 6, 2, 1}; 

    int len = length(path);
    for(int i = 0; i < len; i++)
    {
        int os = i > 3 ? 1 : sw[i];
        if(path[i] == '0') loc -= os;
        else if(path[i] == '1') loc += os;
    } 

    return loc;
}

int depth()
{
    return depth_node(root);
}

int depth_node(node *n)
{
    if(!n) return 0;
    else if(!n->left && !n->right) return 1;
    else
    {
        int dl, dr, max;

        dl = depth_node(n->left);
        dr = depth_node(n->right);

        max = dl > dr ? dl : dr;

        return 1 + max;
    }
} 

void display()
{
    int cnt = get_leafs() - 1;
    int layer = 0;
    int cur = 0;
    for(int i = 0; i < cnt; i++)
    {
        char *path = get_path(i); 
        if(length(path) > layer)
        {
            layer++;
            printf("\n"); 
            cur = 0; 
        }

        int loc = get_location(path);
        move(loc - cur);
        cur = loc;

        node *n = get_node_path(path);
        if(!n) printf("  "); 
        else printf("%d", n->key); 

        cur = loc + 2;
    }
    printf("\n"); 
}

int get_leafs()
{
    int d = depth();
    int s = 1;
    for(int i = 0; i < d; i++)
        s *= 2;

    return s;
}

node* get_node_path(char *path)
{ 
    int len = length(path);

    node *t = root;
    for(int i = 0; i < len; i++)
    { 
        if(path[i] == '0')
        {
            if(!t->left) return NULL;
            t = t->left;
        }
        else if(path[i] == '1')
        {
            if(!t->right) return NULL;
            t = t->right;
        }
    }

    return t;
}

int length(char *path)
{
    int i;
    for(i = 0; path[i] != '\0'; ++i);

    return i;
}

char* get_path(int order)
{ 
    char *path = malloc(sizeof(char) * 10); 

    int i = 0;
    while(order > 0)
    {
        path[i] = ((order - 1) % 2 == 1) ? '1' : '0';
        order = (order - 1) / 2; 
        i++;
    }
    path[i] = '\0';

    int j = i - 1;
    while(j > (i - 1) / 2)
    {
        swap(path, j, (i - 1) - j);
        j--;
    } 

    return path;
}

void swap(char *pc, int p, int q)
{
    char t = pc[p];
    pc[p] = pc[q];
    pc[q] = t;
}

void delete(int key)
{ 
    root = delete_node(root, key);
}

node* delete_node(node* n, int key)
{ 
    if(!n) return NULL;
    if(key > n->key) n->right = delete_node(n->right, key);
    else if(key < n->key) n->left = delete_node(n->left, key);
    else
    {
        node *t;
        if(!n->right || !n->left)
        {
            t = !n->left ? n->right : n->left;
            free(n);
            return t;
        }
        t = n;
        n = min_value_node(t->right);
        n->right = del_min_node(t->right);
        n->left = t->left;

        free(t);
    }
    n->count = size_node(n->left) + size_node(n->right) + 1;

    return n;
}

void del_min()
{ 
    root = del_min_node(root);
}

node* del_min_node(node* n)
{ 
    if(!n->left) 
    {
        node *t = n->right;
        free(n);
        return t;
    }

    n->left = del_min_node(n->left);
    n->count = 1 + size_node(n->left) + size_node(n->right);

    return n;
}

int rank(int key)
{
    return rank_node(root, key);
}

int rank_node(node* n, int key)
{
    if(!n) return 0;
    if(key > n->key) return 1 + size_node(n->left) + rank_node(n->right, key);
    else if(key < n->key) return rank_node(n->left, key);
    else return size_node(n->left);
} 

int board(int key)
{
    node* n = board_node(root, key);
    if(!n) return -1; 
    else return n->key; 
}

node* board_node(node* n, int key)
{ 
    if(!n) return NULL;

    if(key == n->key) return n;
    else if(key < n->key) return board_node(n->left, key); 
    else
    {
        node* np = board_node(n->right, key);
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

node* max_value()
{
    return max_value_node(root);
}

node* max_value_node(node* n)
{ 
    if(!n) return NULL;
    if(!n->right) return n;
    else return max_value_node(n->right);
}

node* min_value()
{
    return min_value_node(root);
}

node* min_value_node(node* n)
{ 
    if(!n) return NULL;
    if(!n->left) return n;
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
    printf("-------------\n");
}

void print_node(node* n)
{
    if(!n) return;
    else
    {
        printf("key: %d, value: %s, count: %d\n", n->key, n->value, n->count);
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
    n->count = 1;

    return n;
}
