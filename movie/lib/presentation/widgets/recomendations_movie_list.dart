import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:core/presentation/movie/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecomendationsMovieList extends StatelessWidget {
  const RecomendationsMovieList({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  final List<Movie> recommendations;

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieDetailNotifier>(
      builder: (context, data, child) {
        if (data.recommendationState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (data.recommendationState == RequestState.Error) {
          return Text(data.message);
        } else if (data.recommendationState == RequestState.Loaded) {
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
                        MOVIE_DETAIL_ROUTE,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
