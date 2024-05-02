import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/controller/search_controller.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/utils/app_const.dart';
import 'package:movie_app/view/movie_detail/movie_details_screen.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key});
  final controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<MovieSearchController>(
      builder: (con) => SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                      )),
                  Text(
                    'Results Found: ${con.searchList.length}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: con.searchList.length,
                  itemBuilder: (context, index) {
                    final list = con.searchList;
                    return InkWell(
                        onTap: () {
                          final names = controller.getGenreNamesFromList(
                              controller.movies[index].genreIds);

                          Get.to(() => MovieDetailsScreen(
                              movie: list[index], genres: names));
                        },
                        child: SearchReultCard(movie: list[index]));
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}

class SearchReultCard extends StatelessWidget {
  const SearchReultCard({super.key, required this.movie});

  final AllMovies movie;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: size.height * 0.1,
      child: Row(
        children: [
          SizedBox(
            height: 150,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                key: UniqueKey(),
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: '$imageUrl${movie.posterPath}',
                placeholder: (context, url) => Center(
                  child: Icon(
                    Icons.image,
                    size: size.height * 0.1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  movie.title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz)
        ],
      ),
    );
  }
}
