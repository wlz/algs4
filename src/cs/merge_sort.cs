using System;

public class Program
{
	public static void Main()
	{ 
        int[] seq = new int[] { 2, 4, 5, 1, 3, 6, 9, 0, 7, 8 }; 
        MergeSort(seq); 
        PrintSeq(seq);
	} 

    private static void PrintSeq(int[] seq)
    {
        for(int i = 0; i < seq.Length; i++)
            Console.Write(seq[i].ToString() + " ");
        Console.WriteLine();
    }

    private static void MergeSort(int[] seq)
    {
        int[] aux = new int[seq.Length];
        MergeSort(seq, aux, 0, seq.Length - 1);
    }

    private static void MergeSort(int[] seq, int[] aux, int lo, int hi)
    {
        if(lo >= hi)
            return;

        int mid = lo + (hi - lo) / 2;

        MergeSort(seq, aux, lo, mid);
        MergeSort(seq, aux, mid + 1, hi);

        Merge(seq, aux, lo, mid, hi); 
    }

    private static void Merge(int[] seq, int[] aux, int lo, int mid, int hi)
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
}

