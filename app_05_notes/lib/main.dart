import 'package:app_05_notes/pages/home_page.dart';
import 'package:app_05_notes/providers/note_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      builder: (context, child) =>
          MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}
