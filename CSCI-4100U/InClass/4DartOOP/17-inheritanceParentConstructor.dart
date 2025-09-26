// When you're creating an object of a child 
// class, you also create an object of the 
// parent and grandparent classes because
// the child class inherits their properties
// and methods.

// Parent class
class Device {
  String _manufacturer;

  // Constructor for Device
  Device(this._manufacturer);
  
}

// Child class
class Phone extends Device {
  String _model;

  // Constructor for Phone
  // Calls parent constructor using "super"
  Phone(String manu, this._model) : super(manu); // Create an object of parent class inside the child class (super(manu)).

  @override
  String toString() {
    return '$_manufacturer $_model';
  }
}

void main() {
  var phone = Phone('Google', 'Pixel 3XL'); // Execute the constuctor of phone, and you're PASSING the manufacturer to the parent constructor super(manu).
  // Executing line 22.

  print(phone); // Output: Google Pixel 3XL
}
