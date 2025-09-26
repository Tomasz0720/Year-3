
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  // Public method
  void sayHello() {
    print('Hello! My name is $name and I am $age years old.');

    // Call private helper inside a public method
    _checkAdultStatus();
  }

  // Private helper method (note the _ prefix)
  void _checkAdultStatus() {
    if (age >= 18) {
      print('$name is an adult.');
    } else {
      print('$name is not an adult.');
    }
  }
}

void main() {
  var p1 = Person('Alice', 25);
  p1.sayHello();
  // Output:
  // Hello! My name is Alice and I am 25 years old.
  // Alice is an adult.

  var p2 = Person('Nikki', 12);
  p2.sayHello();
  // Output:
  // Hello! My name is Nikki and I am 12 years old.
  // Nikki is not an adult.

  // ❌ Direct call not allowed (best practice):
  // p1._checkAdultStatus(); // discouraged: private
}
