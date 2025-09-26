void main() {
  // -------------------------------------
  // 1. Explicit typing (strongly typed)
  // -------------------------------------
  int age = 30;            // age must always be an integer
  String name = "Ali";     // name must always be a string
  bool isStudent = false;  // must always be true/false


  print("$name is $age years old. Student: $isStudent");


  // -------------------------------------
  // 2. Type inference with 'var'
  // -------------------------------------
  var city = "Toronto";   // Dart infers this is a String
  var score = 95;         // Dart infers this is an int


  // ⚠️ After inference, the type is locked.
  //city = 123;   // ❌ ERROR: can't assign int to a String
  print("City: $city, Score: $score");

  // -------------------------------------
  // 3. Using 'dynamic'
  // -------------------------------------
  dynamic flexible = "hello";   // Can start as a String
  print(flexible);              // Output: hello

  flexible = 123;               // Can change to an int
  print(flexible);              // Output: 123
  //problem?
}
