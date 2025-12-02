import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Widgets Demo',
      theme: ThemeData(useMaterial3: true), // Needed for SearchBar/SearchAnchor
      home: const InputDemos(),
    );
  }
}

class InputDemos extends StatefulWidget {
  const InputDemos({super.key});
  @override
  State<InputDemos> createState() => _InputDemosState();
}

class _InputDemosState extends State<InputDemos> {
  // ---------- TextField ----------
  final _tfController = TextEditingController();
  String _tfValue = '';

  // ---------- TextFormField ----------
  final _formKey = GlobalKey<FormState>();
  final _tffController = TextEditingController();
  String _tffValue = '';

  // ---------- DropdownButtonFormField ----------
  final List<String> _genders = const ['Male', 'Female', 'Other'];
  String? _selectedGender;

  // ---------- Slider ----------
  double _age = 30;

  // ---------- RangeSlider ----------
  RangeValues _priceRange = const RangeValues(20, 80);

  // ---------- CheckboxListTile ----------
  bool _acceptedTerms = false;

  // ---------- RadioListTile ----------
  String _shipping = 'Standard';

  // ---------- Switch ----------
  bool _notifications = true;

  // ---------- DatePicker ----------
  DateTime? _pickedDate;

  // ---------- TimePicker ----------
  TimeOfDay? _pickedTime;

  // ---------- Autocomplete ----------
  final List<String> _fruits = const [
    'Apple', 'Apricot', 'Avocado', 'Banana', 'Blackberry', 'Blueberry',
    'Cherry', 'Grape', 'Grapefruit', 'Kiwi', 'Lemon', 'Lime',
    'Mango', 'Orange', 'Peach', 'Pear', 'Pineapple', 'Plum', 'Strawberry'
  ];
  String _selectedFruit = '';

  // ---------- SearchBar / SearchAnchor (Material 3) ----------
  final List<String> _cities = const [
    'Toronto', 'Montreal', 'Vancouver', 'Calgary', 'Ottawa',
    'Edmonton', 'Quebec City', 'Winnipeg', 'Hamilton', 'Kitchener'
  ];
  String _searchResult = '';

  @override
  void dispose() {
    _tfController.dispose();
    _tffController.dispose();
    super.dispose();
    // (No controller needed for SearchBar/SearchAnchor demo)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Widgets Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---------------- TEXTFIELD ----------------
          _section(
            title: 'TextField (no Form/validation)',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _tfController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => _tfValue = v),
                ),
                const SizedBox(height: 8),
                Text('Value: $_tfValue'),
              ],
            ),
          ),

          // ---------------- TEXTFORMFIELD ----------------
          _section(
            title: 'TextFormField (with Form + validation)',
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _tffController,
                    decoration: const InputDecoration(
                      labelText: 'Username (min 3 chars)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Required';
                      if (v.length < 3) return 'Too short';
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _tffValue = _tffController.text);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(width: 12),
                      Text('Submitted: $_tffValue'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ---------------- DROPDOWNBUTTONFORMFIELD ----------------
          _section(
            title: 'DropdownButtonFormField',
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Select Gender',
                border: OutlineInputBorder(),
              ),
              items: _genders.map((g) => DropdownMenuItem<String>(
                value: g,
                child: Text(g),
              )).toList(),
              onChanged: (v) => setState(() => _selectedGender = v),
            ),
          ),

          // ---------------- SLIDER ----------------
          _section(
            title: 'Slider',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: _age,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: _age.round().toString(),
                  onChanged: (v) => setState(() => _age = v),
                ),
                Text('Age: ${_age.round()}'),
              ],
            ),
          ),

          // ---------------- RANGESLIDER ----------------
          _section(
            title: 'RangeSlider',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 100,
                  divisions: 20,
                  labels: RangeLabels(
                    _priceRange.start.round().toString(),
                    _priceRange.end.round().toString(),
                  ),
                  onChanged: (v) => setState(() => _priceRange = v),
                ),
                Text('Price Range: ${_priceRange.start.round()} - ${_priceRange.end.round()}'),
              ],
            ),
          ),

          // ---------------- CHECKBOXLISTTILE ----------------
          _section(
            title: 'CheckboxListTile',
            child: CheckboxListTile(
              title: const Text('Accept Terms'),
              value: _acceptedTerms,
              onChanged: (v) => setState(() => _acceptedTerms = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),

          // ---------------- RADIOLISTTILE ----------------
          _section(
            title: 'RadioListTile (mutually exclusive)',
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Standard'),
                  value: 'Standard',
                  groupValue: _shipping,
                  onChanged: (v) => setState(() => _shipping = v!),
                ),
                RadioListTile<String>(
                  title: const Text('Express'),
                  value: 'Express',
                  groupValue: _shipping,
                  onChanged: (v) => setState(() => _shipping = v!),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Selected: $_shipping'),
                ),
              ],
            ),
          ),

          // ---------------- SWITCH ----------------
          _section(
            title: 'Switch',
            child: SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _notifications,
              onChanged: (v) => setState(() => _notifications = v),
            ),
          ),

          // ---------------- DATE PICKER ----------------
          _section(
            title: 'Date Picker (showDatePicker)',
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: now,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => _pickedDate = picked);
                    }
                  },
                  child: const Text('Pick Date'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _pickedDate == null
                        ? 'No date selected'
                        : 'Selected: ${_pickedDate!.year}-${_pickedDate!.month.toString().padLeft(2, '0')}-${_pickedDate!.day.toString().padLeft(2, '0')}',
                  ),
                ),
              ],
            ),
          ),

          // ---------------- TIME PICKER ----------------
          _section(
            title: 'Time Picker (showTimePicker)',
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() => _pickedTime = picked);
                    }
                  },
                  child: const Text('Pick Time'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _pickedTime == null
                        ? 'No time selected'
                        : 'Selected: ${_pickedTime!.format(context)}',
                  ),
                ),
              ],
            ),
          ),

          // ---------------- AUTOCOMPLETE ----------------
          _section(
            title: 'Autocomplete',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue tev) {
                    if (tev.text.isEmpty) return const Iterable<String>.empty();
                    final q = tev.text.toLowerCase();
                    return _fruits.where((f) => f.toLowerCase().contains(q));
                  },
                  onSelected: (value) => setState(() => _selectedFruit = value),
                  fieldViewBuilder:
                      (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Type a fruit',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text('Selected: $_selectedFruit'),
              ],
            ),
          ),

          // ---------------- SEARCHBAR / SEARCHANCHOR (M3) ----------------
          _section(
            title: 'SearchBar / SearchAnchor (Material 3)',
            child: SearchAnchor.bar(
              barHintText: 'Search city...',
              suggestionsBuilder: (context, controller) {
                final query = controller.text.toLowerCase();
                final results = _cities.where(
                      (c) => c.toLowerCase().contains(query),
                );
                return results.map((c) {
                  return ListTile(
                    title: Text(c),
                    onTap: () {
                      controller.closeView(c);
                      setState(() => _searchResult = c);
                    },
                  );
                });
              },
              onSubmitted: (value) {
                setState(() => _searchResult = value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Search result: $_searchResult'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
