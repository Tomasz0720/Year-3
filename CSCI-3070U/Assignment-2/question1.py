def minimum_edit_distance(source, target):

    n = len(source)
    m = len(target)
    
    dp = []
    
    # Initialize DP table
    for _ in range(n + 1):
        dp.append([0] * (m + 1))
        
    # Initialize base cases
    for i in range(n + 1):
        dp[i][0] = i
    for j in range(m + 1):
        dp[0][j] = j
    
    
    # Fill the DP table
    for i in range(1, n + 1):
        for j in range(1, m + 1):
            if source[i - 1] == target[j - 1]:
                dp[i][j] = dp[i - 1][j - 1]
            else:
                dp[i][j] = 1 + min(
                    dp[i][j - 1],    # Insertion
                    dp[i - 1][j],    # Deletion
                    dp[i - 1][j - 1] # Substitution
                )
                
    return dp[n][m]

# Example usage
source = "spoof"
target = "stool"
distance = minimum_edit_distance(source, target)
print(f"Edit Distance from '{source}' to '{target}': {distance}")

# Output: Edit Distance from 'spoof' to 'stool': 3

# Example usage
source = "podiatrist"
target = "pediatrician"
distance = minimum_edit_distance(source, target)
print(f"Edit Distance from '{source}' to '{target}': {distance}")

# Output: Edit Distance from 'podiatrist' to 'pediatrician': 6

# Example usage
source = "blaming"
target = "conning"
distance = minimum_edit_distance(source, target)
print(f"Edit Distance from '{source}' to '{target}': {distance}")