import java.util.Random;

public class Shuffle
{
    public static void main(String[] args)
    { 
        int[] seq = new int[] { 9, 1, 2, 6, 8, 4, 5, 7, 0, 3 };
        shuffle(seq);
        print_seq(seq);
    } 

    private static void shuffle(int[] seq)
    {
        Random rnd = new Random();
        for(int i = 1; i < seq.length; i++)
        {
            int loc = rnd.nextInt(i);

            int tmp = seq[i];
            seq[i] = seq[loc];
            seq[loc] = tmp;
        } 
    }

    private static void print_seq(int[] seq)
    {
        for(int i = 0; i < seq.length; i++)
            System.out.print(seq[i] + " "); 
        System.out.println(); 
    } 
}
