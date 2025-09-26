//creating objects and assign values to properties without using constructor
class Phone {
  String? manufacturer;
  String? model;
}

void main() {
  // Create three phones
  var g1 = Phone()..manufacturer = 'Google'..model = 'Pixel 6';
  var g2 = Phone()..manufacturer = 'Google'..model = 'Pixel 8';
  var s1 = Phone()..manufacturer = 'Samsung'..model = 'S23';

  // Put them all in a list
  var all = [g1, g2, s1];

  // Print only the Google phones
  for (var p in all) {
    if (p.manufacturer == 'Google') {
      print('${p.manufacturer} ${p.model}');
    }
  }
}
