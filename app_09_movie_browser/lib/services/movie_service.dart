import 'dart:convert';

import 'package:app_09_movie_browser/models/movie.dart';
import "package:http/http.dart" as http;

class MovieService {
  static final MovieService _instance = MovieService._internal();

  factory MovieService() => _instance;

  MovieService._internal();

  final String apiKey = "omdbapi api key";

  Future<List<Movie>> fetchMovies(String query, {int? year}) async {
    var response = await http.get(
      Uri.parse("http://www.omdbapi.com/?apikey=$apiKey&s=$query&y=$year"),
    );
    var jsonData = jsonDecode(response.body);

    List<Movie> movies = [];
    for (var json in jsonData["Search"]) {
      final movie = Movie(
        title: json["Title"],
        year: json["Year"],
        imdbID: json["imdbID"],
        type: json["Type"],
        poster: json["Poster"],
      );
      movies.add(movie);
    }
    return movies;
  }
}
