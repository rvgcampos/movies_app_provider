import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/screens/movies_detail/widgets/genre_card.dart';
import 'package:movies_app/screens/movies_detail/widgets/rating.dart';
import 'package:provider/provider.dart';

class MoviesDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
    final Movie movieSelected = arguments['movieSelected'];
    Size size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          Consumer<MovieProvider>(
            builder: (_, movieProvider, __) {
              return IconButton(
                icon: movieSelected.isFavorite
                    ? Icon(
                        Icons.star,
                        color: Colors.yellow.withOpacity(0.9),
                      )
                    : Icon(
                        Icons.star_border,
                        color: Colors.yellow.withOpacity(0.9),
                      ),
                onPressed: () {
                  if (movieSelected.isFavorite) {
                    movieProvider.unFavoriteMovie(movieSelected);
                  } else {
                    movieProvider.favoriteMovie(movieSelected);
                  }
                },
              );
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        color: Colors.indigo,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.4),
              padding: EdgeInsets.only(
                top: size.height * 0.08,
                // left: 20,
                // right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      color: Colors.indigo.withOpacity(0.5),
                      width: double.infinity,
                      height: size.height * 0.1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Data de Lançamento',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                movieSelected.releaseDate,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Língua de Origem',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                movieSelected.originalLanguage,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Column(
                        children: [
                          Text(
                            'Descrição',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                          ),
                          Text(
                            movieSelected.description != '' ? movieSelected.description : 'Descrição do filme indisponível!',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      movieSelected.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  cards(movieSelected, size),
                  SizedBox(height: isLandscape ?size.height *0.03 : size.height *0.06),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Rating(movieSelected),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 30,
                              color: Color(0xff292D71).withOpacity(0.6),
                            ),
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: size.width * 0.40,
                              height:isLandscape ?size.height * 0.25 : size.height * 0.3,
                              child: Hero(
                                tag: movieSelected.id,
                                child: Image.network(
                                  movieSelected.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cards(Movie movieSelected, Size size) {
    return FittedBox(
          child: Row(
        children: movieSelected.genres.map((g) => GenreCard(g)).toList(),
      ),
    );
  }
}
