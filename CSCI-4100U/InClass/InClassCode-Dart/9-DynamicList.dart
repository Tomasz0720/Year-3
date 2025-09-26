void main() {
  // -----------------------------------
  // 1. Dynamic list with mixed types
  // -----------------------------------
  List<dynamic> stuff = [42, 'hello', true, 3.14];
  print("Initial stuff: $stuff");
  // Output: [42, hello, true, 3.14]

  // -----------------------------------
  // 2. Access elements by index
  // -----------------------------------
  print(stuff[1]);  // Output: hello (index 1)

  // -----------------------------------
  // 3. Add new elements of any type
  // -----------------------------------
  stuff.add("new item");   // Adding a String
  stuff.add(false);        // Adding a Boolean
  print("After adding: $stuff");

  // -----------------------------------
  // 4. Modify elements
  // -----------------------------------
  stuff[0] = 100;          // Change 42 → 100
  stuff[2] = "Dart";       // Change true → String
  print("After modify: $stuff");

  // -----------------------------------
  // 5. Remove elements
  // -----------------------------------
  stuff.removeAt(3);       // Removes element at index 3 (3.14)
  print("After removeAt: $stuff");

  // -----------------------------------
  // 6. Iterate over dynamic list
  // -----------------------------------
  for (var item in stuff) {
    print("Item: $item");
  }

  // -----------------------------------
  // 7. Short Version
  // -----------------------------------
    var shortVersionArray = [1, 'hi', false, 5.5];  // Dart infers List<dynamic>
}
