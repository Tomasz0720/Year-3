// Define a class with two fields (like properties)
class Phone {
  //attributed/properties/fields - by default public
  String? manufacturer;
  String? model;

}

void main() {
  // Create an object (instance) of type Phone
  var phone = Phone();

  // Assign values to the fields
  phone.manufacturer = 'Google';
  phone.model = 'Pixel 3XL';

  // Print out the field values
  print(phone.manufacturer); // Output: Google
  print(phone.model);        // Output: Pixel 3XL
}
