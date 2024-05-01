import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/view/cards/main_movie_card.dart';
import 'package:movie_app/view/movie_detail/movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Obx(() => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: controller.movies.length,
          itemBuilder: ((context, index) {
            final movies = controller.movies;
            return InkWell(
              onTap: () {
                final names = controller
                    .getGenreNamesFromList(controller.movies[index].genreIds);
                Get.to(() => MovieDetailsScreen(
                      movie: movies[index],
                      genres: names,
                    ));
              },
              child: MainMovieCard(
                movie: controller.movies[index],
              ),
            );
          }))),
    );
  }
}
