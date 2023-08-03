import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class RecomendationsMovieList extends StatelessWidget {
  const RecomendationsMovieList({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  final List<Movie> recommendations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  movieDetailRoutes,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: buildCardImage(movie.posterPath!),
              ),
            ),
          );
        },
        itemCount: recommendations.length,
      ),
    );
  }
}
