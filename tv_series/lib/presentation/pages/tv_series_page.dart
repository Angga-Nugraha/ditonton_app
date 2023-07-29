import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/playing_now_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';

class HomeTVPage extends StatefulWidget {
  const HomeTVPage({Key? key}) : super(key: key);

  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => [
        Provider.of<PlayingNowTVBloc>(context, listen: false)
            .add(FetchNowPlayingTV()),
        Provider.of<PopularTVBloc>(context, listen: false)
            .add(FetchPopularTV()),
        Provider.of<TopRatedTVBloc>(context, listen: false)
            .add(FetchTopRatedTV()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchTvRoutes);
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
                'Now Playing On Air',
                style: kHeading6,
              ),
              BlocBuilder<PlayingNowTVBloc, PlayingNowTVState>(
                  builder: (context, state) {
                if (state is PlayingNowTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PlayingNowTVHasData) {
                  return TVList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularTvRoutes),
              ),
              BlocBuilder<PopularTVBloc, PopularTVState>(
                  builder: (context, state) {
                if (state is PopularTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTVHasData) {
                  return TVList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedTvRoutes),
              ),
              BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
                  builder: (context, state) {
                if (state is TopRatedTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTVHasData) {
                  return TVList(state.result);
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

class TVList extends StatelessWidget {
  final List<Tv> tv;

  const TVList(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvList = tv[index];
          return Material(
            color: kRichBlack,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    tvDetailRoutes,
                    arguments: tvList.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$baseImageUrl${tvList.posterPath}',
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
        itemCount: tv.length,
      ),
    );
  }
}
