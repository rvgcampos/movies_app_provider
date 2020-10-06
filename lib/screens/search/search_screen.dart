import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/search/widgets/search_bar.dart';
import 'package:movies_app/screens/search/widgets/search_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String search = ModalRoute.of(context).settings.arguments;
    searchController.text = search;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Resultado da Busca'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<MovieProvider>(
        builder: (_, movieProvider, __) {
          final List<Movie> searchMovies = movieProvider.searchPopularMovies;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Colors.indigo],
              ),
            ),
            child: Column(
              children: [
                SearchBar(movieProvider, searchController),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: searchMovies.length,
                        itemBuilder: (_, index) {
                          final popMovie = searchMovies[index];
                          return SearchCard(popMovie);
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
