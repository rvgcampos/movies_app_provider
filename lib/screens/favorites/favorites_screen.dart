import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesScreen extends StatelessWidget {
  Widget dismissibleBackground;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<MovieProvider>(
        builder: (_, moviesProvider, __) {
          final favMovies = moviesProvider.favoriteMovies;
          return Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.white, Colors.indigo],
              ),
            ),
            child: favMovies.isNotEmpty ? ListView.builder(
              itemCount: favMovies.length,
              itemBuilder: (_, index) {
                return Dismissible(
                  background: Container(
                    color: Colors.blue.withOpacity(0.8),
                    child: Align(
                      alignment: Alignment(-0.8, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            'Ir para o site',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red.withOpacity(0.8),
                    child: Align(
                      alignment: Alignment(0.8, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            'Excluir',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text('Deseja realmenter excluir?'),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    'Não',
                                    style: TextStyle(color: Colors.indigo, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    return false;
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    'Sim',
                                    style: TextStyle(color: Colors.indigo, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    moviesProvider.unFavoriteMovie(favMovies[index]);
                                    Navigator.of(context).pop();
                                    return true;
                                  },
                                )
                              ],
                            );
                          });
                    }
                    if (direction == DismissDirection.startToEnd) {
                      final url = 'https://www.themoviedb.org/movie/${favMovies[index].id}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                      return false;
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      print(favMovies[index]);
                      Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: favMovies[index]);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(
                          favMovies[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          favMovies[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                        leading: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: favMovies[index].imageUrl,
                          height: 300.0,
                          fit: BoxFit.cover,
                        ),
                        // trailing: IconButton(
                        //   onPressed: () {
                        //     moviesProvider.unFavoriteMovie(favMovies[index]);
                        //   },
                        //   icon: Icon(
                        //     Icons.delete,
                        //     color: Colors.red,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                );
              },
            ):
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Center(
                  child: Text(
                    'Muito vazio por aqui... Que tal adicionar uns filmes como favoritos?!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
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
