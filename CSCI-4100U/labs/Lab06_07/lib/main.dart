import 'package:flutter/material.dart';
import 'grade.dart';
import 'grades_model.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:io';
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grades App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: ListGrades(onToggleTheme: _toggleTheme),
    );
  }
}

class ListGrades extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const ListGrades({super.key, required this.onToggleTheme});

  @override
  State<ListGrades> createState() => _ListGradesState();
}

class _ListGradesState extends State<ListGrades> {
  final GradesModel _gradesModel = GradesModel();
  List<Grade> grades = [];
  int? _selectedIndex;
  String _sortBy = 'sid_asc';

  void _exportCSV() async {
    try {
      String csv = 'sid,grade\n';
      for (var grade in grades) {
        csv += '${grade.sid},${grade.grade}\n';
      }

      String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save CSV File',
        fileName: 'grades_export.csv',
        bytes: Uint8List.fromList(csv.codeUnits),
      );

      if (outputPath != null) {
        print('Exported ${grades.length} grades to CSV');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exported ${grades.length} grades successfully!')),
        );
      }
    } catch (e) {
      print('Error exporting CSV: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error exporting CSV: $e')),
      );
    }
  }

  void _importCSV() async{
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if(result != null){
        File file = File(result.files.single.path!);
        String contents = await file.readAsString();
        List<String> lines = contents.split('\n');
        int imported = 0;

        for(int i = 1; i < lines.length; i++){
          String line = lines[i].trim();
          if(line.isEmpty) continue;

          List<String> parts = line.split(',');
          if(parts.length >= 2){
            String sid = parts[0].trim();
            String grade = parts[1].trim();

            Grade newGrade = Grade(sid: sid, grade: grade);
            await _gradesModel.insertGrade(newGrade);
            imported++;
          }
        }

        _loadGrades();
        print('$imported grades imported from CSV');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$imported grades imported from CSV')),
        );
      }
    } catch (e){
      print('Error importing CSV: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing CSV: $e')),
      );
    }
  }

  void _sortGrades(){
    setState((){
      if(_sortBy == 'sid_asc'){
        grades.sort((a, b) => a.sid.compareTo(b.sid));
      } else if(_sortBy == 'sid_desc'){
        grades.sort((a, b) => b.sid.compareTo(a.sid));
      } else if(_sortBy == 'grade_asc'){
        grades.sort((a, b) => a.grade.compareTo(b.grade));
      } else if(_sortBy == 'grade_desc'){
        grades.sort((a, b) => b.grade.compareTo(a.grade));
      }
    });
  }

  void _showSortMenu(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 80, 0, 0),
      items: [
        PopupMenuItem(
          value: 'sid_asc',
          child: Row(
            children: [
              Icon(_sortBy == 'sid_asc' ? Icons.check : Icons.arrow_upward),
              SizedBox(width: 8),
              Text('Student ID (Ascending)'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'sid_desc',
          child: Row(
            children: [
              Icon(_sortBy == 'sid_desc' ? Icons.check : Icons.arrow_downward),
              SizedBox(width: 8),
              Text('Student ID (Descending)'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'grade_asc',
          child: Row(
            children: [
              Icon(_sortBy == 'grade_asc' ? Icons.check : Icons.arrow_upward),
              SizedBox(width: 8),
              Text('Grade (Ascending)'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'grade_desc',
          child: Row(
            children: [
              Icon(_sortBy == 'grade_desc' ? Icons.check : Icons.arrow_downward),
              SizedBox(width: 8),
              Text('Grade (Descending)'),
            ],
          ),
        ),
      ],
    );

    if (result != null) {
      setState(() {
        _sortBy = result;
      });
      _sortGrades();
    }
  }

  void _showEditMenu(BuildContext context, int index) async{
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8),
              Text('Edit Grade'),
            ],
          ),
        ),
      ],
    );

    if (result == 'edit') {
      Grade selectedGrade = grades[index];

      final Grade? editResult = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GradeForm(grade: selectedGrade),
        ),
      );

      if (editResult != null) {
        await _gradesModel.updateGrade(editResult);
        _loadGrades();
        print('Grade updated: ${editResult.sid} - ${editResult.grade}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadGrades();  // ← Load grades when page opens
  }

  Future<void> _loadGrades() async {
    List<Grade> loadedGrades = await _gradesModel.getAllGrades();
    setState(() {
      grades = loadedGrades;
    });
    _sortGrades();
  }

  void _addGrade() async {
    print('Add grade button pressed');

    final Grade? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GradeForm()),
    );

    if (result != null) {
      await _gradesModel.insertGrade(result);
      _loadGrades();
      print('Grade added: ${result.sid} - ${result.grade}');
    }
  }

  void _editGrade() async {
    if (_selectedIndex == null) {
      print('No grade selected');
      return;
    }

    print('Edit grade button pressed');
    Grade selectedGrade = grades[_selectedIndex!];

    final Grade? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GradeForm(grade: selectedGrade),
      ),
    );

    if (result != null) {
      await _gradesModel.updateGrade(result);
      _loadGrades();
      print('Grade updated: ${result.sid} - ${result.grade}');
    }
  }

  void _deleteGrade() async {
    if (_selectedIndex == null) {
      print('No grade selected');
      return;
    }

    print('Delete grade button pressed');
    Grade selectedGrade = grades[_selectedIndex!];

    await _gradesModel.deleteGrade(selectedGrade.id!);

    setState(() {
      _selectedIndex = null;
    });
    _loadGrades();

    print('Grade deleted: ${selectedGrade.sid}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grades'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
          IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () => _showSortMenu(context),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GradeChartPage(grades: grades),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: _importCSV,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportCSV,
            tooltip: 'Export CSV',
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: grades.length,

        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(grades[index].id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) async{
              Grade deletedGrade = grades[index];
              await _gradesModel.deleteGrade(deletedGrade.id!);
              _loadGrades();
              print('Grade deleted via swipe: ${deletedGrade.sid}');
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                print('Selected index: $_selectedIndex');
              },
              onLongPress: (){
                _showEditMenu(context, index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == index ? Colors.blueGrey[100] : null,
                ),
                child: ListTile(
                  title: Text(grades[index].sid),
                  subtitle: Text('Grade: ${grades[index].grade}'),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGrade,
        child: const Icon(Icons.add),
      ),
    );
  }
}


