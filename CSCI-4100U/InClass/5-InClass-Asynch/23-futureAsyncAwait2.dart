
import 'dart:io';

// Function returns a Future<String>
// Meaning: at some point in the future, it will return a String
Future<String> readFromFile(String filename) async {
  // Create a File object
  final file = File(filename);

  // "await" pauses execution until the file contents are read
  // The program is not blocked, but this function waits
  String data = await file.readAsString(); // ⏳ async read

  return data; // Return the file contents as a String
}

void main() async {
  print('Reading file...');

  // "await" tells Dart to wait until readFromFile finishes
  String contents = await readFromFile('example.txt');

  print('File contents: $contents');
}
