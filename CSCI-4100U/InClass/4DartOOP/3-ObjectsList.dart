//make a list of objects
class Phone {
  String? manufacturer;
  String? model;
}

void main() {
  // A list to hold multiple Phone objects
  var phones = <Phone>[];
  dynamic phones2 = <Phone>[];

  // Create three phones
  var a = Phone();
  a.manufacturer = 'Nokia';
  a.model = '3310';

  var b = Phone();
  b.manufacturer = 'OnePlus';
  b.model = '12 Pro';

  var c = Phone();
  c.manufacturer = 'Google';
  c.model = 'Pixel 7a';

  // Add them to the list
  phones.addAll([a, b, c]);

  // Print each phone from the list
  for (var p in phones) {
    print('${p.manufacturer} ${p.model}');
  }

  
}
