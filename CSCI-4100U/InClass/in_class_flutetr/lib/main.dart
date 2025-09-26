import 'package:flutter/material.dart';

//The starting point of every Dart program.
void main() {
  //Tells Flutter to run the app and attach it to the screen, starting with the MyApp widget.
  runApp(const MyApp());
}

//this is my application (as a widget)
//this is how we create our costume Widget
//in this case our application (A widget - widget tree?)
//Why stateless?
class MyApp extends StatelessWidget {

  //Every widget in Flutter has a Key parameter.
  //Identify widgets uniquely in the widget tree
  // Optimize rebuilding when UI updates.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // BuildContext - Knows where this widget sits in the widget tree.

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      //The home property defines the default screen (or route) that appears when the app launches.
      // Whatever widget you put here is shown as the first page of the app.
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  //what is the following line of code:
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    //It gives you a ready-made app page with slots for the most common visual elements:
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), //this can be image, icon or multiline text
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          //next line?
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
              // style: Theme.of(context).textTheme.displayLarge,
              // style: Theme.of(context).textTheme.displayMedium,
              // style: Theme.of(context).textTheme.displaySmall,
              // style: Theme.of(context).textTheme.labelLarge,
              // style: Theme.of(context).textTheme.labelMedium,
              // style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( //IconButton, ElevatedButton, Container
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
