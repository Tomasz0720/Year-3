def get_digit(num, digit):

    working = num // (10 ** (digit - 1))
    return working % 10

def radix_sort(arr):

    max_digits = 6

    for k in range(1, max_digits + 1):
        
        buckets = [[] for _ in range(10)]

        for number in arr:
            digit_value = get_digit(number, k)
            
            buckets[digit_value].append(number)

        arr = []
        for bucket in buckets:
            arr.extend(bucket)
            
    return arr

# Example usage
numbers = [170, 45, 75, 90, 802, 24, 2, 66]
sorted_numbers = radix_sort(numbers)
print("Sorted array:", sorted_numbers)

# Output: Sorted array: [2, 24, 45, 66, 75, 90, 170, 802]

# Example usage
numbers = [329, 457, 657, 839, 436, 720, 355]
sorted_numbers = radix_sort(numbers)
print("Sorted array:", sorted_numbers)
# Output: Sorted array: [329, 355, 436, 457, 657, 720, 839]

# Example usage
numbers = [500000, 40000, 300000, 20000, 999999, 10000]
sorted_numbers = radix_sort(numbers)
print("Sorted array:", sorted_numbers)
# Output: Sorted array: [10000, 20000, 300000, 40000, 500000, 999999]