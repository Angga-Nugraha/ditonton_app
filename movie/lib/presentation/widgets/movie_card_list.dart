import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';

import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kRichBlack,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            movieDetailRoutes,
            arguments: movie.id,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Card(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16 + 80 + 16,
                    bottom: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        movie.overview ?? '-',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: buildCardImage(movie.posterPath!, screenWidth: 80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
