import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class WatchListMovies extends StatelessWidget {
  const WatchListMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieEmpty) {
            return const Center(
              child: Text('Watchlist is empty'),
            );
          } else if (state is WatchlistMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}
