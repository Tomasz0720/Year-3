def solve_fractional_knapsack(weights, values, capacity):

    items = []
    n = len(values)
    
    # Create list of [value, weight] pairs
    for i in range(n):
        pair = [values[i], weights[i]]
        items.append(pair)

    # Sort items by value-to-weight ratio in descending order
    items.sort(key=lambda x: x[0] / x[1], reverse=True)

    # Add items to the knapsack
    total_value = 0.0
    current_capacity = capacity

    for item in items:
        value = item[0]
        weight = item[1]

        # If the knapsack is full- stop
        if current_capacity == 0:
            break

        # Case 1- Take 100% (1.0) of the item
        if weight <= current_capacity:
            current_capacity -= weight
            total_value += value
            
        # Case 2- Take a fraction of the item
        else:
            fraction = current_capacity / weight
            total_value += value * fraction
            current_capacity = 0 
            break 

    return total_value

# Example usage
weights = [10, 20, 30]
values = [60, 100, 120]
capacity = 50
max_value = solve_fractional_knapsack(weights, values, capacity)
print(f"Maximum value in Knapsack = {max_value}")
# Output: Maximum value in Knapsack = 240.0

# Example usage
weights = [5, 10, 15]
values = [10, 30, 20]
capacity = 25
max_value = solve_fractional_knapsack(weights, values, capacity)
print(f"Maximum value in Knapsack = {max_value}")
# Output: Maximum value in Knapsack = 50.0