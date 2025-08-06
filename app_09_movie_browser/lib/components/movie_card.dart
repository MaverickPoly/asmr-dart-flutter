import 'package:app_09_movie_browser/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    print(movie.title);
    final encodedUrl = Uri.parse(movie.poster)
        .replace(pathSegments: Uri.parse(movie.poster)
        .pathSegments.map((s) => Uri.encodeComponent(s)).toList())
        .toString();
    print(encodedUrl);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: movie.poster,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    SizedBox(width: 5),
                    Text(movie.year, style: TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.movie),
                    SizedBox(width: 5),
                    Text(movie.type.replaceFirst(movie.type[0], movie.type[0].toUpperCase()), style: TextStyle(fontSize: 15),),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
