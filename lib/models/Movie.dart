class Movie {
  String title;
  int id;
  // String voteAverage;
  String description;
  String releaseDate;
  String imageUrl = "https://image.tmdb.org/t/p/w500";
  bool isFavorite = false;

  Movie({
    this.title,
    this.id,
    // this.voteAverage,
    this.description,
    this.releaseDate,
    this.imageUrl,
    this.isFavorite,
  });

  Movie.fromMap(Map<String, dynamic> map) {
    title = map['title'] as String;
    id = map['id'] as int;
    // voteAverage = map['vote_average'] as String;
    description = map['overview'] as String;
    releaseDate = map['release_date'] as String;
    final imagePath = map['poster_path'] as String;
    imageUrl += imagePath;
  }
}
