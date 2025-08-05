import 'package:app_05_notes/pages/create_page.dart';
import 'package:app_05_notes/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void navigate(Widget page) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    }

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.note_alt, size: 40)),

          SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("H O M E"),
            onTap: () => navigate(HomePage()),
          ),
          ListTile(
            leading: Icon(Icons.create),
            title: Text("C R E A T E"),
            onTap: () => navigate(CreatePage()),
          ),
        ],
      ),
    );
  }
}
