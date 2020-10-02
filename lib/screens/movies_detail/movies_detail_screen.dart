import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/screens/movies_detail/widgets/genre_card.dart';

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
                // color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xffC0CEE6), Color(0xff71A0EB)],
                ),
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
                              ),
                            ),
                            Text(movieSelected.releaseDate),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Língua de Origem',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(movieSelected.originalLanguage),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrição',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(movieSelected.description),
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
                      rating(movieSelected),
                      SizedBox(width: size.width * 0.20),
                      Container(
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

  Widget rating(Movie movieSelected) {
    return Column(
      children: [
        Text(
          movieSelected.voteAverage.toString(),
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        if (movieSelected.voteAverage == 0)
          Row(
            children: [
              Icon(Icons.star_border, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 0 && movieSelected.voteAverage <= 1)
          Row(
            children: [
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 1 && movieSelected.voteAverage <= 2)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 2 && movieSelected.voteAverage <= 3)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 3 && movieSelected.voteAverage <= 4)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 4 && movieSelected.voteAverage <= 5)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 5 && movieSelected.voteAverage <= 6)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 7 && movieSelected.voteAverage <= 8)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 8 && movieSelected.voteAverage <= 9)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 9 && movieSelected.voteAverage <= 10)
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else
          Icon(Icons.star, color: Colors.red),
      ],
    );
  }
}

// SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   Image.network(
//                     movieSelected.imageUrl,
//                     height: 400,
//                     fit: BoxFit.cover,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Text(
//                       movieSelected.title,
//                       style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 22),
//                     ),
//                   ),
//                   Text(
//                     movieSelected.voteAverage,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(movieSelected.releaseDate),
//                       Text(movieSelected.originalLanguage),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Descrição',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(movieSelected.description),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
