public class Weighted
{
	public int[] seq = new int[10]; 
	public int[] sz = new int[10]; 

	public static void main(String[] args)
	{
		Weighted q = new Weighted();
		q.init();

		q.setUnion(4, 3); 
		q.setUnion(3, 8); 
		q.setUnion(6, 5); 
		q.setUnion(9, 4); 

		System.out.println(q.connected(8, 9)); 
		System.out.println(q.connected(5, 4)); 

		q.setUnion(5, 0); 
		q.setUnion(7, 2); 
		q.setUnion(6, 1); 
		q.setUnion(7, 3); 

		System.out.println(q.connected(2, 3)); 
	}

	public void init()
	{
		for(int i = 0; i < 10; i++)
		{
			seq[i] = i; 
			sz[i] = 1; 
		}
	}

	public void setUnion(int p, int q)
	{
		if(sz[p] < sz[q])
		{
			seq[root(q)] = seq[p];
			sz[p]++;
		}
		else
		{
			seq[root(p)] = seq[q];
			sz[q]++;
		}
	}

	public boolean connected(int p, int q)
	{
		return root(p) == root(q);
	}

	public int root(int n)
	{
		return seq[n] == n ? n : root(seq[n]); 
	}
}


