import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

final tv = Tv(
    backdropPath: "/pdfCr8W0wBCpdjbZXSxnKhZtosP.jpg",
    genreIds: const [10765, 10759, 18],
    id: 84773,
    name: "The Lord of the Rings: The Rings of Power",
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "The Lord of the Rings: The Rings of Power",
    overview:
        "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
    popularity: 5975.998,
    posterPath: "/suyNxglk17Cpk8rCM2kZgqKdftk.jpg",
    voteAverage: 7.6,
    voteCount: 593);

final testTVList = [tv];

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
