import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/models/Movie.dart';

class FavoriteProvider extends ChangeNotifier {
  final moviesBox = GetStorage();

  Future<void> saveFavorite(Movie movie) async {
    final Map<String, dynamic> movieMap = {
      'title': movie.title,
      'id': movie.id,
      'description': movie.description,
      'releaseDate': movie.releaseDate,
      'imageUrl': movie.imageUrl,
      'isFavorite': movie.isFavorite,
      'originalLanguage': movie.originalLanguage,
    };

    await moviesBox.write(movie.id.toString(), movieMap);
    notifyListeners();
  }

  Future<void> removeFavorite(Movie movie) async {
    await moviesBox.remove(movie.id.toString());
    notifyListeners();
  }

  Future<List<Movie>> readFavorites() async{
    List<Movie> favoritesMovies = [];
    final moviesBoxValues = await moviesBox.getValues();
    for (final movieMap in moviesBoxValues) {
      final Movie movie = Movie(
        title: movieMap['title'],
        id: movieMap['id'],
        description: movieMap['description'],
        releaseDate: movieMap['releaseDate'],
        imageUrl: movieMap['imageUrl'],
        isFavorite: movieMap['isFavorite'],
        originalLanguage: movieMap['originalLanguage'],
      );
      favoritesMovies.add(movie);
    }
    notifyListeners();
    return favoritesMovies;
  }

  Future<void> eraseBox() async{
    await moviesBox.erase();
    notifyListeners();
  }
}
