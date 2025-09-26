
class Phone {
  // Fields (instance variables)
  String? manufacturer;
  String? model;

  // Long-form constructor
  Phone(String manu, String model) {
    // Use 'this' to assign parameters to fields
    this.manufacturer = manu;
    this.model = model;
  }
}

void main() {
  // Create an object by calling the constructor
  Phone phone = Phone('Google', 'Pixel 3XL');
  print('${phone.manufacturer} ${phone.model}');
}
