
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void sayHello() {
    print('Hello! My name is $name and I am $age years old.');
  }

  // Another method
  void birthday() {
    age++;
    print("Happy Birthday, $name! You are now $age.");
  }
}

void main() {
  var p1 = Person('Bob', 30);
  p1.sayHello();    // Hello! My name is Bob and I am 30 years old.
  p1.birthday();    // Happy Birthday, Bob! You are now 31.
}
