import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemCount: favMovies.length,
              itemBuilder: (_, index) {
                return Dismissible(
                  background: Container(
                    color: Colors.red,
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
                  direction: DismissDirection.endToStart,
                  onDismissed: (direciton) {
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
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL,arguments: favMovies[index]);
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
            ),
          );
        },
      ),
    );
  }
}
