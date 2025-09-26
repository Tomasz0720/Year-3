// A mixin is declared with the "mixin" keyword
// Think of it as reusable functionality that can be "mixed in" to a class
mixin Printer {
  void printDocument() {
    print('Printing...');
  }
}

mixin Scanner {
  void scanDocument() {
    print('Scanning...');
  }
}

// Class AllInOne can "mix in" both Printer and Scanner
// This is similar to multiple inheritance, but safer in Dart
class AllInOne with Printer, Scanner {}

void main() {
  AllInOne device = AllInOne();

  // AllInOne now has methods from both Printer and Scanner
  device.printDocument(); // Output: Printing...
  device.scanDocument();  // Output: Scanning...
}
