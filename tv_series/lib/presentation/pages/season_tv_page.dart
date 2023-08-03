import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/tv_series.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocBuilder<SeasonTVBloc, SeasonTVState>(
        builder: (context, state) {
          if (state is SeasonTVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonTVHasData) {
            final season = state.result;
            final episode = season.episodes;

            return SafeArea(
              child: Stack(
                children: [
                  buildCardImage(season.posterPath!, screenWidth: screenWidth),
                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                        builder: (context, scrollController) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: kRichBlack,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
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
                                    BlocConsumer<TrailerEpisodeBloc,
                                        TrailerEpisodeState>(
                                      listener: (context, state) {
                                        if (state is TrailerEpisodeHasData) {
                                          final video = state.result;
                                          buildVideoDialog(context, video);
                                        }
                                      },
                                      builder: (context, state) {
                                        return _buildEpisode(screenWidth,
                                            season.seasonNumber!, episode);
                                      },
                                    ),
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
              ),
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

  Widget _buildEpisode(
      double screenWidth, int numbSeason, List<Episode> episode) {
    return SizedBox(
      height: 350,
      width: screenWidth,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.read<TrailerEpisodeBloc>().add(FetchTrailerEpisode(
                  tvId: widget.id,
                  numbSeason: numbSeason,
                  numbEpisode: episode[index].episodeNumber!));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            buildCardImage(episode[index].stillPath!),
                            const Icon(
                              Icons.play_circle_outline,
                              size: 40,
                            ),
                          ],
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
                            'Episode ${episode[index].episodeNumber}',
                            // style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            '${episode[index].name}  ',
                            // style: TextStyle(fontSize: 10),
                          ),
                          showDuration(episode[index].runtime ?? 0),
                          buildRattingBar(episode[index].voteAverage!),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: episode.length,
      ),
    );
  }
}
