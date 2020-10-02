import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/movies/movies_screen.dart';
import 'package:movies_app/screens/movies_detail/movies_detail_screen.dart';
import 'package:movies_app/screens/search/search_screen.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return MovieProvider()
          ..readFavorites()
          ..fetchMovies();
      },
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Filme Populares',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Color(0xFFFAF0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (ctx) => MoviesScreen(),
          AppRoutes.MOVIE_DETAIL: (ctx) => MoviesDetailScreen(),
          AppRoutes.SEARCH_SCREEN: (ctx) => SearchScreen(),
        },
      ),
    );
  }
}
