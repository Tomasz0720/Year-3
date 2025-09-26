class Phone {
  String? manufacturer;
  String? model;
}

void main() {
  
  //error if we do not initiate - using properties
  Phone apple;
  //print('${apple.manufacturer} ${apple.model}');

  // Declare first, assign later
  late Phone phone;

  //initiate later
  phone = Phone();

  //using the object
  phone.manufacturer = 'Google';
  phone.model = 'Pixel 3XL';

  print('${phone.manufacturer} ${phone.model}');

  late String name;
  //print(name); // Runtime error: LateInitializationError
}
