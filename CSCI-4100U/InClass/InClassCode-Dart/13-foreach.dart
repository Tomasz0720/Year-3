void main() {
  List<int> grades = [95, 42, 76, 88, 100, 30];

  // -----------------------------------
  // 1. Using forEach with an anonymous function
  // -----------------------------------
  print("Using forEach (anonymous function):");
  grades.forEach((grade) {
    print("Grade: $grade");
    //more code
  });

  // -----------------------------------
  // 2. Using forEach with a lambda function (short form)
  // -----------------------------------
  print("\nUsing forEach (lambda):");
  grades.forEach((grade) => print("Grade: $grade"));

  // -----------------------------------
  // 3. Limitation: can't use break or continue in forEach
  // -----------------------------------
  print("\nTrying to skip grades < 50 (not possible with forEach):");
  grades.forEach((grade) {
    if (grade < 50) {
      // ❌ continue; or break; would cause errors
      print("Skipping grade $grade (pretend skip, can't really continue here)");
    } else {
      print("Grade: $grade");
    }
  });

  // -----------------------------------
  // 4. Correct way: use a traditional for loop if you need break/continue
  // -----------------------------------
  print("\nCorrect way with traditional for loop (skip < 50):");
  for (var grade in grades) {
    if (grade < 50) continue; // ✅ works fine here
    print("Grade: $grade");
  }
}
