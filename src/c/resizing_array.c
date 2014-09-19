#include <stdio.h>

char* pop(); 
void push(char*); 
void resize(); 
int length = 1; 
int current = 0; 
char** seq; 

int main()
{
	seq = (char**)malloc(sizeof(char*)); 

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

	push("is"); 

	printf("\n"); 
} 

void push(char* s)
{ 
	if(current == length)
	{
		length *= 2; 
		resize(length); 
	}
	seq[current++] = s; 
}

char* pop()
{
	if(current == length / 4)
	{
		length /= 2;
		resize(length);
	}
	return seq[--current]; 
}

void resize(int length)
{ 
	char** np = (char**)malloc(length * sizeof(char*)); 
	for(int i = 0; i < length / 2; i++)
		np[i] = seq[i]; 

	free(seq); 
	seq = np; 
} 

