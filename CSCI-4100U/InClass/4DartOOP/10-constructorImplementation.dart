
class User {
  String? name;
  int? age;

  // Constructor with validation
  User(String n, int a) {
    if (a < 0) {
      throw ArgumentError('Age cannot be negative');
    }
    name = n;
    age = a;
  }
}

void main() {
  var u1 = User('Ali', 35);
  print('${u1.name}, age ${u1.age}'); // Ali, age 35

  // var u2 = User('Nikki', -5); // ❌ Will throw ArgumentError
}
