import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies_app/providers/favorite_provider.dart';

class MovieProvider extends ChangeNotifier {
  static const String API_KEY = "595b0e6818e6ad4180cfc801815d4dba";
  static const String BASE_URL = "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=pt-BR&page=";

  MovieProvider() {
    favoriteProvider = FavoriteProvider();
    // favoriteProvider.eraseBox();
  }

  Future<void> readFavorites() async {
    favoriteMovies = await favoriteProvider.readFavorites();
    print("Filmes favoritos: $favoriteMovies");
  }

  FavoriteProvider favoriteProvider;
  List<Movie> popularMovies = [];
  List<Movie> searchPopularMovies = [];
  List<Movie> favoriteMovies = [];
  int selectedIndex = 0;

  Future<void> fetchMovies([int page = 1]) async {
    print('fetchmovies');
    print(popularMovies);
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=pt-BR&page=";
    url += page.toString();
    print(url);
    final response = await http.get(url);
    print("Response ${response.body}");
    Map<String, Object> movies = await json.decode(response.body);

    for (var movie in movies["results"]) {
      popularMovies.add(Movie.fromMap(movie));
    }
    print(popularMovies);

    if (favoriteMovies.isNotEmpty) {
      for (var popMovie in popularMovies) {
        for (var favMovie in favoriteMovies) {
          if (popMovie.id == favMovie.id) {
            popMovie.isFavorite = true;
          }
        }
      }
    }
    // print(popularMovies[0].isFavorite);
    searchPopularMovies = popularMovies;
    notifyListeners();
  }

  void favoriteMovie(Movie movie) async {
    if (favoriteMovies.where((movieSelected) => movieSelected.id == movie.id).toList().isEmpty) {
      movie.isFavorite = true;
      await favoriteProvider.saveFavorite(movie);
      favoriteMovies = await favoriteProvider.readFavorites();

      if (favoriteMovies.isNotEmpty) {
        for (var popMovie in popularMovies) {
          for (var favMovie in favoriteMovies) {
            if (popMovie.id == favMovie.id) {
              popMovie.isFavorite = true;
            }
          }
        }
      }
      print(movie.isFavorite);
      searchPopularMovies = popularMovies;

      notifyListeners();
    }
  }

  void unFavoriteMovie(Movie movie) async {
    if (favoriteMovies.where((movieSelected) => movieSelected.id == movie.id).toList().isNotEmpty) {
      movie.isFavorite = false;
      await favoriteProvider.removeFavorite(movie);
      favoriteMovies = await favoriteProvider.readFavorites();

      if (favoriteMovies.isNotEmpty) {
        for (var popMovie in popularMovies) {
          popMovie.isFavorite = false;
        }
        for (var popMovie in popularMovies) {
          for (var favMovie in favoriteMovies) {
            if (popMovie.id == favMovie.id) {
              popMovie.isFavorite = true;
            }
          }
        }
      } else {
        for (var popMovie in popularMovies) {
          popMovie.isFavorite = false;
        }
      }
      print(movie.isFavorite);
      searchPopularMovies = popularMovies;

      notifyListeners();
    }
  }

  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void search(String search) {
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

    if (movie.isNotEmpty) {
      searchPopularMovies = movie;
    } else {
      searchPopularMovies = popularMovies;
    }
    notifyListeners();
  }
}
