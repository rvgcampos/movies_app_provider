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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          genre,
          style: TextStyle(
            fontSize: 15
          ),
        ),
      ),
    );
  }
}
