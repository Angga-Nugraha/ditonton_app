import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/season_tv_bloc.dart';

class SeasonTVPage extends StatefulWidget {
  final int id;
  final int numSeason;

  const SeasonTVPage({Key? key, required this.id, required this.numSeason})
      : super(key: key);

  @override
  State<SeasonTVPage> createState() => _SeasonTVPageState();
}

class _SeasonTVPageState extends State<SeasonTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<SeasonTVBloc>(context, listen: false)
          .add(FetchSeasonTV(widget.id, widget.numSeason)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonTVBloc, SeasonTVState>(
        builder: (context, state) {
          if (state is SeasonTVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonTVHasData) {
            final seasons = state.result;

            return SafeArea(
              child: DetailSeason(seasons),
            );
          } else {
            return const Center(
              key: Key('error message'),
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}

class DetailSeason extends StatelessWidget {
  final SeasonDetail season;

  const DetailSeason(this.season, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(builder: (context, scrollController) {
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
                            '${season.name}',
                            style: kHeading5,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Episodes: ',
                            style: kHeading6,
                          ),
                          _buildEpisode(screenWidth),
                          const SizedBox(height: 16),
                          Text(
                            'Overview',
                            style: kHeading6,
                          ),
                          Text(
                            '${season.overview}',
                            textAlign: TextAlign.justify,
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
          }),
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

  Widget _buildEpisode(double screenWidth) {
    return SizedBox(
      height: 350,
      width: screenWidth,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${season.episodes[index].stillPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Episode ${season.episodes[index].episodeNumber}',
                          // style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '${season.episodes[index].name}  ',
                          // style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          _showDuration(season.episodes[index].runtime ?? 0),
                          style: const TextStyle(fontSize: 10),
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: season.episodes[index].voteAverage! / 2,
                              itemCount: 5,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: kMikadoYellow,
                              ),
                              itemSize: 10,
                            ),
                            Text(
                              '${season.episodes[index].voteAverage}',
                              style: const TextStyle(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: season.episodes.length,
      ),
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
