// we can change/updated the value of properties 
class Phone {
  String? manufacturer;
  String? model;
}

void main() {
  // Create a phone and set its fields
  var phone = Phone();
  phone.manufacturer = 'Google';
  phone.model = 'Pixel 8';

  // Change the model later
  phone.model = 'Pixel 9';

  // Shows updated value
  print('${phone.manufacturer} ${phone.model}'); // Google Pixel 9
}
