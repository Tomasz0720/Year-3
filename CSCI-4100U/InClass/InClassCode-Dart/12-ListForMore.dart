void main() {
  // Example list of student names
  List<String> students = ["Ali", "Maryam", "Nikki"];

  // -----------------------------------
  // 1. Incorrect way: modifying the loop variable
  // -----------------------------------
  for (var s in students) {
    s = "Changed"; // ?
  }
  // Output: ?
  //..........

  // -----------------------------------
  // 2. Correct way: use index to modify list items
  // -----------------------------------
  for (var i = 0; i < students.length; i++) {
    students[i] = "Changed"; // ✅ Directly modifies the list element
  }
  print("After correct modification: $students");
  // Output: [Changed, Changed, Changed]
}
