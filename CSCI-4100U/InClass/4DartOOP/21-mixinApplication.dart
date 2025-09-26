// Reusable functionality (capabilities)
mixin Wifi {
  void connectWifi() => print('Connected to WiFi');
}

mixin Bluetooth {
  void connectBluetooth() => print('Connected to Bluetooth');
}

// Phone class gets WiFi functionality
class Phone with Wifi {}

// Laptop class gets both WiFi + Bluetooth functionality
class Laptop with Wifi, Bluetooth {}

void main() {
  Phone phone = Phone();
  Laptop laptop = Laptop();

  // Phone only has WiFi
  phone.connectWifi();          // Connected to WiFi

  // Laptop has both WiFi and Bluetooth
  laptop.connectWifi();         // Connected to WiFi
  laptop.connectBluetooth();    // Connected to Bluetooth
}
