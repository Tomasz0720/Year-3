
class User {
  String? name;
  int? age;

  // Main constructor
  User(this.name, this.age);

  // Redirecting constructor (calls the main one with default values)
  User.guest() : this('Guest', 0);

  // Redirecting constructor (name only, default age = 18)
  User.withName(String name) : this(name, 18);

  void introduce() {
    print("Hi, I'm $name and I'm $age years old.");
  }
}

void main() {
  var u1 = User('Alice', 25);
  u1.introduce(); // Hi, I'm Alice and I'm 25 years old.

  var u2 = User.guest();
  u2.introduce(); // Hi, I'm Guest and I'm 0 years old.

  var u3 = User.withName('Bob');
  u3.introduce(); // Hi, I'm Bob and I'm 18 years old.
}
