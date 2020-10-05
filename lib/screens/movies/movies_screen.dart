import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/favorites/favorites_screen.dart';
import 'package:movies_app/screens/movies/widgets/grid_tile.dart';
import 'package:movies_app/screens/movies/widgets/search_appbar.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  int pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MovieProvider>(
      builder: (_, movieProvider, __) {
        final popMovies = movieProvider.popularMovies;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            elevation: 0,
            title: Text(
              movieProvider.selectedIndex == 0 ? 'POP Movies' : 'Favoritos',
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: movieProvider.selectedIndex == 0
              ? Column(
                  children: <Widget>[
                    SearchAppBar(
                      movieProvider: movieProvider,
                      size: size,
                      searchController: searchController,
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        color: Colors.indigo,
                        onRefresh: () async {
                          await movieProvider.fetchMovies();
                          return null;
                        },
                        child: popMovies.isEmpty
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Conexão com a internet indisponível',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                              ],
                            )
                            : GridView.builder(
                                padding: EdgeInsets.all(10.0),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: popMovies.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < popMovies.length)
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: MovieGridTile(
                                        index: index,
                                        movieProvider: movieProvider,
                                        popMovies: popMovies,
                                      ),
                                    );
                                  else
                                    return GestureDetector(
                                      onTap: () {
                                        movieProvider.fetchMovies(pageIndex);
                                        pageIndex++;
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GridTile(
                                          child: Container(
                                            color: Colors.black.withOpacity(0.4),
                                            child: Center(
                                              child: Text(
                                                'Carregar Mais',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                },
                              ),
                      ),
                    ),
                  ],
                )
              : FavoritesScreen(),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: movieProvider.selectedIndex,
            selectedItemColor: Colors.indigo,
            onTap: (index) {
              movieProvider.changePage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                title: Text('Filmes'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.stars),
                title: Text('Favoritos'),
              ),
            ],
          ),
        );
      },
    );
  }
}
