import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: Consumer<MovieProvider>(
        builder: (_, moviesProvider, __) {
          final favMovies = moviesProvider.favoriteMovies;
          return ListView.builder(
            itemCount: favMovies.length,
            itemBuilder: (_, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    favMovies[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    favMovies[index].description,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle2.color,
                    ),
                  ),
                  leading: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: favMovies[index].imageUrl,
                    height: 300.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
