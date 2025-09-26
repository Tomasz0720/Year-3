// If your program does asynchronous work (e.g., file I/O, network calls),
// you can mark main as 'async' and return a Future<void>.
Future<void> main() async {
  // Simulate a delay, like waiting for data to load
  await Future.delayed(Duration(seconds: 1));

  // This will print after 1 second
  print("Hello after 1 second");
}