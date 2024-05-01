import 'package:movie_app/model/date_model_class.dart';
import 'package:movie_app/model/all_movies_model_class.dart';

class MovieResponse {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<AllMovies> results;
  final Dates dates;

  MovieResponse({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
    required this.dates,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        page: json['page'] as int,
        totalResults: json['total_results'] as int,
        totalPages: json['total_pages'] as int,
        results: (json['results'] as List)
            .map((movieJson) => AllMovies.fromJson(movieJson))
            .toList(),
        dates: Dates.fromJson(json['dates']),
      );
}
