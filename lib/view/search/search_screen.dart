import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/home_controller.dart';
import 'package:movie_app/controller/search_controller.dart';
import 'package:movie_app/view/cards/main_movie_card.dart';
import 'package:movie_app/view/cards/search_movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final movieSearchController =
      Get.find<MovieSearchController>(); // Use singleton

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) =>
                      movieSearchController.searchMovie(searchController.text),
                  onChanged: (val) => movieSearchController
                      .searchMovie(val), // Update on each keystroke
                  onTap: () => movieSearchController
                      .activateSearch(), // Activate search on tap
                  decoration: InputDecoration(
                      suffixIcon: Obx(
                        () => movieSearchController.isSearchActive.value
                            ? IconButton(
                                onPressed: () {
                                  movieSearchController.deactivateSearch();
                                  FocusScope.of(context).unfocus();
                                  searchController.clear();
                                },
                                icon: const Icon(Icons.cancel))
                            : const Icon(Icons.search),
                      ),
                      prefix: const Icon(Icons.search),
                      hintStyle: const TextStyle(color: Color(0xffFFFFFF)),
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xffEFEFEF),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                child: Obx(
                  () => movieSearchController.isSearchActive.value
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: movieSearchController.searchList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final movie =
                                movieSearchController.searchList[index];
                            return SearchMovieCard(movie: movie);
                          },
                        )
                      : GetBuilder<HomeController>(
                          builder: (con) => GridView.builder(
                              shrinkWrap: true,
                              itemCount: con.movies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (BuildContext context, int index) {
                                return MainMovieCard(movie: con.movies[index]);
                              }),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
