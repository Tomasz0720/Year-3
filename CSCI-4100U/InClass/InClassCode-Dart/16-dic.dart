void main() {
  // -----------------------------------
  // 1. Creating a Map (student IDs → grades)
  // -----------------------------------
  Map<String, int> grades = {
    '100000001': 85,
    '100000002': 92,
    '100000003': 67,
  };

  // -----------------------------------
  // 2. Access values using keys
  print("Grade of 100000001: ${grades['100000001']}"); // 85

  // Update an existing student's grade
  grades['100000001'] = 90;  
  print("Updated grade of 100000001: ${grades['100000001']}"); // 90

  // Add a new student
  grades['100000004'] = 78;
  print("Added new student 100000004 with grade: ${grades['100000004']}");

  // -----------------------------------
  // 3. Map functions
  // -----------------------------------
  // Check if a key exists
  print("Contains student 100000003? ${grades.containsKey('100000003')}"); // true

  // Remove a student
  grades.remove('100000002');
  print("After removing 100000002: $grades");

  // Print all keys
  print("\nAll student IDs:");
  grades.keys.forEach(print);

  // Print all values
  print("\nAll grades:");
  grades.values.forEach(print);

  // -----------------------------------
  // 4. Loop through entries
  // -----------------------------------
  print("\nLoop through Map entries:");
  grades.forEach((id, grade) {
    print("Student $id has grade $grade");
  });
}