class GradeForm extends StatefulWidget {
  final Grade? grade;

  const GradeForm({super.key, this.grade});

  @override
  State<GradeForm> createState() => _GradeFormState();
}

class _GradeFormState extends State<GradeForm> {
  final TextEditingController _sidController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(widget.grade != null) {
      _sidController.text = widget.grade!.sid;
      _gradeController.text = widget.grade!.grade;
    }
  }

  @override
  void dispose(){
    _sidController.dispose();
    _gradeController.dispose();
    super.dispose();
  }

  void _saveGrade() {
    String sid = _sidController.text;
    String gradeValue = _gradeController.text;

    if (sid.isEmpty || gradeValue.isEmpty) {
      print('Please fill in all fields');
      return;
    }

    Grade grade = Grade(
      id: widget.grade?.id,
      sid: sid,
      grade: gradeValue,
    );

    Navigator.pop(context, grade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grade == null ? 'Add Grade' : 'Edit Grade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sidController,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _gradeController,
              decoration: const InputDecoration(
                labelText: 'Grade',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveGrade,
        child: const Icon(Icons.save),
      ),
    );
  }
}

class GradeChartPage extends StatelessWidget{
  final List<Grade> grades;
  const GradeChartPage({super.key, required this.grades});

  @override
  Widget build(BuildContext context){
    Map<String, int> gradeFrequency = {};
    for(var grade in grades){
      gradeFrequency[grade.grade] = (gradeFrequency[grade.grade] ?? 0) + 1;
    }

    List<String> sortedGrades = gradeFrequency.keys.toList()..sort();
    int maxFrequency = gradeFrequency.values.isEmpty ? 1 : gradeFrequency.values.reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Distribution Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Grade Frequency Chart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: sortedGrades.map((grade) {
                  int frequency = gradeFrequency[grade]!;
                  double barHeight = (frequency / maxFrequency) * 200;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '$frequency',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 40,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        grade,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('X-axis: Grade'),
            const Text('Y-axis: Frequency'),
          ],
        ),
      ),
    );
  }
}