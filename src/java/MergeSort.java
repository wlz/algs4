public class MergeSort
{
    public static void main(String[] args)
    { 
        int[] seq = new int[] { 2, 4, 5, 1, 3, 6, 9, 0, 7, 8 };
        merge_sort(seq);
        print_seq(seq);
    } 

    private static void print_seq(int[] seq)
    {
        for(int i = 0; i < seq.length; i++)
            System.out.print(seq[i] + " "); 
        System.out.println(); 
    }

    private static void merge_sort(int[] seq)
    {
        int[] aux = new int[seq.length];
        merge_sort(seq, aux, 0, seq.length - 1);
    }

    private static void merge(int[] seq, int[] aux, int lo, int mid, int hi)
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

    private static void merge_sort(int[] seq, int[] aux, int lo, int hi)
    {
        if(lo >= hi)
            return;

        int mid = lo + (hi - lo) / 2;
        merge_sort(seq, aux, lo, mid);
        merge_sort(seq, aux, mid + 1, hi);

        merge(seq, aux, lo, mid, hi);
    }
}

