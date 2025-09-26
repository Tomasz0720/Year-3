void main() {
  // Example list of grades
  List<int> grades = [85, 92, 76, 100, 88];

  // -----------------------------------
  // 1. Standard for loop
  // -----------------------------------
  print("For loop:");
  for (var i = 0; i < grades.length; i++) {
    print("Grade ${i + 1}: ${grades[i]}");
  }

  // -----------------------------------
  // 2. While loop
  // -----------------------------------
  print("\nWhile loop:");
  int j = 0;
  while (j < grades.length) {
    print("Grade ${j + 1}: ${grades[j]}");
    j++;
  }

  // -----------------------------------
  // 3. Reverse loop
  // -----------------------------------
  print("\nReverse loop:");
  for (int i = grades.length ; i >= 0; i--) { // ---
    print("Grade in reverse: ${grades[i]}");
  }

  // -----------------------------------
  // 4. For-in loop (for-each style)
  // -----------------------------------
  print("\nFor-in loop:");
  for (int grade in grades) {
    print("Grade: $grade");
  }
}
