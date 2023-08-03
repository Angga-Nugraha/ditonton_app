import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/core.dart';
import 'package:movie/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  const MovieDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          Provider.of<DetailMovieBloc>(context, listen: false)
              .add(FetchDetailMovie(widget.id)),
          Provider.of<RecommendationMovieBloc>(context, listen: false)
              .add(FetchRecommendationMovie(widget.id)),
          Provider.of<WatchlistBloc>(context, listen: false)
              .add(LoadWatchlistStatus(widget.id)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieHasData) {
            final movie = state.result;
            return SafeArea(
              child: DetailContent(movie),
            );
          } else {
            return const Text(
              key: Key('error_message'),
              'Failed',
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  const DetailContent(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        buildCardImage(movie.posterPath, screenWidth: screenWidth),
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            showGenres(movie.genres),
                            showDuration(movie.runtime),
                            buildRattingBar(movie.voteAverage),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocConsumer<WatchlistBloc, WatchlistState>(
                                  listener: (context, state) {
                                    if (state is WatchlistSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                      ));
                                    } else if (state is WatchlistFailure) {
                                      buildDialog(context, state.message);
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        if (state is WatchlistHasData) {
                                          if (state.isAdded == false) {
                                            context
                                                .read<WatchlistBloc>()
                                                .add(AddMovieWatchlist(movie));
                                          } else if (state.isAdded == true) {
                                            context.read<WatchlistBloc>().add(
                                                DeleteMovieWatchlist(movie));
                                          }
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (state is WatchlistHasData)
                                            if (state.isAdded == false)
                                              const Icon(Icons.add)
                                            else if (state.isAdded == true)
                                              const Icon(Icons.check),
                                          const Text('Watchlist'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                BlocConsumer<TrailerMovieBloc,
                                    TrailerMovieState>(
                                  listener: (context, state) {
                                    if (state is TrailerMovieHasData) {
                                      final video = state.result;
                                      buildVideoDialog(context, video);
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () async {
                                        context.read<TrailerMovieBloc>().add(
                                            FetchTrailerMovie(
                                                movieid: movie.id));
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.movie_filter_outlined),
                                          Text('View trailer'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMovieBloc,
                                RecommendationMovieState>(
                              builder: (context, state) {
                                if (state is RecommendationMovieLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationMovieHasData) {
                                  final recommendations = state.result;
                                  return SafeArea(
                                    child: RecomendationsMovieList(
                                        recommendations: recommendations),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
