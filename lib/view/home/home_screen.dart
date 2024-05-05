import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/home_controller.dart';
import 'package:movie_app/view/cards/main_movie_card.dart';
import 'package:movie_app/view/dashboard/dashboard_screen.dart';
import 'package:movie_app/view/movie_detail/movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
        body: GetBuilder<HomeController>(builder: (con) {
          if (con.movies.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
                controller: con.scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: con.movies.length + 1,
                itemBuilder: ((context, index) {
                  final movies = con.movies;
                  if (index == movies.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        final names = con
                            .getGenreNamesFromList(con.movies[index].genreIds);
                        Get.to(() => MovieDetailsScreen(
                              movie: movies[index],
                              genres: names,
                            ));
                      },
                      child: MainMovieCard(
                        movie: con.movies[index],
                      ),
                    );
                  }
                }));
          }
        }));
  }
}
