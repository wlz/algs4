#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void print_seq(int* p, int size);
void shuffle(int* p, int size);
void swap(int* p, int i, int j);

int main()
{
    srand(time(NULL));
    int seq[10] = { 6, 1, 2, 4, 9, 3, 0, 5, 8, 7 };

    shuffle(seq, 10);
    print_seq(seq, 10);

	return 0;
} 

void print_seq(int* p, int size)
{
    for(int i = 0; i < size; i++)
        printf("%d ", p[i]);
    printf("\n"); 
}

void shuffle(int* p, int size)
{
    for(int i = 1; i < size; i++)
    { 
        int ran = rand() % i;
        swap(p, ran, i);
    }
}

void swap(int* p, int i, int j)
{
    int tmp = p[i];
    p[i] = p[j];
    p[j] = tmp;
}
