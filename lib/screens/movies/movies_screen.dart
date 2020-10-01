import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/favorites/favorites_screen.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (_, movieProvider, __) {
        final popMovies = movieProvider.popularMovies;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image.asset(
              "assets/images/tmdb.jpg",
              fit: BoxFit.cover,
            ),
            centerTitle: true,
          ),
          body: movieProvider.selectedIndex == 0
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Pesquisa",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (text) {
                          movieProvider.search(text);
                        },
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(10.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: popMovies.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: popMovies[index]);
                                },
                                onLongPress: () {
                                  Share.share(popMovies[index].imageUrl);
                                },
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: popMovies[index].imageUrl,
                                  height: 300.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.black87,
                                leading: IconButton(
                                  icon: Icon(popMovies[index].isFavorite ? Icons.favorite : Icons.favorite_border),
                                  onPressed: () {
                                    if (popMovies[index].isFavorite == true) {
                                      movieProvider.unFavoriteMovie(popMovies[index]);
                                    } else {
                                      movieProvider.favoriteMovie(popMovies[index]);
                                    }
                                  },
                                ),
                                title: Text(
                                  popMovies[index].title,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : FavoritesScreen(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: movieProvider.selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              movieProvider.changePage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                title: Text('Filmes'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter),
                title: Text('Favoritos'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// FadeInImage.memoryNetwork(
//                         placeholder: kTransparentImage,
//                         image: movieProvider.popularMovies[index].imageUrl,
//                         height: 300.0,
//                         fit: BoxFit.cover,
//                       )
