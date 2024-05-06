import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/genres_model_class.dart';
import 'package:movie_app/model/all_movies_model_class.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();

  int currentPage = 1; // Current page number

  List<AllMovies> movies = [];
  List<Genres> genres = [];
  @override
  onInit() async {
    await getIntialData();
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getNextPage();
        update();
      }
    });
  }

  getIntialData() async {
    movies =
        await ApiServices.getComingSoonMovies(currentPage).whenComplete(() {
      update();
    });
    genres = await ApiServices.getGenreNames();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> getNextPage() async {
    currentPage++;
    final nextMovies = await ApiServices.getComingSoonMovies(currentPage);
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
