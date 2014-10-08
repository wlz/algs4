import java.util.Random;

public class QuickSelect
{
    private static int[] seq = new int[10];

    public static void main(String[] args)
    { 
        init();
        System.out.println(quickSelect(6));   
    } 

    private static int quickSelect(int k)
    {
        int lo = 0, hi = seq.length - 1;
        while(true)
        {
            if(lo >= hi)
                break;

            int j = partition(lo, hi);
            if(j > k)
                hi = j - 1;
            else if(j < k)
                lo = j + 1;
            else
                return seq[k];
        }

        return seq[k];
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

    private static void printSeq()
    {
        for(int i = 0; i < seq.length; i++)
            System.out.print(seq[i] + " "); 
        System.out.println(); 
    }

    private static void init()
    {
        for(int i = 0; i < seq.length; i++)
            seq[i] = i;

        Random rnd = new Random();
        for(int i = 1; i < seq.length; i++)
        {
            int r = rnd.nextInt(i);
            swap(i, r);
        }
    }

    private static void swap(int p, int q)
    {
        int t = seq[p];
        seq[p] = seq[q];
        seq[q] = t;
    }
}

