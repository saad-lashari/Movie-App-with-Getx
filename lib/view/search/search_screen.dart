import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_controller.dart';
import 'package:movie_app/view/cards/main_movie_card.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(MovieController());
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: TextFormField(
                  onChanged: (value) {
                    controller.filterMoviesByTitle(value);
                    setState(() {});
                  },
                  onTap: () {
                    isSearch = !isSearch;
                    setState(() {});
                  },
                  style: const TextStyle(color: Color(0xffFFFFFF)),
                  decoration: InputDecoration(
                      suffixIcon: isSearch ? null : const Icon(Icons.search),
                      prefix: const Icon(Icons.search),
                      suffix: IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          },
                          icon: const Icon(Icons.cancel)),
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
                child: isSearch
                    ? Obx(
                        () => ListView.builder(
                            itemCount: controller.filterlist.length,
                            itemBuilder: (context, index) {
                              final filterlist = controller.filterlist;
                              return ListTile(
                                leading: CachedNetworkImage(
                                  key: UniqueKey(),
                                  height: size.height * 0.25,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  imageUrl: '${filterlist[index].posterPath}',
                                  placeholder: (context, url) => Center(
                                    child: Icon(
                                      Icons.image,
                                      size: size.height * 0.1,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return MainMovieCard(movie: controller.movies[index]);
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
