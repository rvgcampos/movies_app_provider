import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/screens/movies_detail/widgets/genre_card.dart';
import 'package:movies_app/screens/movies_detail/widgets/rating.dart';

class MoviesDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movieSelected = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
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
                top: size.height * 0.12,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                // gradient: LinearGradient(
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,
                //   colors: [Color(0xffC0CEE6), Color(0xff71A0EB)],
                // ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Data de Lançamento',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              ),
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
                          children: [
                            Text(
                              'Língua de Origem',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrição',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            movieSelected.description != '' ? movieSelected.description : 'Descrição do filme indisponível!',
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
                  Text(
                    movieSelected.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  cards(movieSelected, size),
                  SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Rating(movieSelected),
                      ),
                      // SizedBox(width: size.width * 0.10),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: size.width * 0.40,
                          height: size.height * 0.3,
                          child: Hero(
                            tag: movieSelected.id,
                            child: Image.network(
                              movieSelected.imageUrl,
                              fit: BoxFit.fill,
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
    return Row(
      children: movieSelected.genres.map((g) => GenreCard(g)).toList(),
    );
  }

}
