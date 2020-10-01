import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies_app/providers/favorite_provider.dart';

class MovieProvider extends ChangeNotifier {
  static const String API_KEY = "595b0e6818e6ad4180cfc801815d4dba";
  static const String BASE_URL = "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=pt-BR&page=1";

  MovieProvider() {
    favoriteProvider = FavoriteProvider();
    // favoriteProvider.eraseBox();
  }

  Future<void> readFavorites() async {
    favoriteMovies = await favoriteProvider.readFavorites();
    // print(favoriteMovies);
  }

  FavoriteProvider favoriteProvider;
  List<Movie> popularMovies = [];
  List<Movie> searchPopularMovies = [];
  List<Movie> favoriteMovies = [];
  int selectedIndex = 0;

  Future<void> fetchMovies() async {
    final response = await http.get(BASE_URL);
    Map<String, Object> movies = await json.decode(response.body);

    for (var movie in movies["results"]) {
      popularMovies.add(Movie.fromMap(movie));
    }

    print(favoriteMovies);
    var selectedMovies = [];
    for (var movie in favoriteMovies) {
      selectedMovies = popularMovies.where((popMovie) => popMovie.id == movie.id).toList();
      print(selectedMovies);
      selectedMovies.map((movieSelected) {
        return movieSelected.isFavorite = movie.isFavorite;
      }).toList();
    }
    searchPopularMovies = popularMovies;
    notifyListeners();
  }

  void favoriteMovie(Movie movie) async {
    if (favoriteMovies.where((movieSelected) => movieSelected.id == movie.id).toList().isEmpty) {
      movie.isFavorite = true;
      await favoriteProvider.saveFavorite(movie);
      favoriteMovies = await favoriteProvider.readFavorites();
      // print(favoriteMovies);
      // print(popularMovies[0].isFavorite);
      notifyListeners();
    }
  }

  void unFavoriteMovie(Movie movie) async {
    if (favoriteMovies.where((movieSelected) => movieSelected.id == movie.id).toList().isNotEmpty) {
      print('teste');
      movie.isFavorite = false;
      await favoriteProvider.removeFavorite(movie);
      favoriteMovies = await favoriteProvider.readFavorites();
      // print(favoriteMovies);
      // print(popularMovies[0].isFavorite);
      notifyListeners();
    }
  }

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void search(String search) {
    // print(popularMovies);
    var movie = [];
    movie = popularMovies.where(
      (movie) {
        if (search.length > 0) {
          return movie.title.toLowerCase() == search.toLowerCase() || movie.title.toLowerCase().startsWith(search.toLowerCase());
        } else {
          return false;
        }
      },
    ).toList();

    print(movie);
    // print(movie[0].title);
    if (movie.isNotEmpty) {
      if (search.length > 0) {
        popularMovies = movie;
      }
    } else {
      popularMovies = searchPopularMovies;
    }
    notifyListeners();
  }
}
