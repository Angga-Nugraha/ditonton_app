import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class WatchlistTVBloc extends Bloc<WatchlistTVEvent, WatchlistTVState> {
  GetWatchlistTv getWatchlistTVs;

  WatchlistTVBloc({required this.getWatchlistTVs}) : super(WatchlistTVEmpty()) {
    on<FetchTVWatchlist>((event, emit) async {
      emit(WatchlistTVLoading());
      final result = await getWatchlistTVs.execute();
      result.fold(
        (failure) => emit(WatchlistTVError(failure.message)),
        (data) => emit(WatchlistTVHasData(data)),
      );
    });
  }
}

// event bloc
abstract class WatchlistTVEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTVWatchlist extends WatchlistTVEvent {}

// state bloc
abstract class WatchlistTVState extends Equatable {
  const WatchlistTVState();

  @override
  List<Object?> get props => [];
}

class WatchlistTVEmpty extends WatchlistTVState {}

class WatchlistTVLoading extends WatchlistTVState {}

class WatchlistTVError extends WatchlistTVState {
  final String message;
  const WatchlistTVError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTVHasData extends WatchlistTVState {
  final List<Tv> result;
  const WatchlistTVHasData(this.result);

  @override
  List<Object> get props => [result];
}
