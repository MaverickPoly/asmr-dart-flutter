import 'dart:convert';

import 'package:app_06_json_placeholder/models/post.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  Future fetchPosts() async {
    final response = await http.get(
      Uri.parse("https://json-placeholder-olive.vercel.app/posts"),
    );
    if (response.statusCode != 200) {
      return;
    }

    var jsonData = jsonDecode(response.body);
    posts.clear();
    for (var element in jsonData) {
      final post = Post(
        id: element["id"],
        userId: element["userId"],
        title: element["title"],
        body: element["body"],
      );
      posts.add(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("JSON Placeholder")),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                      title: Text("${post.id}) ${post.title}"),
                      subtitle: Text(post.body),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
