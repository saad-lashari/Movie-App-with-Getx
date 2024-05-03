import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/view/cards/main_movie_card.dart';
import 'package:movie_app/view/dashboard/dashboard_screen.dart';
import 'package:movie_app/view/movie_detail/movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(MovieController());

  final dashcon = Get.put(DashbordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch'),
        actions: [
          IconButton(
              onPressed: () {
                dashcon.onItemTapped(1);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Obx(() => ListView.separated(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: controller.movies.length + 1,
          itemBuilder: ((context, index) {
            final movies = controller.movies;
            if (index < movies.length) {
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
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }))),
    );
  }
}
