class Phone {
  String? manufacturer;
  String? model;

  // Short-form constructor:
  // Parameters are automatically assigned to fields
  Phone(this.manufacturer, this.model);

  //?
  
  
}

void main() {
  // Create an object by passing values directly
  Phone phone = Phone('Google', 'Pixel 3XL');
  print('${phone.manufacturer} ${phone.model}');
}
