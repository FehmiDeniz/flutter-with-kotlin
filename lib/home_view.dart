import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color backgroundColor = Colors.white;
  static const platform = MethodChannel('fdb-example');
  Future<void> _generateRandomColor() async {
    int randomColor;
    randomColor = await platform.invokeMethod('getRandomColor');
    setState(() {
      backgroundColor = Color(randomColor);
    });
  }

  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await platform.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      random = 0;
    }
    setState(() {
      _counter = random;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kotlin generates the following number:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _generateRandomNumber,
            tooltip: 'Generate',
            child: const Icon(Icons.refresh),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: _generateRandomColor,
            tooltip: 'Generate',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
