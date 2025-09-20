import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Image App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.dark),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Counter Image App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  bool _isFirstImage = true;
  bool _isDarkMode = false;
  
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    // Start continuous animation
    _startContinuousAnimation();
  }

  void _startContinuousAnimation() {
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Image App',
      theme: _isDarkMode 
        ? ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue, brightness: Brightness.dark),
            brightness: Brightness.dark,
            useMaterial3: true,
          )
        : ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            brightness: Brightness.light,
            useMaterial3: true,
          ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    // First image
                    FadeTransition(
                      opacity: _isFirstImage ? _curvedAnimation : AlwaysStoppedAnimation(0.0),
                      child: Image.asset(
                        'assets/georgia_state_panthers.webp',
                        height: 120,
                        width: 120,
                      ),
                    ),
                    // Second image
                    FadeTransition(
                      opacity: !_isFirstImage ? _curvedAnimation : AlwaysStoppedAnimation(0.0),
                      child: Image.asset(
                        'assets/GSU-Pantherhead.png',
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _toggleTheme,
                child: Text(_isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
