
class User {
  String? name;
  int? age;

  // Default short-form constructor
  User(this.name, this.age);

  // Named constructor: teenager with validation
  User.teenager(String name, int age) {
    if (age < 13 || age > 19) {
      throw ArgumentError('Teenagers must be between 13 and 19.');
    }
    this.name = name;
    this.age = age;
  }

  // Named constructor: guest user with default values
  User.guest() {
    name = 'Guest';
    age = 0;
  }

  void introduce() {
    print("Hi, I'm $name and I'm $age years old.");
  }
}

void main() {
  // Using default constructor
  var u1 = User('Alice', 25);
  u1.introduce(); // Hi, I'm Alice and I'm 25 years old.

  // Using named constructor with validation
  var u2 = User.teenager('Bob', 16);
  u2.introduce(); // Hi, I'm Bob and I'm 16 years old.

  // Using named constructor with default values
  var u3 = User.guest();
  u3.introduce(); // Hi, I'm Guest and I'm 0 years old.
}
