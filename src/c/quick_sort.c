#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 10

static int seq[N];

void init();
void swap(int, int);
void print();
int partition(int, int);
void sort();
void quick_sort(int, int);

int main()
{
    init(); 
    sort();

    print();
    return 0;
}

void sort()
{
    quick_sort(0, N - 1);
}

void quick_sort(int lo, int hi)
{
    if(lo >= hi)
        return;
    int j = partition(lo, hi);
    quick_sort(lo, j - 1);
    quick_sort(j + 1, hi);
}

int partition(int lo, int hi)
{
    int i = lo, j = hi + 1;
    while(1)
    {
        while(seq[++i] < seq[lo])
            if(i == hi) break;
        while(seq[--j] > seq[lo])
            if(j == lo) break;
        if(i >= j) break;
        swap(i, j);
    }
    swap(lo, j);
    return j; 
}

void init()
{
    for(int i = 0; i < N; i++)
        seq[i] = i;
    srand(time(NULL));
    for(int i = 1; i < N; i++)
    {
        int r = rand() % i;
        swap(i, r);
    }
}

void swap(int p, int q)
{
    int t = seq[p];
    seq[p] = seq[q];
    seq[q] = t;
}

void print()
{
    for(int i = 0; i < N; i++)
        printf("%d ", seq[i]); 
    printf("\n"); 
}
