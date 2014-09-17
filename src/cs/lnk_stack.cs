using System; 

class Program
{
	static void Main()
	{
		Stack p = new Stack(); 

		p.Push("to"); 
		p.Push("be"); 
		p.Push("or"); 
		p.Push("not"); 
		p.Push("to"); 

		Console.WriteLine(p.Pop()); 

		p.Push("be"); 

		Console.WriteLine(p.Pop()); 
		Console.WriteLine(p.Pop()); 

		p.Push("that"); 

		Console.WriteLine(p.Pop()); 
		Console.WriteLine(p.Pop()); 
		Console.WriteLine(p.Pop()); 

		p.Push("is"); 
	}
}

public class Stack
{
	public Node first; 
	public Node current; 

	public void Push(string s)
	{
		if(this.first == null)
		{
			first = new Node(s, null); 
			current = first; 
		}
		else
		{
			Node n = new Node(s, current); 
			current = n; 
		}
	}

	public string Pop()
	{
		string s = current.str; 
		current = current.last; 
		return s; 
	}
}

public struct Node
{
	public string str; 
	public Node last; 

	public Node(string s, Node n)
	{
		str = s; 
		last = n; 
	}
} 
