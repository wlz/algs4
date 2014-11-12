val = [] 
ops = []

def calc(exp):
    for c in exp:
        if c == '(' or c == ' ':
            continue
        elif c == '+' or c == '*':
            ops.append(c)
        elif c == ')':
            op = ops.pop()
            if op == '+':
                val.append(val.pop() + val.pop())
            elif op == '*':
                val.append(val.pop() * val.pop())
        else:
            val.append(ord(c) - 48) 
    return val.pop() 

print calc('(3*(2+3))')
