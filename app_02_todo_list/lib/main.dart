import 'package:app_02_todo_list/db/todo_db.dart';
import 'package:app_02_todo_list/models/todo.dart';
import 'package:app_02_todo_list/pages/home_page.dart';
import 'package:app_02_todo_list/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // Setup
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Models
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>(TodoDB.boxName);

  // Run App
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            brightness: Brightness.dark,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
