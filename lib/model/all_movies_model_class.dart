class AllMovies {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String backdropPath;

  final List<int> genreIds;
  final String releaseDate;

  AllMovies({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
    required this.releaseDate,
  });

  factory AllMovies.fromJson(Map<String, dynamic> json) => AllMovies(
        id: json['id'] as int,
        title: json['title'] as String,
        originalTitle: json['original_title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String,
        backdropPath: json['backdrop_path'] as String,
        genreIds: (json['genre_ids'] as List).cast<int>(),
        releaseDate: json['release_date'] as String,
      );

  // Added toJson method
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'original_title': originalTitle,
        'overview': overview,
        'poster_path': posterPath,
        'backdrop_path': backdropPath,
        'genre_ids': genreIds,
        'release_date': releaseDate,
      };
}

class Videos {
  final String name;
  final String key;
  final String site;
  final String type;

  Videos({
    required this.name,
    required this.key,
    required this.site,
    required this.type,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        name: json['name'] as String,
        key: json['key'] as String,
        site: json['site'] as String,
        type: json['type'] as String,
      );
}
