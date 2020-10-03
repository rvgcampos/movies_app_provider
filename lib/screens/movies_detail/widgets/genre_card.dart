import 'package:flutter/material.dart';
// import 'package:movies_app/models/Movie.dart';

class GenreCard extends StatelessWidget {
  final String genre;

  GenreCard(this.genre);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 20,
      width: 80,
      decoration: BoxDecoration(
        color: colorPicked(genre),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          genre,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Color colorPicked(String genre) {
    if (genre == "Ação" || genre == "Drama" || genre == "Mistério" || genre == "Guerra" || genre == "Romance") {
      return Colors.red;
    } else if (genre == "Aventura" || genre == "Animação" || genre == "Fantasia" || genre == "Música" || genre == "Ficção científica") {
      return Colors.blue;
    } else if (genre == "Comédia" || genre == "Família" || genre == "Cinema TV" || genre == "Thriller") {
      return Colors.yellow;
    } else if (genre == "Documentário" || genre == "História" || genre == "Faroeste") {
      return Colors.green;
    } else if (genre == "Crime" || genre == "Terror") {
      return Colors.black;
    } else {
      return Colors.blue;
    }
  }
}
