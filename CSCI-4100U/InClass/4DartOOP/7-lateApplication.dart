
class AppConfig {
  late String apiKey;
}

void main() {
  var config = AppConfig();
  // Suppose apiKey is loaded from a secure file
  config.apiKey = "XYZ-123";

  print(config.apiKey);
}
