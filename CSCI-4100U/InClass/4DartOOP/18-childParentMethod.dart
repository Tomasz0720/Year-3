class Animal {
  // Parent method
  void speak() { // Polymorphic method
    print("The animal makes a sound.");
  }
}

class Dog extends Animal {
  @override
  void speak() {
    // Child overrides the parent method
    print("The dog barks.");

    // Call the parent version explicitly
    super.speak();
  }

  void testInside() {
    // This method calls both versions
    speak();       // Calls Dog's overridden method because it's in the same class
    super.speak(); // Calls Animal's method because of "super"
  }
}




void main() {
  Dog dog = Dog();

  // Call overridden method (child version, which also calls parent)
  dog.speak();
  // Output:
  // Speak method of Dog class

  // Call a method that uses both child + parent explicitly
  dog.testInside();
  // Output:
  // The dog barks.
  // The animal makes a sound.

  //how can we call the parent methods from a child object (with the same name)
}
