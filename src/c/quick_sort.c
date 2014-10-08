#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define N 100

static int seq[N];

void shuffle(int* p);
int partition(int* p, int lo, int hi);
void print_seq(int* p);
void swap(int* p, int i, int j);
void sort(int* p);
void quick_sort(int* p, int lo, int hi);

int init()
{
    srand(time(NULL));
    for(int i = 0; i < N; i++)
        seq[i] = i; 
    shuffle(seq);
}

int main()
{
    init();
    print_seq(seq);

    sort(seq);
    print_seq(seq);

    return 0;
}

void shuffle(int* p)
{
    for(int i = 1; i < N; i++)
    { 
        int ran = rand() % i;
        swap(p, ran, i);
    }
}

void print_seq(int* p)
{
    for(int i = 0; i < N; i++)
        printf("%d ", p[i]); 
    printf("\n"); 
}

void swap(int* p, int i, int j)
{
    int t = p[i];
    p[i] = p[j];
    p[j] = t; 
}

int partition(int* p, int lo, int hi)
{ 
    int i = lo, j = hi + 1;

    while(1)
    {
        while(p[++i] < p[lo])
            if(i == hi) break;
        while (p[lo] < p[--j])
            if(j == lo) break;

        if(i >= j) break;
        swap(p, i, j);
    }
    swap(p, lo, j);
    return j;
}

void sort(int* p)
{
    quick_sort(p, 0, N - 1); 
}

void quick_sort(int* p, int lo, int hi)
{
    if(hi <= lo) return;
    int j = partition(p, lo, hi);
    quick_sort(p, lo, j - 1);
    quick_sort(p, j + 1, hi); 
}
