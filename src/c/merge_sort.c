#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100

static int seq[N];
static int aux[N];

void init();
void swap(int p, int q);
void print();
void merge(int lo, int mid, int hi);
void sort();
void merge_sort(int lo, int hi);

int main()
{
    init();
    sort();
    print();

    return 0;
}

void sort()
{
    merge_sort(0, N - 1);
}

void merge_sort(int lo, int hi)
{
    if(lo >= hi)
        return;

    int mid = lo + (hi - lo) / 2;
    merge_sort(lo, mid);
    merge_sort(mid + 1, hi);

    merge(lo, mid, hi);
} 

void merge(int lo, int mid, int hi)
{
    for(int i = 0; i < N; i++)
        aux[i] = seq[i];

    int j = lo, k = mid + 1;
    for(int i = lo; i <= hi; i++)
    {
        if(j > mid)
            seq[i] = aux[k++];
        else if(k > hi)
            seq[i] = aux[j++];
        else if(aux[j] >= aux[k])
            seq[i] = aux[k++];
        else
            seq[i] = aux[j++];
    }
}

void init()
{
    for(int i = 0; i < N; i++)
        seq[i] = i;
    srand(time(NULL));
    for(int i = 1; i < N; i++)
    {
        int rnd = rand() % i;
        swap(i, rnd);
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
