#include <stdio.h>
#define N 10

void print_seq(int* seq);
void merge_sort(int* seq);
void merge(int* seq, int* aux, int lo, int mid, int hi);
int min(int x, int y);

int main()
{
    int seq[N] = { 9, 1, 3, 5, 2, 4, 7, 6, 8, 0 };
    merge_sort(seq);
    print_seq(seq);
    return 0;
}

void print_seq(int* p)
{
    for(int i = 0; i < N; i++)
        printf("%d ", p[i]); 
    printf("\n"); 
}

void merge_sort(int* seq)
{
    int aux[N];
    for(int sz = 1; sz < N; sz = sz * 2)
    { 
        for(int lo = 0; lo < N - sz; lo += sz * 2)
        {
            merge(seq, aux, lo, lo + sz - 1, min(lo + sz * 2 - 1, N - 1));
        }
    }
}

int min(int x, int y)
{
    return x < y ? x : y;
}

void merge(int* seq, int* aux, int lo, int mid, int hi)
{
    for(int i = lo; i <= hi; i++)
        aux[i] = seq[i];

    int j = lo, k = mid + 1;
    for(int i = lo; i <= hi; i++)
    {
        if(j > mid)
            seq[i] = aux[k++];
        else if(k > hi)
            seq[i] = aux[j++];
        else if(aux[j] < aux[k])
            seq[i] = aux[j++];
        else
            seq[i] = aux[k++];
    }
} 
