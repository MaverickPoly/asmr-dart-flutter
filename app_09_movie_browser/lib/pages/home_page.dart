import 'package:app_09_movie_browser/components/movie_card.dart';
import 'package:app_09_movie_browser/models/movie.dart';
import 'package:app_09_movie_browser/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  int selectedYear = 2009;
  late Future<List<Movie>> future;
  MovieService movieService = MovieService();

  @override
  void initState() {
    super.initState();
    future = movieService.fetchMovies("Spider Man");
  }

  void handleSearch() {
    if (searchController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter a search term")));
      return;
    }
    if (selectedYear == 0) {
      setState(() {
        future = movieService.fetchMovies(searchController.text);
      });
    } else {
      setState(() {
        future = movieService.fetchMovies(
          searchController.text,
          year: selectedYear,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text("OMDB Movies"),
          centerTitle: true,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_today_outlined),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hint: Text(
                    "Search...",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 17),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.grey.shade600,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      value: selectedYear,
                      items: [
                        DropdownMenuItem(value: 0, child: Text("-")),
                        for (var i = 2025; i >= 1990; i--)
                          DropdownMenuItem(value: i, child: Text(i.toString())),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value ?? 2025;
                        });
                      },
                    ),

                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 0.6,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list_alt),
                          SizedBox(width: 4),
                          Text("Filter", style: TextStyle(fontSize: 17)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "No movies found",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    final data = snapshot.data!;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 5,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final movie = data[index];
                        return MovieCard(movie: movie);
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: handleSearch,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
