import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListTVStatus getWatchListTVStatus;
  final SaveWatchlistTV saveWatchlistTV;
  final RemoveWatchlistTV removeWatchlistTV;

  WatchlistBloc({
    required this.getWatchListStatus,
    required this.getWatchListTVStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.saveWatchlistTV,
    required this.removeWatchlistTV,
  }) : super(const WatchlistInitial(value: false)) {
    on<LoadWatchlistStatus>((event, emit) async {
      final id = event.id;

      final result = await getWatchListStatus.execute(id);

      emit(WatchlistHasData(result));
    });

    on<LoadWatchlistTVStatus>((event, emit) async {
      final id = event.id;

      final result = await getWatchListTVStatus.execute(id);

      emit(WatchlistHasData(result));
    });

    on<AddMovieWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await saveWatchlist.execute(movie);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')),
      );

      add(LoadWatchlistStatus(movie.id));
    });

    on<DeleteMovieWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) =>
            emit(const WatchlistSuccess('Removed from Watchlist')),
      );
      add(LoadWatchlistStatus(movie.id));
    });

    on<AddTvWatchlist>((event, emit) async {
      final tv = event.tv;

      final result = await saveWatchlistTV.execute(tv);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')),
      );

      add(LoadWatchlistTVStatus(tv.id));
    });

    on<DeleteTvWatchlist>((event, emit) async {
      final tv = event.tv;

      final result = await removeWatchlistTV.execute(tv);
      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) =>
            emit(const WatchlistSuccess('Removed from Watchlist')),
      );
      add(LoadWatchlistTVStatus(tv.id));
    });
  }
}
