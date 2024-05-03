import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController extends GetxController {
  late SharedPreferences _prefs;

  Future<void> saveMovieList(List<AllMovies> list) async {
    // log('order saved===>');
    _prefs = await SharedPreferences.getInstance();
    final List<String> serializedList =
        list.map((movie) => json.encode(movie.toJson())).toList();
    _prefs.setStringList('allMovies', serializedList);
    log('done movie');
  }

  Future<List<AllMovies>> getMovieList() async {
    // log('order retrieved===>');
    _prefs = await SharedPreferences.getInstance();
    final List<String>? serializedList = _prefs.getStringList('allMovies');

    if (serializedList == null) {
      return [];
    }

    return serializedList.map((jsonString) {
      final Map<String, dynamic> map = json.decode(jsonString);
      return AllMovies.fromJson(map);
    }).toList();
  }

  Future<void> saveGenresList(List<Genres> list) async {
    _prefs = await SharedPreferences.getInstance();
    final List<String> serializedList =
        list.map((entry) => json.encode(entry.toJson())).toList();
    _prefs.setStringList('genres', serializedList);
    log('done');
  }

  Future<List<Genres>> getGenresList() async {
    _prefs = await SharedPreferences.getInstance();
    final List<String>? serializedList = _prefs.getStringList('genres');

    if (serializedList == null) {
      return [];
    }

    return serializedList.map((jsonString) {
      final Map<String, dynamic> map = json.decode(jsonString);
      return Genres.fromJson(map);
    }).toList();
  }
}
