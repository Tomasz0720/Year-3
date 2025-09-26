void main() {
  
  // PART 1
  // SCALING GRADES
  
  var grades = <double>[]; // Make an empty double list

  for (var i = 0; i <= 100; i++) { // Start at 0, increment by 1 until i <= 100, then add to the list
    grades.add(i.toDouble());
  }
  
  var scaledGrades = grades.map((g) => (g / 100 * 30) + 2).toList(); // Map to 0-30 and add 2
  
  print("List of scaled grades: $scaledGrades \n");
  
  
  //PART 2
  //FILTER PASSING GRADES
  
  var filteredList = scaledGrades.where((g) => g >= 15).toList();
    
  print("List of grades >= 15: $filteredList \n");
  
  
  //PART 3
  //SORTING NUMBERS
  
  final integers = <int>[5, 2, 9, 1, 7];
  
  integers.sort();
  
  print("List of sorted numbers: $integers \n");
  
  print("Each number of integers on its own line:");
  
  for(var value in integers){
    print("$value");
  }
    
  
  //PART 4
  //INSERT AND ADD VALUES
  
  final nums = <int>[10, 20, 30];
  
  nums.insert(0, 5);
  
  print("\nList with number inserted: $nums \n");
  
  var sum = 0;
  var i = 0;
  
  while(i < nums.length){
    sum += nums[i];
    i++;
  }
  
  print("Sum of values: $sum \n");
  
  
  //PART 5
  //DYNAMIC LIST
  
  List<dynamic> dynamicList = [67, "hello", true, 3.14];
  
  print("Dynamic List: $dynamicList \n");

  dynamicList.forEach((item) {
    if (item is int) {
      print("Int doubled: ${item * 2}");
    } else {
      print(item);
    }
  });
  
  print("");
  
  
  //PART 6
  //USING CONST AND FINAL
  
  const List<int> constList = [2, 4, 6, 8, 10];
  final List<int> finalList = [1, 3, 5, 7, 9];
  
  // constList.add(12); Causes an error because const lists are immutable.
  // constList = [1, 2, 3]; Causes an error becasue we cannot reassign a const variable.

  finalList.add(10); // This is fine.
  // finalList = [0, 2, 4]; // Causes an error because we cannot reassign a final variable.

  
  // Difference: const is completely immutable, meaning we cannot change contents or reassign, in final variables cannot be reassigned, but the contents of the object it points to can be modified.

  print("Elements in finalList:");
  for(var item in finalList){
    print(item);
  }
  
  print("");
  
  
  //PART 7
  //COMPARISON EXAMPLE: FINAL VS CONST, VAR VS DYNAMIC
  
  final List<int> finalExample = [1, 2, 3];
  
  // Adding an item
  finalExample.add(4); // OK
  
  // Inserting an item
  finalExample.insert(0, 0); // OK
  
  // Reassigning list
  //finalExample = [0, 1, 2, 3, 4]; Final list can not be reassigned!
  
  
  const List<int> constExample = [1, 2, 3];
  
  // Adding an item
  //constExample.add(4); // Runtime error, const list can not be changed at all
  
  // Inserting an item
  //constExample.insert(0, 0); // Runtime error, const list can not be changed at all
  
  // Reassigning list
  //constExample = [0, 1, 2, 3, 4]; Runtime error, const list can not be changed at all
  
  
  var varExample = "Hi"; // Var is a string
  
  // Trying to change type
  // varExample = 67; Error, can't change a string var to an int var
  
  
  dynamic dynamicExample = 67;
  
  // Trying to change type
  dynamicExample = 3.14;
  
  dynamicExample = false;
  
  dynamicExample = "Hello, World!";
  
  print("Printing contents of finalExample after modification:");
  finalExample.forEach((item) {
    print(item);
  });
}