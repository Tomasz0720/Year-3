// -------- Abstract Class --------
// Abstract means: cannot create an object directly.
// It can have abstract methods (no body) and normal methods.
abstract class LivingThing {
  void breathe(); // abstract method (must be implemented by subclasses)

  void exist() {
    print("I exist as a living thing.");
  }
}

// -------- Mixin --------
mixin CanRun {
  int speed = 10; // Attribute inside mixin

  void run() {
    print("Running at speed $speed!");
  }
}

// -------- Base Class --------
class Animal extends LivingThing {
  // Private attribute
  String _name;

  // Short-form constructor
  Animal(this._name);

  // Getter
  String get name => _name;

  // Setter with validation
  set name(String newName) {
    if (newName.isEmpty) {
      print("Name cannot be empty!");
    } else {
      _name = newName;
    }
  }

  // Implement abstract method from LivingThing
  @override
  void breathe() {
    print("$_name is breathing...");
  }

  // Public method
  void speak() {
    print("Animal makes a sound.");
  }

  // Private method
  void _secretThought() {
    print("I'm an animal but nobody knows my thoughts!");
  }

  void revealSecret() {
    _secretThought();
  }
}

// -------- Child Class --------
class Dog extends Animal with CanRun {
  // Passes name to parent constructor
  Dog(String name) : super(name);

  // Override method
  @override
  void speak() {
    print("$name says: Woof!");
  }
}

void main() {
  // Dog object
  Dog myDog = Dog("Buddy");

  myDog.speak();     // From Dog
  myDog.run();       // From mixin
  myDog.breathe();   // From abstract class implementation
  myDog.exist();     // Normal method from abstract class

  // Getter and Setter
  print("Dog's name is: ${myDog.name}");
  myDog.name = "";        // Invalid
  myDog.name = "Charlie"; // Valid
  print("Updated name: ${myDog.name}");

  myDog.revealSecret();

  // ---------- Lambda Function ----------
  var doubleIt = (int x) => x * 2;
  print("Double of 5 is: ${doubleIt(5)}");

  // ---------- Anonymous Function ----------
  var numbers = [1, 2, 3];
  numbers.forEach((n) {
    print("Number: $n");
  });
}
