import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

class TVDetailPage extends StatefulWidget {
  final int id;
  const TVDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TVDetailPage> createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => [
          Provider.of<DetailTVBloc>(context, listen: false)
              .add(FetchDetailTV(widget.id)),
          Provider.of<RecommendationTVBloc>(context, listen: false)
              .add(FetchRecommendationTV(widget.id)),
          Provider.of<WatchlistBloc>(context, listen: false)
              .add(LoadWatchlistTVStatus(widget.id)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTVBloc, DetailTVState>(
        builder: (context, state) {
          if (state is DetailTVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTVHasData) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(tv),
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
  final TvDetail tvDetail;
  const DetailContent(this.tvDetail, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final poster = tvDetail.posterPath;
    return Stack(
      children: [
        buildCardImage(poster!, screenWidth: screenWidth),
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
                              tvDetail.name!,
                              style: kHeading5,
                            ),
                            showGenres(tvDetail.genres),
                            const SizedBox(height: 16),
                            buildRattingBar(tvDetail.voteAverage),
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
                                                .add(AddTvWatchlist(tvDetail));
                                          } else if (state.isAdded == true) {
                                            context.read<WatchlistBloc>().add(
                                                DeleteTvWatchlist(tvDetail));
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
                                BlocConsumer<TrailerTvBloc, TrailerTvState>(
                                  listener: (context, state) {
                                    if (state is TrailerTvHasData) {
                                      final video = state.result;
                                      buildVideoDialog(context, video);
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        context.read<TrailerTvBloc>().add(
                                            FetchTrailerTv(tvId: tvDetail.id));
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.movie_filter_outlined),
                                          Text('View Trailer'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Season:',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: SeasonList(tvDetail: tvDetail),
                            ),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview ?? '-',
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTVBloc,
                                RecommendationTVState>(
                              builder: (context, state) {
                                if (state is RecommendationTVLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationTVHasData) {
                                  final recommendations = state.result;
                                  return SafeArea(
                                    child: RecomendationsTVList(
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
