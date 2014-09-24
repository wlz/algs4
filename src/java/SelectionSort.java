public class SelectionSort 
{
	public static void main(String[] args)
	{ 
		int[] seq = new int[]{6, 2, 5, 9, 1, 8, 10, 3, 7}; 
		print_seq(seq);
		selection_sort(seq);
		print_seq(seq); 
	} 

	private static void print_seq(int[] seq)
	{
		for(int i = 0; i < seq.length; i++)
			System.out.print(seq[i] + " "); 

		System.out.println(); 
	}

	private static void swap(int[] seq, int i, int j)
	{
		int tmp = seq[i];
		seq[i] = seq[j];
		seq[j] = tmp;
	}

	private static void selection_sort(int[] seq)
	{
		for(int i = 0; i < seq.length-1; i++)
		{
			int min = i;
			for(int j = i+1; j < seq.length; j++)
			{
				if(seq[j] < seq[min])
					min = j;
			}
			swap(seq, i, min);
		}
	}
}


