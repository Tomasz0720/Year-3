def fibnonDP(n):
    if n == 0 or n == 1:
        return 1
    else:
        return fibnonDP(n - 1) + fibnonDP(n - 2)
    
def fibDP(n):
    fib = []
    fib.append(1) # fib[0] = fib[1] = 1
    fib.append(1)
    for i in range(2, n + 1):
        fib.append(fib[i - 1] + fib[i - 2])
    return fib[n]
    
print("fib Dynamic: ", fibDP(5))
print("fib Dynamic: ", fibDP(10))
print("fib Dynamic: ", fibDP(15))
print("fib Dynamic: ", fibDP(20))
print("fib Dynamic: ", fibDP(25))
print("fib Dynamic: ", fibDP(30))
print("fib Dynamic: ", fibDP(35))
print("fib Dynamic: ", fibDP(40))
print("fib Dynamic: ", fibDP(100))
print("fib Dynamic: ", fibDP(200))
print("fib Dynamic: ", fibDP(500))
print("fib Dynamic: ", fibDP(1000))

print("\n")

print("fib Non-Dynamic: ", fibnonDP(5))
print("fib Non-Dynamic: ", fibnonDP(10))
print("fib Non-Dynamic: ", fibnonDP(15))
print("fib Non-Dynamic: ", fibnonDP(20))
print("fib Non-Dynamic: ", fibnonDP(25))
print("fib Non-Dynamic: ", fibnonDP(30))
print("fib Non-Dynamic: ", fibnonDP(35))
print("fib Non-Dynamic: ", fibnonDP(40))
print("fib Non-Dynamic: ", fibnonDP(100))
print("fib Non-Dynamic: ", fibnonDP(200))
print("fib Non-Dynamic: ", fibnonDP(500))
print("fib Non-Dynamic: ", fibnonDP(1000))