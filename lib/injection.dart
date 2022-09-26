import 'package:core/data/ssl_pinning.dart';
import 'package:get_it/get_it.dart';

import 'package:core/presentation/movie/provider/movie_detail_notifier.dart';
import 'package:core/presentation/movie/provider/movie_list_notifier.dart';
import 'package:core/presentation/movie/provider/popular_movies_notifier.dart';
import 'package:core/presentation/movie/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/movie/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/tv/provider/detail_tv_notifier.dart';
import 'package:core/presentation/tv/provider/list_tv__notifier.dart';
import 'package:core/presentation/tv/provider/popular_tv_notifier.dart';
import 'package:core/presentation/tv/provider/season_tv_notifier.dart';
import 'package:core/presentation/tv/provider/top_rated_tv_notifier.dart';
import 'package:core/presentation/tv/provider/watchlist_tv_notifier.dart';

import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTVBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => SeasonTVNotifier(seasonTV: locator()),
  );

  // provider tv
  locator.registerFactory(
    () => TVListNotifier(
      getNowPlayingTV: locator(),
      getPopularTV: locator(),
      getTopRatedTV: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTVNotifier(locator()),
  );
  locator.registerLazySingleton(
    () => TVDetailNotifier(
        getTvDetail: locator(),
        getTvRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator()),
  );
  locator.registerFactory(
    () => TopRatedTVNotifier(
      getTopRatedTv: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTVNotifier(
      getWatchlistTv: locator(),
    ),
  );
  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // use case tv
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTVStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetSeasonTV(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  // movie
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // tv
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
