import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

final tv = Tv(
    backdropPath: "backdropPath",
    genreIds: const [1, 2, 3],
    id: 1,
    name: "name",
    originCountry: const ["originalCountry"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    voteAverage: 1.0,
    voteCount: 1);

final testTVList = <Tv>[tv];

final testWatchlistTV = Tv.watchList(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTVTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTVDetail = TvDetail(
    seasons: [
      Season(
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1),
    ],
    adult: false,
    backdropPath: 'backdropPath',
    episodeRunTime: [60],
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'name',
    numberOfEpisodes: 8,
    numberOfSeasons: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 6073.331,
    posterPath: 'posterPath',
    voteAverage: 7.562,
    voteCount: 623);

const seasonDetail = SeasonDetail(
    id: '1',
    episodes: [
      Episode(
          episodeNumber: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          runtime: 1,
          seasonNumber: 1,
          showId: 1,
          stillPath: 'stillPath',
          voteAverage: 1.0,
          voteCount: 1),
    ],
    name: 'name',
    overview: 'overview',
    seasonDetailId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1);
