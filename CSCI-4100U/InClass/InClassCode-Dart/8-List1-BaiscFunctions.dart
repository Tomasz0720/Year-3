void main() {
  // =====================================
  // Example 1: List of Strings (fruits)
  // =====================================
  List<String> fruits = ["Apple", "Banana", "Cherry"]; //only strings - generics 
  print("Initial fruits: $fruits");
  // Output: [Apple, Banana, Cherry]

  fruits.add("Mango");          // Add to the end
  print("After add: $fruits"); 
  // Output: [Apple, Banana, Cherry, Mango]

  print(fruits[0]);             // Access by index → Apple
  fruits[1] = "Blueberry";      // Modify at index
  print("After modify: $fruits");
  // Output: [Apple, Blueberry, Cherry, Mango]

  fruits.removeAt(2);           // Remove item at index 2
  print("After removeAt: $fruits");
  // Output: [Apple, Blueberry, Mango]

  // Iterate over the list
  for (var fruit in fruits) {
    print("I like $fruit");
  }

  // =====================================
  // Example 2: List of Doubles (grades)
  // =====================================
  List<double> grades = [85.0, 92.5, 70.0, 88.5];
  print("\nInitial grades: $grades");
  // Output: [85.0, 92.5, 70.0, 88.5]

  grades.insert(0, 100.0);      // Insert 100.0 at index 0 - shifts to right
  print("After insert: $grades");
  // Output: [100.0, 85.0, 92.5, 70.0, 88.5]

  bool has70 = grades.contains(70.0);  // Check if 70.0 exists
  print("Contains 70.0? $has70");      // Output: true

  grades.sort();                // Sort in ascending order
  print("After sort: $grades");
  // Output: [70.0, 85.0, 88.5, 92.5, 100.0]

  print("Number of grades: ${grades.length}");
  // Output: 5
}
