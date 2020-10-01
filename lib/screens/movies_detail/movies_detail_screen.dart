import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';

class MoviesDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movieSelected = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Filme Detalhado'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              movieSelected.imageUrl,
              height: 400,
              fit: BoxFit.cover,
            ),
            Text(movieSelected.title),
            Text(movieSelected.description),
          ],
        ),
      ),
    );
  }
}
