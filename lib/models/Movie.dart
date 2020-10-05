import 'package:movies_app/utils/genres_list.dart';
import 'package:movies_app/utils/languages_list.dart';

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
    final genresList = genres_List;

    final languageList = language_List;

    title = map['title'] as String;
    id = map['id'] as int;

    final voteAverageRaw = map['vote_average'].toString();
    voteAverage = double.parse(voteAverageRaw);

    description = map['overview'] as String;

    final dateRaw = map['release_date'] as String;
    // releaseDate = '${dateRaw.substring(0,4)}/${dateRaw.substring(5,7)}/${dateRaw.substring(8,10)}';
    releaseDate = '${dateRaw.substring(5, 7)}/${dateRaw.substring(8, 10)}/${dateRaw.substring(0, 4)}';

    final imagePath = map['poster_path'] as String;
    imageUrl += imagePath;

    final String languageRaw = map['original_language'];
    // print(languageRaw);
    for (var lang in languageList) {
      if (languageRaw == lang["iso_639_1"]) {
        originalLanguage = lang["english_name"];
      }
    }
    // originalLanguage = languageList.map((lang) {
    //   // print(lang["iso_639_1"]);
    //   if (languageRaw == lang["iso_639_1"]) {
    //     return lang["english_name"];
    //   }
    // }).toList()[0];
    // print(originalLanguage);
    // originalLanguage = map['original_language'] as String;

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
