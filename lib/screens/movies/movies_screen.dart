import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/favorites/favorites_screen.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  // Widget icon = Icon(Icons.favorite_border);

  Widget iconFavorite = FlareActor(
    'assets/animations/AnimHeart.flr',
    animation: 'pulse',
  );
  Widget iconUnFavorite = Icon(Icons.favorite_border);
  FlareController flareController;

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
              movieProvider.selectedIndex == 0 ? 'Filmes Populares' : 'Favoritos',
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
          ),
          body: movieProvider.selectedIndex == 0
              ? Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: size.height * 0.2,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 56,
                            ),
                            height: size.height * 0.2 - 20,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(36),
                                bottomRight: Radius.circular(36),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    'Bem-vindo ao APP!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 20),
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
                                        movieProvider.search(text);
                                        Navigator.of(context).pushNamed(AppRoutes.SEARCH_SCREEN, arguments: text);
                                        searchController.text = '';
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
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      movieProvider.search(searchController.text);
                                      Navigator.of(context).pushNamed(AppRoutes.SEARCH_SCREEN, arguments: searchController.text);
                                      searchController.text = '';
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(10.0),
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       labelText: "Pesquisa",
                    //       labelStyle: TextStyle(color: Colors.black),
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18.0,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //     onChanged: (text) {
                    //       movieProvider.search(text);
                    //     },
                    //   ),
                    // ),
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
                                child: GridTile(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: popMovies[index]);
                                    },
                                    onLongPress: () {
                                      Share.share(popMovies[index].imageUrl);
                                    },
                                    child: Opacity(
                                      opacity: 0.9,
                                      child: Hero(
                                        tag: popMovies[index].id,
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: popMovies[index].imageUrl,
                                          height: 300.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  header: GridTileBar(
                                    backgroundColor: Colors.black87,
                                    title: Text(
                                      popMovies[index].title,
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8),
                                            child: Text(
                                              popMovies[index].voteAverage.toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  footer: GridTileBar(
                                    leading: IconButton(
                                      // iconSize: ,
                                      icon: popMovies[index].isFavorite ? iconFavorite : iconUnFavorite,
                                      onPressed: () {
                                        if (popMovies[index].isFavorite == true) {
                                          movieProvider.unFavoriteMovie(popMovies[index]);
                                          // icon = Icon(Icons.favorite_border);
                                        } else {
                                          movieProvider.favoriteMovie(popMovies[index]);
                                          // icon = FlareActor(
                                          //   'assets/animations/AnimHeart.flr',
                                          //   animation: 'pulse',
                                          //   controller: flareController,
                                          // );
                                        }
                                      },
                                    ),
                                  ),
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

// FadeInImage.memoryNetwork(
//                         placeholder: kTransparentImage,
//                         image: movieProvider.popularMovies[index].imageUrl,
//                         height: 300.0,
//                         fit: BoxFit.cover,
//                       )
