
// Example showing how to use .then() with Futures in Dart

// A function that simulates reading data from a file asynchronously
Future<String> readFromFile(String filename) async {
  // Simulate a delay of 2 seconds (e.g., file I/O takes time)
  await Future.delayed(Duration(seconds: 2)); 
  // Return a fake file content
  return 'File content of $filename';
}

void main() {
  print('Starting file read...');

  // Call the async function but use .then() instead of await
  // .then() executes the callback when the Future completes
  readFromFile('data.txt').then((content) {
    // This runs after 2 seconds when the Future finishes
    print('Read complete: $content');
  });

  // This runs immediately (non-blocking, async continues in background)
  print('Still running other code...');
}

/*
Expected Output:
Starting file read...
Still running other code...
(wait 2 seconds...)
Read complete: File content of data.txt
*/
