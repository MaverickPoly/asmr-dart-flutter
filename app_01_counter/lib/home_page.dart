import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  const HomePage({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  void toggleTheme() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Counter App',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          Switch(
            value: widget.themeMode == ThemeMode.dark,
            onChanged: (val) => widget.onToggleTheme(),
          ),
        ],
      ),
      body: Expanded(
        child: Center(
          child: Text(
            count.toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 5,
        children: [
          FloatingActionButton(
            onPressed: decrement,
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: increment,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
