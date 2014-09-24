public class InsertionSort
{
	public static void main(String[] args)
	{ 
		int[] seq = new int[] {5, 2, 1, 6, 9, 12}; 
		print_seq(seq); 
		insertion_sort(seq); 
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

	private static void insertion_sort(int[] seq)
	{
		for(int i = 0; i < seq.length - 1; i++)
		{
			for(int j = i + 1; j > 0; j--)
			{
				if(seq[j] < seq[j - 1])
					swap(seq, j, j - 1); 
			}
		}
	}	
}



