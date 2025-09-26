late String bigData; 

String loadHeavyData() {
  print("Loading...");
  return "Huge dataset";
}

void main() {
  bigData = loadHeavyData(); 
  print("Program started");
  print(bigData); // loadHeavyData() runs here, not earlier
}
