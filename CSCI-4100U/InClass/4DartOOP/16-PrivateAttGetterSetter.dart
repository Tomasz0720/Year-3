
class Phone {
  String _manufacturer;
  String _model;

  Phone(this._manufacturer, this._model); // Constructor

  @override
  String toString() => '$_manufacturer $_model'; // Lambda for toString

  // Getter for model
  String get model => _model;

  // Setter for model with validation
  set model(String newModel) {
    if (newModel.isEmpty) {
      throw ArgumentError('Model name cannot be empty');
    }
    _model = newModel;
  }
}

void main() {
  var phone = Phone('Samsung', 'Galaxy S24');
  print(phone); // Samsung Galaxy S24

  // Update model using setter
  phone.model = 'Galaxy S25';
  print(phone); // Samsung Galaxy S25

  // ❌ phone.model = ''; // Will throw error
}
