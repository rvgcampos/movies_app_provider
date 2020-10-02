import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String search = ModalRoute.of(context).settings.arguments;
    searchController.text = search;
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Resultado da Busca'),
      ),
      body: Consumer<MovieProvider>(
        builder: (_, movieProvider, __) {
          final List<Movie> searchMovies = movieProvider.searchPopularMovies;

          return Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.blue.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (text) {
                          movieProvider.search(searchController.text);
                        },
                        decoration: InputDecoration(
                          hintText: "Pesquisar...",
                          hintStyle: TextStyle(
                            color: Colors.blue,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      splashRadius: 1,
                      onPressed: () {
                        movieProvider.search(searchController.text);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: searchMovies.length,
                      itemBuilder: (_, index) {
                        final popMovie = searchMovies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: popMovie);
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              leading: Image.network(popMovie.imageUrl),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    popMovie.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(popMovie.releaseDate)
                                ],
                              ),
                              subtitle: Text(
                                popMovie.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
