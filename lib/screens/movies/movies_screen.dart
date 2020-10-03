import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/favorites/favorites_screen.dart';
import 'package:movies_app/screens/movies/widgets/grid_tile.dart';
import 'package:movies_app/screens/movies/widgets/search_appbar.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  // Widget iconFavorite = FlareActor(
  //   'assets/animations/AnimHeart.flr',
  //   animation: 'pulse',
  // );

  // Widget iconUnFavorite = Icon(Icons.favorite_border);

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
                        child: GridView.builder(
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
                                  movieProvider.fetchMovies(2);
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