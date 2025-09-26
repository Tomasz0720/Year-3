
// Abstract class as an interface
abstract class SmartPhone {
  void call();
}

// Pixel implements SmartPhone
class Pixel3XL implements SmartPhone {
  @override
  void call() { // If the parent class is abstract, the child MUST implement the method.
    print('Calling from a Pixel 3XL');
  }
}

// iPhone also implements SmartPhone
class IPhone15 implements SmartPhone {
  @override
  void call() {
    print('Calling from an iPhone 15');
  }
}

void main() {
  // Polymorphism: both objects are treated as SmartPhone
  SmartPhone phone1 = Pixel3XL();
  SmartPhone phone2 = IPhone15();

  phone1.call();  // Output: Calling from a Pixel 3XL
  phone2.call();  // Output: Calling from an iPhone 15
}
