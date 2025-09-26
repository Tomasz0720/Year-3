void main() {
  // 1. Regular function with explicit return type
  double square(double a) {
    return a * a;
  }

  print("Square of 4: ${square(4)}"); // 16.0

  // 2. Function with default argument
  double cube({double a = 1.0}) {
    return a * a * a;
  }

  print("Cube of 3: ${cube(a: 3)}"); // 27.0
  print("Cube with default: ${cube()}"); // 1.0

  // 3. Lambda function (short-hand function)
  var doubleIt = (x) => 2 * x;
  print("Double of 5: ${doubleIt(5)}"); // 10

  // 4. Anonymous function assigned to variable
  var greet = (String name) {
    return "Hello, $name!";
  };
  print(greet("Ali")); // Hello, Ali!

  // 5. Anonymous function with side effect
  var printUser = (Map<String, String> user) {
    print("First Name: ${user['firstName']}");
    print("Last Name: ${user['lastName']}");
  };

  var user = {'firstName': 'Nikki', 'lastName': 'Smith'};
  printUser(user);

  // 6. Passing anonymous function to forEach
  List<int> numbers = [1, 2, 3, 4];
  numbers.forEach((n) => print("Number squared: ${n * n}"));

  user.forEach(
    (key, value) => print("$key: $value")); // Print key and values using lambda function
  user.forEach((key, value) {
    print("$key: $value");
  }); // Print key and values using anonymous function

  user.forEach((key, value) {print("$key and $value");}); // Anonymous function

  user.forEach((key, value) => print("$key and $value")); // Lambda function
}
