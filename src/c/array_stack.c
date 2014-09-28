#include <stdio.h>

void push(char* s); 
char* pop(); 
int is_empty(); 

char* stack[10]; 
int point = 0; 

int main()
{ 
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

	printf("\n"); 
	push("is");

	return 0; 
}

int is_empty()
{
	return point == 0; 
}

void push(char* s)
{ 
	stack[point++] = s; 
}

char* pop()
{ 
	return stack[--point]; 
} 
