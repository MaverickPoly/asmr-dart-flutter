import 'package:app_08_news/components/new_card.dart';
import 'package:app_08_news/models/new.dart';
import 'package:app_08_news/services/news_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _newsService = NewsService();
  late Future<List<New>> future;

  @override
  void initState() {
    super.initState();
    future = _newsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Latest News"), centerTitle: true),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error.toString()}",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No data available!",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final newItem = data[index];
                return NewCard(newItem: newItem);
              },
            );
          },
        ),
      ),
    );
  }
}
