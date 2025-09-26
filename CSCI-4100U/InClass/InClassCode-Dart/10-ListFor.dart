void main() {
  // -----------------------------------
  // 1. Dynamic list with mixed types
  // -----------------------------------
  List<dynamic> items = [1, 2, 'hello', true];

  int total = 0;

  // Try to add all items to total
  for (var item in items) {
    // total += item; //?

    // -----------------------------------
    // 2. Safer approach: type checking
    // -----------------------------------
    if (item is int) {
      total += item; // Only add if it's an integer
    }
  }

  print("Total = $total");
  // Output: Total = 3 (1 + 2)
}
