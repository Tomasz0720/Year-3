void main() {
  List<int> grades = [95, 42, 76, 88, 100, 30];

  // -----------------------------------
  // 1. take() → get first n elements
  // -----------------------------------
  print("First 2 grades (using take):");
  grades.take(2).forEach((g) => print(g));
  // Output: 95, 42

  // -----------------------------------
  // 2. sort() → custom sort (descending order)
  // -----------------------------------
  grades.sort((a, b) => b - a);
  print("\nGrades sorted descending:");
  print(grades);
  // Output: [100, 95, 88, 76, 42, 30]

  // -----------------------------------
  // 3. reduce() → combine list into one value
  // -----------------------------------
  int total = grades.reduce((a, b) => a + b);
  print("\nTotal of grades: $total");
  // Output: 431

  // -----------------------------------
  // 4. every() → check if all match condition
  // -----------------------------------
  bool allPositive = grades.every((g) => g > 0);
  print("\nAll grades are positive? $allPositive");
  // Output: true
}