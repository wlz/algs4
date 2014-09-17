using System; 

class Program
{
	int p = 0; 
	string[] stack = new string[10]; 

	static void Main()
	{
		Program p = new Program(); 

		p.Push("to"); 
		p.Push("be"); 
		p.Push("or"); 
		p.Push("not"); 
		p.Push("to"); 

		Console.WriteLine( p.Pop()); 

		p.Push("be"); 

		Console.WriteLine(p.Pop()); 
		Console.WriteLine(p.Pop()); 

		p.Push("that"); 

		Console.WriteLine(p.Pop()); 
		Console.WriteLine(p.Pop()); 
		Console.WriteLine(p.Pop()); 

		p.Push("is"); 
	}

	public void Push(string s)
	{
		stack[p++] = s; 
	}

	public string Pop()
	{
		return stack[--p]; 
	}

	public bool IsEmpty()
	{
		return p == 0; 
	} 
} 
