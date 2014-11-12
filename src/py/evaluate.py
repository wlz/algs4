val = [] 
ops = []

def calc(exp):
    for c in exp:
        if c == '(' or c == ' ':
            continue
        elif c == '+' or c == '*':
            ops.append(c)
        elif c == ')':
            v1 = val.pop()
            v2 = val.pop()
            op = ops.pop()
            if op == '+':
                val.append(v1 + v2)
            elif op == '*':
                val.append(v1 * v2)
        else:
            val.append(ord(c) - 48) 
    return val.pop() 

print calc('(3*(2+3))')
