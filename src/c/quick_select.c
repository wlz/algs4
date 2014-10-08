#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 100
#define K 10

static int seq[N];

void init();
void print_seq();
int partition(int lo, int hi);
void swap(int p, int q);
int select(int k);

int main()
{
    init(); 
    printf("%d\n", select(K)); 
    return 0;
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

    print_seq();
}

int select(int k)
{ 
    int lo = 0, hi = N - 1;
    while(hi > lo)
    {
        int j = partition(lo, hi);
        if(j < k) 
            lo = j + 1;
        else if (j > k) 
            hi = j - 1;
        else 
            return seq[k];
    }
    return seq[k];
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

void swap(int p, int q)
{
    int t = seq[p];
    seq[p] = seq[q];
    seq[q] = t;
}

void print_seq()
{
    for(int i = 0; i < N; i++)
        printf("%d ", seq[i]); 
    printf("\n"); 
}
