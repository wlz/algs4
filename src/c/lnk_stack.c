#include <stdio.h>
#include <stdlib.h>

typedef struct Node node; 

struct Node
{
    char* str; 
    node* last; 
}; 

void push(char* s); 
char* pop(); 
int is_empty(); 

node *first; 
node *cur; 

int main()
{ 
    first = (node*)malloc(sizeof(node)); 
    first->last = 0; 

    cur = first; 

    push("to"); 
    push("be"); 
    push("or"); 
    push("not"); 
    push("to"); 

    printf("%s ", pop()); 

    push("be"); 

    printf("%s ", pop()); 
    printf("%s ", pop()); 

    push("that"); 

    printf("%s ", pop()); 
    printf("%s ", pop()); 
    printf("%s ", pop()); 

    push("is"); 

    printf("\n"); 

    return 0; 
}

void push(char* s) 
{
    node* n = (node*)malloc(sizeof(node)); 
    n->last = cur; 
    n->str = s; 
    cur = n; 
}

char* pop()
{ 
    char* s = cur->str; 
    node* tmp = cur;
    cur = cur->last; 
    free(tmp);

    return s; 
}

int is_empty()
{ 
    return cur->last == 0; 
} 
