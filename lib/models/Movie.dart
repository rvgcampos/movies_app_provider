class Movie {
  String title;
  int id;
  double voteAverage;
  String description;
  String releaseDate;
  String imageUrl = "https://image.tmdb.org/t/p/w500";
  bool isFavorite = false;
  String originalLanguage;
  List<dynamic> genres;

  Movie({
    this.title,
    this.id,
    this.voteAverage,
    this.description,
    this.releaseDate,
    this.imageUrl,
    this.isFavorite,
    this.originalLanguage,
    this.genres,
  });

  Movie.fromMap(Map<String, dynamic> map) {
    final genresList = [
      {"id": 28, "name": "Ação"},
      {"id": 12, "name": "Aventura"},
      {"id": 16, "name": "Animação"},
      {"id": 35, "name": "Comédia"},
      {"id": 80, "name": "Crime"},
      {"id": 99, "name": "Documentário"},
      {"id": 18, "name": "Drama"},
      {"id": 10751, "name": "Família"},
      {"id": 14, "name": "Fantasia"},
      {"id": 36, "name": "História"},
      {"id": 27, "name": "Terror"},
      {"id": 10402, "name": "Música"},
      {"id": 9648, "name": "Mistério"},
      {"id": 10749, "name": "Romance"},
      {"id": 878, "name": "Ficção científica"},
      {"id": 10770, "name": "Cinema TV"},
      {"id": 53, "name": "Thriller"},
      {"id": 10752, "name": "Guerra"},
      {"id": 37, "name": "Faroeste"}
    ];

    title = map['title'] as String;
    id = map['id'] as int;

    final voteAverageRaw = map['vote_average'].toString();
    voteAverage = double.parse(voteAverageRaw);

    description = map['overview'] as String;

    final dateRaw = map['release_date'] as String;
    // releaseDate = '${dateRaw.substring(0,4)}/${dateRaw.substring(5,7)}/${dateRaw.substring(8,10)}';
    releaseDate = '${dateRaw.substring(5,7)}/${dateRaw.substring(8,10)}/${dateRaw.substring(0,4)}';

    final imagePath = map['poster_path'] as String;
    imageUrl += imagePath;

    originalLanguage = map['original_language'] as String;

    final genresRaw = map['genre_ids'];
    genres = genresRaw.map((genre) {
      for (var g in genresList) {
        if (genre == g["id"]) {
          return g["name"];
        }
      }
    }).toList();
  }
}
