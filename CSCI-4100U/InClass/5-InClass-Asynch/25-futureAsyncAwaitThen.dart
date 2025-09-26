
import 'dart:io';

// Function returns a Future<String>
Future<String> readFromFile(String filename) async {
  final file = File(filename);

  // Simulate asynchronous file read
  String data = await file.readAsString();

  return data; // Return file contents
}

void main() {
  print('Reading file...');

  // Call the function: this immediately returns a Future<String>
  Future<String> result = readFromFile('example.txt');

  // Use "then()" to provide a callback
  // When the Future completes, the callback is executed
  result.then((data) {
    print('File contents: $data');
  });

  print('Program continues immediately...'); 
  // This line runs BEFORE the file is finished reading
}
