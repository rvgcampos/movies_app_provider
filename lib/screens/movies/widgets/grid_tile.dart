import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieGridTile extends StatelessWidget {
  final List<Movie> popMovies;
  final int index;
  final MovieProvider movieProvider;
  MovieGridTile({this.popMovies, this.index, this.movieProvider});

  Widget iconFavorite = FlareActor(
    'assets/animations/AnimHeart.flr',
    animation: 'pulse',
  );

  Widget iconUnFavorite = Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.MOVIE_DETAIL, arguments: {
            'movieSelected': popMovies[index],
            'movieProvider': movieProvider,
          });
        },
        onLongPress: () {
          Share.share(popMovies[index].imageUrl);
        },
        child: Opacity(
          opacity: 0.9,
          child: Hero(
            tag: popMovies[index].id,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: popMovies[index].imageUrl,
              height: 300.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      header: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(
          popMovies[index].title,
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  popMovies[index].voteAverage.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      footer: GridTileBar(
        leading: IconButton(
          icon: popMovies[index].isFavorite ? iconFavorite : iconUnFavorite,
          onPressed: () {
            if (popMovies[index].isFavorite == true) {
              movieProvider.unFavoriteMovie(popMovies[index]);
            } else {
              movieProvider.favoriteMovie(popMovies[index]);
            }
          },
        ),
      ),
    );
  }
}
