import 'package:get_it/get_it.dart';

import 'package:core/data/ssl_pinning.dart';
import 'package:core/presentation/bloc/watchlist_bloc.dart';

import 'package:movie/presentation/bloc/detail_movie_bloc.dart';
import 'package:movie/presentation/bloc/playing_now_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';

import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/presentation/provider/detail_tv_notifier.dart';
import 'package:tv_series/presentation/provider/list_tv__notifier.dart';
import 'package:tv_series/presentation/provider/popular_tv_notifier.dart';
import 'package:tv_series/presentation/provider/season_tv_notifier.dart';
import 'package:tv_series/presentation/provider/top_rated_tv_notifier.dart';
import 'package:tv_series/presentation/provider/watchlist_tv_notifier.dart';
import 'package:tv_series/tv_series.dart';

final locator = GetIt.instance;

void init() {
  // provider movie
  locator.registerFactory(
    () => PlayingNowMovieBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMovieBloc(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistBloc(
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
      removeWatchlistTV: locator(),
      saveWatchlistTV: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
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
