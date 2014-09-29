#include <stdio.h>

void enqueue(char* s); 
char* dequeue(); 
int is_empty(); 
void init(); 

typedef struct Node node; 
struct Node
{
    char* str; 
    node* next; 
}; 

node* first; 
node* last; 

int main()
{ 
    enqueue("to"); 
    enqueue("be"); 
    enqueue("or"); 
    enqueue("not"); 
    enqueue("to"); 

    printf("%s\n", dequeue()); 

    enqueue("be"); 

    printf("%s\n", dequeue()); 

    return 0; 
}

void enqueue(char* s)
{ 
    if(first == NULL)
    {
        first = (node*)malloc(sizeof(node)); 
        first->str = s; 
        first->next = NULL; 
    }
    else if(first->next == NULL)
    {
        last = (node*)malloc(sizeof(node)); 
        last->str = s; 
        first->next = last; 
    }
    else
    {
        node* n = (node*)malloc(sizeof(node)); 
        n->str = s; 
        last->next = n; 
        last = n; 
    }
}

char* dequeue()
{
    char* s = first->str; 
    node* p = first; 
    first = first->next; 
    free(p); 

    return s; 
}

