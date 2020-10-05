import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/utils/app_routes.dart';

class SearchCard extends StatelessWidget {
  final Movie popMovie;
  SearchCard(this.popMovie);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: {'movieSelected': popMovie});
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: Image.network(popMovie.imageUrl),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  popMovie.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Flexible(flex: 1, child: Text(popMovie.releaseDate))
            ],
          ),
          subtitle: Text(
            popMovie.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
