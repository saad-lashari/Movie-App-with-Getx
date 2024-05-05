import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/tmdb_api_controller.dart';
import 'package:movie_app/locall_db/locall_db_controller.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:movie_app/model/all_movies_model_class.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();

  final dbController = Get.put(LocallDatabaseController());
  final apiController = Get.put(ApiController());
  int currentPage = 1; // Current page number

  List<AllMovies> movies = [];
  List<String> genresName = [];
  List<Genres> genres = [];
  @override
  onInit() async {
    super.onInit();

    movies = await dbController.getMovieList();
    genres = await dbController.getGenresList();
    if (movies.isEmpty && genres.isEmpty) {
      movies = await apiController.getComingSoonMovies(currentPage);
      genres = await apiController.getGenreNames();
    }

    update();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getNextPage();
        update();
      }
    });
  }

  Future<void> getNextPage() async {
    currentPage++;
    final nextMovies = await apiController.getComingSoonMovies(currentPage);
    movies.addAll(nextMovies);
    update();
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
}
