// Entry point of the Dart program
void main() {
  // ------------------------------
  // Primitive (basic) data types
  // ------------------------------

  // A boolean value: can be either true or false
  bool isActive = true;

  // An integer (whole number, positive or negative)
  int count = 42;

  // A double (decimal / floating-point number)
  double price = 19.99;

  // A string (sequence of characters / text)
  String greeting = "Hello, Dart!";

  // Print values to the console
  print(isActive); // Output: true
  print(count); // Output: 42
  print(price); // Output: 19.99
  print(greeting); // Output: Hello, Dart!

  // ------------------------------
  // Nullable types
  // ------------------------------

  // By default, variables in Dart cannot hold null values.
  // If you uncomment the next two lines, the code will cause
  // a compile-time error because 'maybeNumber' is not initialized
  // and is non-nullable.

  // int maybeNumber;
  // print(maybeNumber);

  String? professorName = "Ali";

  // You MUST check for null first

  if (professorName != null) {
    print(professorName.length);
  }

  // To make it nullable, you must explicitly add a '?':
  int? maybeNumber = null;
  print(maybeNumber); // Output: null
}
