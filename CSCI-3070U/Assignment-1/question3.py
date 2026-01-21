def find_dominant(nums, lo=None, hi=None):
    # Initialize bounds on the first call
    if lo is None and hi is None:
        lo, hi = 0, len(nums) - 1

    # Base case: empty list
    if not nums:
        return None

    # Base case: single element
    if lo == hi:
        return nums[lo]

    mid = (lo + hi) // 2

    # Recursive calls (same function)
    left_major = find_dominant(nums, lo, mid)
    right_major = find_dominant(nums, mid + 1, hi)

    # Combine step
    if left_major == right_major:
        candidate = left_major
    else:
        left_count = sum(1 for i in range(lo, hi + 1) if nums[i] == left_major)
        right_count = sum(1 for i in range(lo, hi + 1) if nums[i] == right_major)
        candidate = left_major if left_count > right_count else right_major

    # Only verify once at the very top level
    if lo == 0 and hi == len(nums) - 1:
        if nums.count(candidate) > len(nums) // 2:
            return candidate
        return None

    return candidate


print(find_dominant([3, 3, 4, 2, 3, 3, 3]))  # → 3
print(find_dominant([1, 2, 3, 4]))           # → None