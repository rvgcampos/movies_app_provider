import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoriteCard extends StatelessWidget {
  final List<Movie> favMovies;
  final int index;

  FavoriteCard(this.favMovies, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(favMovies[index]);
        Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: favMovies[index]);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          title: Text(
            favMovies[index].title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            favMovies[index].description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15),
          ),
          leading: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: favMovies[index].imageUrl,
            height: 300.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
