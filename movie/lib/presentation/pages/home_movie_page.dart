import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/playing_now_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          BlocProvider.of<PlayingNowMovieBloc>(context, listen: false)
              .add(FetchNowPlayingMovies()),
          Provider.of<TopRatedMovieBloc>(context, listen: false)
              .add(FetchTopRatedMovies()),
          Provider.of<PopularMovieBloc>(context, listen: false)
              .add(FetchPopularMovies()),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchMovieRoutes);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<PlayingNowMovieBloc, PlayingNowMovieState>(
                  builder: (context, state) {
                if (state is PlayingNowMovieListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PlayingNowMovieListHasData) {
                  return MovieList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    Navigator.pushNamed(context, topRatedMovieRoutes);
                  }),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                  builder: (context, state) {
                if (state is TopRatedMovieListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMovieListHasData) {
                  return MovieList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularMovieRoutes),
              ),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(
                  builder: (context, state) {
                if (state is PopularMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieHasData) {
                  return MovieList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Material(
            color: kRichBlack,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    movieDetailRoutes,
                    arguments: movie.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$baseImageUrl${movie.posterPath}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
