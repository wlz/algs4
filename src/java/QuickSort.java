import java.util.Random;

public class QuickSort
{
    private static int[] seq = new int[10];

    public static void main(String[] args)
    { 
        init();
        quickSort();
        printSeq();
    } 

    private static void init()
    {
        for(int i = 0; i < seq.length; i++)
            seq[i] = i;

        shuffle();
    }

    private static void shuffle()
    {
        Random rand = new Random();
        for(int i = 1; i < seq.length; i++)
        {
            int loc = rand.nextInt(i); 
            swap(i, loc);
        } 
    }

    private static int partition(int lo, int hi)
    {
        int i = lo, j = hi + 1;
        while(true)
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

    private static void quickSort()
    {
        quickSort(0, seq.length - 1);
    }

    private static void quickSort(int lo, int hi)
    {
        if(lo >= hi)
            return;
        int j = partition(lo, hi);
        quickSort(lo, j - 1);
        quickSort(j + 1, hi); 
    }

    private static void swap(int p, int q)
    {
        int t = seq[p];
        seq[p] = seq[q];
        seq[q] = t;
    }

    private static void printSeq()
    {
        for(int i = 0; i < seq.length; i++)
            System.out.print(seq[i] + " "); 
        System.out.println(); 
    }
} 
