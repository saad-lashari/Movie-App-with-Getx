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
}
