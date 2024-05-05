import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/home_controller.dart';
import 'package:movie_app/controller/search_controller.dart';
import 'package:movie_app/view/cards/main_movie_card.dart';
import 'package:movie_app/view/cards/search_movie_card.dart';
import 'package:movie_app/view/search/search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final controller = Get.put(MovieSearchController());
  bool isSearch = false;
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
                  onFieldSubmitted: (text) {
                    // Perform your action here, e.g., validate or submit the text
                    controller.searchMovie(searchController.text);
                    Get.to(() => const SearchResultScreen());
                  },
                  onChanged: (val) {
                    controller.searchMovie(val);
                  },
                  onTap: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  decoration: InputDecoration(
                      suffixIcon: isSearch ? null : const Icon(Icons.search),
                      prefix: const Icon(Icons.search),
                      suffix: IconButton(
                          onPressed: () {
                            isSearch = false;
                            setState(() {
                              isSearch = false;
                            });
                            FocusScope.of(context).unfocus();
                            searchController.clear();
                            controller.searchList.clear();
                          },
                          icon: const Icon(Icons.cancel)),
                      hintStyle: const TextStyle(color: Color(0xffFFFFFF)),
                      isDense: true,
                      filled: true,
                      // contentPadding: EdgeInsets.zero,
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
                child: isSearch
                    ? GetBuilder<MovieSearchController>(
                        builder: (con) => ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.searchList.length,
                            itemBuilder: (context, index) {
                              final list = controller.searchList;
                              return SearchMovieCard(movie: list[index]);
                            }),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
