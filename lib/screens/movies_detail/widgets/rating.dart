import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';

class Rating extends StatelessWidget {
  final Movie movieSelected;

  Rating(this.movieSelected);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          movieSelected.voteAverage.toString(),
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        if (movieSelected.voteAverage == 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star_border, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 0 && movieSelected.voteAverage <= 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 1 && movieSelected.voteAverage <= 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 2 && movieSelected.voteAverage <= 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 3 && movieSelected.voteAverage <= 4)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 4 && movieSelected.voteAverage <= 5)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 5 && movieSelected.voteAverage <= 6)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 6 && movieSelected.voteAverage <= 7)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 7 && movieSelected.voteAverage <= 8)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 8 && movieSelected.voteAverage <= 9)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage > 9 && movieSelected.voteAverage <= 10)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star_half, color: Colors.yellowAccent),
            ],
          )
        else if (movieSelected.voteAverage == 10)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
