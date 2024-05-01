import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/genres_model_class.dart';
import 'dart:convert';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/utils/app_const.dart';

class MovieController extends GetxController {
  RxList<AllMovies> movies = RxList<AllMovies>([]);
  RxList<String> genresName = RxList([]);
  List<Genres> genres = [];
  @override
  onInit() {
    super.onInit();
    fetchMovies();
    getGenreNames();
  }

  Future<void> fetchMovies() async {
    final apiKey = dotenv.env['API_KEY']; // Access the API key from .env
    final url = Uri.parse('$baseUrl?api_key=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
      final movieList = MovieResponse.fromJson(decodedData);
      movies.value = movieList.results;
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  Future<void> getGenreNames() async {
    final apiKey = dotenv.env['API_KEY'];
    final url = Uri.parse('$genresUrl$apiKey&language=en-US');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final genreslist = data['genres']; // Casting (might be unreliable)

      for (final Map<String, dynamic> genre in genreslist) {
        genres.add(Genres.fromJson(genre));
      }
    } else {
      debugPrint('Error fetching genres: ${response.statusCode}');
    }
  }

  List<String> getGenreNamesFromList(List<int> genreIds) {
    final genreNames = <String>[];
    for (final genre in genres) {
      if (genreIds.contains(genre.id)) {
        genreNames.add(genre.name);
      }
    }
    return genreNames;
  }

  Future<String> fetchMovieDetails(int movieId) async {
    final apiKey = dotenv.env['API_KEY'];

    final videoResponse = await http.get(
        Uri.parse('$videoUrl/$movieId/videos?api_key=$apiKey&language=en-US'));
    if (videoResponse.statusCode == 200) {
      final videoData = jsonDecode(videoResponse.body);
      final result = videoData['results'][0]['key'];
      log(result.toString());
      // return videos;
      return result;
    } else {
      // Handle error, e.g., throw an exception or log the error
      throw Exception('Failed to fetch movie details');
    }
  }
}
