
class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  // Shorter syntax using "arrow function" for one-line methods
  double area() => width * height;
  double perimeter() => 2 * (width + height);
}

void main() {
  // Create two rectangles with different dimensions
  var r1 = Rectangle(2.0, 4.0);
  var r2 = Rectangle(10.0, 5.0);

  // Each object calculates its own values
  print('Rectangle 1 -> Area: ${r1.area()}, Perimeter: ${r1.perimeter()}');
  print('Rectangle 2 -> Area: ${r2.area()}, Perimeter: ${r2.perimeter()}');
}
