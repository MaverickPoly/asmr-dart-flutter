import 'dart:convert';

import 'package:app_08_news/models/new.dart';
import "package:http/http.dart" as http;

class NewsService {
  String apiKey = "1b1ae630e92248b2bd89e3661a0bf843";

  Future<List<New>> fetchNews() async {
    var response = await http.get(
      Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey",
      ),
    );
    if (response.statusCode != 200) {
      throw Exception("Error fetching articles...");
    }

    var jsonData = jsonDecode(response.body);
    var articlesJson = jsonData["articles"];
    List<New> articles = [];

    for (var element in articlesJson) {
      print(element);
      New newItem = New(
        title: element["title"],
        description: element["description"],
        url: element["url"],
        urlToImage: element["urlToImage"],
        publishedAt: element["publishedAt"],
      );
      articles.add(newItem);
    }
    return articles;
  }
}
