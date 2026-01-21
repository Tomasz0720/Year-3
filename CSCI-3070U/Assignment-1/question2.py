def find_max(A):
    left = 0 # O(1)
    right = len(A) - 1 # O(1)

    while left < right: # O(log n)
        mid = left + (right - left) // 2 # O(1)
        
        if A[mid] < A[mid + 1]: # O(1)
            left = mid + 1 # O(1)
            
        else: 
            right = mid # O(1)
    
    return A[left] # O(1)


# Test cases

A1 = [3, 5, 7, 9, 3, 1]
print(f"Array: {A1}")
print(f"Maximum: {find_max(A1)}")  # Output 9
print()

A2 = [10, 8, 6, 4, 2]
print(f"Array: {A2}")
print(f"Maximum: {find_max(A2)}")  # Output 10
print()

A3 = [1, 3, 5, 7, 9]
print(f"Array: {A3}")
print(f"Maximum: {find_max(A3)}")  # Output 9
print()

A4 = [1, 2, 3, 4, 5, 4, 3, 2, 1]
print(f"Array: {A4}")
print(f"Maximum: {find_max(A4)}")  # Output 5
print()

A5 = [100]
print(f"Array: {A5}")
print(f"Maximum: {find_max(A5)}")  # Output 100
print()