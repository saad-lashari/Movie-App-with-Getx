import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/locall_db/locall_db_controller.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/utils/app_const.dart';

class ApiController extends GetxController {
  String? apiKey = dotenv.env['API_KEY'];
  final dbController = Get.put(LocallDatabaseController());
  @override
  onInit() async {
    super.onInit();
    getComingSoonMovies(2);
    getGenreNames();
  }

  Future<List<AllMovies>> getComingSoonMovies(int page) async {
    final url = Uri.parse('$baseUrl?api_key=$apiKey&page=$page');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieresponse = MovieResponse.fromJson(data);
        dbController.saveMovieList(movieresponse.results);

        return movieresponse.results;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Genres>> getGenreNames() async {
    List<Genres> list = [];
    final url = Uri.parse('$genresUrl$apiKey&language=en-US');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final genreslist = data['genres'];

        for (final Map<String, dynamic> genre in genreslist) {
          list.add(Genres.fromJson(genre));
        }
        dbController.saveGenresList(list);

        return list;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> getTrailerKey(int movieId) async {
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
