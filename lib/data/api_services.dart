import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/locall_database.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/utils/app_const.dart';

class ApiServices {
  static Future<List<AllMovies>> getComingSoonMovies(int page) async {
    String? apiKey = dotenv.env['API_KEY'];

    final url = Uri.parse('$baseUrl?api_key=$apiKey&page=$page');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieresponse = MovieResponse.fromJson(data);

        final moviesWithGenres = movieresponse.results
            .map((movie) => AllMovies(
                  id: movie.id,
                  genreIds: movie.genreIds,
                  title: movie.title,
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                  backdropPath: movie.backdropPath,
                  releaseDate: movie
                      .releaseDate, // Assuming genreIds is a list of integers
                ))
            .toList();

        for (final movieWithGenres in moviesWithGenres) {
          if (!(await LocalDatabase.movieExists(movieWithGenres.id))) {
            // Insert only if movie doesn't exist
            await LocalDatabase.insertMovie(movieWithGenres);
          } else {
            // Handle duplicate movie (e.catch exists logic)
            debugPrint('Movie with ID ${movieWithGenres.id} already exists.');
          }
        }

        // Return the original AllMovies objects for UI display
        return movieresponse.results;
      } else {
        // API call failed, handle with pre-existing data
        debugPrint('API call failed with status code: ${response.statusCode}');
        final movies = await LocalDatabase.getAllMovies();
        return movies; // Return data from local database if API fails
      }
    } catch (e) {
      debugPrint(e.toString());
      // Handle other exceptions (e.g., network issues)
      final movies = await LocalDatabase.getAllMovies();
      return movies; // Fallback to local data on exceptions
    }
  }

  static Future<List<Genres>> getGenreNames() async {
    String? apiKey = dotenv.env['API_KEY'];

    final url = Uri.parse('$genresUrl$apiKey&language=en-US');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final genresList = data['genres'] as List; // Cast to List<dynamic>

        final genres =
            genresList.map((genre) => Genres.fromJson(genre)).toList();

        // Save genres to local database
        await _saveGenresToLocalDb(genres);

        return genres;
      } else {
        // API call failed, handle with pre-existing data
        debugPrint('API call failed with status code: ${response.statusCode}');
        final movies = await LocalDatabase.getAllGenres();
        return movies;
      }
    } catch (e) {
      debugPrint(e.toString());
      final movies = await LocalDatabase.getAllGenres();
      return movies;
    }
  }

  static Future<void> _saveGenresToLocalDb(List<Genres> genres) async {
    // Use LocallDatabase to insert genres
    for (final genre in genres) {
      await LocalDatabase.insertGenre(genre);
    }
  }

  static Future<String> getTrailerKey(int movieId) async {
    String? apiKey = dotenv.env['API_KEY'];

    final videoResponse = await http.get(
        Uri.parse('$videoUrl/$movieId/videos?api_key=$apiKey&language=en-US'));
    if (videoResponse.statusCode == 200) {
      final videoData = jsonDecode(videoResponse.body);
      List<Videos> videoList = (videoData['results'] as List)
          .map((json) => Videos.fromJson(json))
          .toList();

      return videoList.firstWhere((video) => video.type == 'Trailer').key;
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }
}
