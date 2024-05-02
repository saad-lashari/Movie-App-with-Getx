import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/all_movies_model_class.dart';
import 'package:movie_app/utils/app_const.dart';

class SearchMovieCard extends StatelessWidget {
  const SearchMovieCard({super.key, required this.movie});

  final AllMovies movie;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // color: Colors.green,
      height: size.height * 0.2,
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
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  maxLines: 3,
                  movie.overview,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );

    //   ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: Stack(
    //     children: [
    // CachedNetworkImage(
    //   key: UniqueKey(),
    //   height: size.height * 0.25,
    //   width: double.infinity,
    //   fit: BoxFit.cover,
    //   imageUrl: '$imageUrl${movie.backdropPath}',
    //   placeholder: (context, url) => Center(
    //     child: Icon(
    //       Icons.image,
    //       size: size.height * 0.1,
    //     ),
    //   ),
    // ),
    //       Positioned(
    //         bottom: 10.0,
    //         left: 10.0,
    //         child: Text(
    //           movie.title,
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 18.0,
    //             fontWeight: FontWeight.w500,
    //             shadows: [
    //               Shadow(
    //                 offset: const Offset(2.0, 2.0),
    //                 blurRadius: 4.0,
    //                 color: Colors.black.withOpacity(0.5),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
