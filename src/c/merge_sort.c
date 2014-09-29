#include <stdio.h>
#define CNT 10

void print_seq(int* p); 
void merge_sort(int* seq, int* aux, int lo, int hi);
void merge(int* seq, int* aux, int lo, int mid, int hi);
void sort(int* seq); 

int main()
{
    int seq[CNT] = { 9, 1, 3, 5, 2, 4, 7, 6, 8, 0 }; 

    sort(seq);
    print_seq(seq);

    return 0; 
}

void print_seq(int* p)
{
    for(int i = 0; i < CNT; i++)
        printf("%d ", p[i]); 
    printf("\n"); 
}

void merge_sort(int* seq, int* aux, int lo, int hi)
{
    if(hi <= lo)
        return;
    int mid = lo + (hi - lo) / 2;

    merge_sort(seq, aux, lo, mid);
    merge_sort(seq, aux, mid + 1, hi);

    merge(seq, aux, lo, mid, hi);
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
        else if(aux[j] >= aux[k])
            seq[i] = aux[k++];
        else
            seq[i] = aux[j++]; 
    }
}

void sort(int* seq)
{
    int aux[CNT] = { 0 }; 
    merge_sort(seq, aux, 0, CNT - 1); 
}
