import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/utils/app_const.dart';

class MainMovieCard extends StatelessWidget {
  const MainMovieCard({super.key, required this.movie});

  final AllMovies movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          CachedNetworkImage(
            key: UniqueKey(),
            height: size.height * 0.25,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '$imageUrl${movie.backdropPath}',
            placeholder: (context, url) => Center(
              child: Icon(
                Icons.image,
                size: size.height * 0.1,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Text(
              movie.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
