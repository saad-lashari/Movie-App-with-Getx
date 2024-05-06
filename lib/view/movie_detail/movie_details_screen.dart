import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/data/api_services.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/utils/app_const.dart';
import 'package:movie_app/view/player/player_screen.dart';
import 'package:movie_app/view/ticket/ticket_screen.dart';

class MovieDetailsScreen extends StatelessWidget {
  final List<String> genres;
  final AllMovies movie;
  const MovieDetailsScreen(
      {super.key, required this.movie, required this.genres});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
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
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.image,
                        size: size.height * 0.1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_left,
                                  color: Colors.white,
                                  size: 30,
                                )),
                            const Text(
                              'Watch',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const Spacer(),
                        Text(
                          textAlign: TextAlign.center,
                          'In the Threatres:${movie.releaseDate}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        CustomButton(
                          title: 'Get Ticket',
                          backgroundColor: const Color(0xff61C3F2),
                          onPressed: () {
                            Get.to(() => TicketScreen(
                                  title: movie.title,
                                  date: movie.releaseDate,
                                ));
                          },
                        ),
                        CustomButton(
                          title: 'Watch Trailer',
                          onPressed: () async {
                            final key =
                                await ApiServices.getTrailerKey(movie.id);
                            Get.to(() => PlayScreen(
                                  videoId: key,
                                ));
                            log(key);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      textAlign: TextAlign.left,
                      'Genres',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: genres.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.primaries[
                                      index % Colors.primaries.length]),
                              child: Center(
                                  child: Text(
                                genres[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                            );
                          }),
                    ),
                    const Divider(),
                    const Text(
                      textAlign: TextAlign.left,
                      'Overview',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(movie.overview)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Function()? onPressed;
  const CustomButton({
    super.key,
    this.backgroundColor,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: backgroundColor ?? const Color(0xff61C3F2)),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  5.0), // Adjust the value for desired radius
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          )),
    );
  }
}
        // color: Colors.primaries[index % Colors.primaries.length],
