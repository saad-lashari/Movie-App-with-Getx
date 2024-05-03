import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/locall_db/locall_db_controller.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'dart:convert';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/utils/app_const.dart';

class MovieController extends GetxController {
  final scrollController = ScrollController();
  final dbController = Get.put(SharedPrefController());
  int pgnmbr = 0;
  RxList<AllMovies> movies = RxList<AllMovies>([]);
  RxList<String> genresName = RxList([]);
  List<Genres> genres = [];
  @override
  onInit() {
    super.onInit();
    fetchMovies(1);
    getGenreNames();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchMovies(pgnmbr);
        update();
      }
    });
  }

  Future<void> fetchMovies(int page) async {
    final apiKey = dotenv.env['API_KEY']; // Access the API key from .env
    final url = Uri.parse('$baseUrl?api_key=$apiKey&page=$page');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body) as Map<String, dynamic>;
        final movieList = MovieResponse.fromJson(decodedData);
        movies.addAll(movieList.results);
        pgnmbr = movieList.page + 1;
        dbController.saveMovieList(movies);
        update();
      } else {
        throw Exception(
            'Failed to fetch movies: Status code ${response.statusCode}');
      }
    } on Exception catch (error) {
      print(error); // Log the error for debugging
      movies.value =
          await dbController.getMovieList(); // Fallback to local data
      update();
    }
  }

  Future<void> getGenreNames() async {
    final apiKey = dotenv.env['API_KEY'];
    final url = Uri.parse('$genresUrl$apiKey&language=en-US');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final genreslist = data['genres']; // Casting (might be unreliable)

        for (final Map<String, dynamic> genre in genreslist) {
          genres.add(Genres.fromJson(genre));
        }
        dbController.saveGenresList(genres);
      } else {
        throw Exception(
            'Failed to fetch genres: Status code ${response.statusCode}');
      }
    } catch (e) {
      genres = await dbController.getGenresList();
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

  Future<String> getTrailerKey(int movieId) async {
    final apiKey = dotenv.env['API_KEY'];

    final videoResponse = await http.get(
        Uri.parse('$videoUrl/$movieId/videos?api_key=$apiKey&language=en-US'));
    if (videoResponse.statusCode == 200) {
      final videoData = jsonDecode(videoResponse.body);
      List<Videos> videoList = (videoData['results'] as List)
          .map((json) => Videos.fromJson(json))
          .toList();

      // Return the key of the first trailer directly
      return videoList.firstWhere((video) => video.type == 'Trailer').key;
    } else {
      // Handle error
      throw Exception('Failed to fetch movie details');
    }
  }
}

class Videos {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  Videos({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        iso6391: json['iso_639_1'] as String,
        iso31661: json['iso_3166_1'] as String,
        name: json['name'] as String,
        key: json['key'] as String,
        site: json['site'] as String,
        size: json['size'] as int,
        type: json['type'] as String,
        official: json['official'] as bool,
        publishedAt: DateTime.parse(json['published_at'] as String),
        id: json['id'] as String,
      );
}
