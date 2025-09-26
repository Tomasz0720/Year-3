void main() {
  List<int> grades = [95, 42, 76, 88, 100, 30];

  // -----------------------------------
  // 1. map() → transform each element
  // Square each grade
  // -----------------------------------
  List<int> squared = grades.map((g) => g * g).toList();
  print("Squared grades: $squared");
  // Output: [9025, 1764, 5776, 7744, 10000, 900]

  // -----------------------------------
  // 2. where() → filter items by condition
  // Keep only passing grades (>= 50)
  // -----------------------------------
  List<int> passing = grades.where((g) => g >= 50).toList();
  print("Passing grades: $passing");
  // Output: [95, 76, 88, 100]

  // -----------------------------------
  // 3. Combine map() + where()
  // Example: Square only the passing grades
  // -----------------------------------
  List<int> squaredPassing = grades
      .where((g) => g >= 50)        // filter
      .map((g) => g * g)            // transform
      .toList();
  print("Squared passing grades: $squaredPassing");
  // Output: [9025, 5776, 7744, 10000]
}
