import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_now_playing_on_air_tv.dart';

class PlayingNowTVBloc extends Bloc<PlayingNowTVEvent, PlayingNowTVState> {
  final GetNowPlayingTv getNowPlayingTv;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  PlayingNowTVBloc(this.getNowPlayingTv) : super(PlayingNowTVEmpty()) {
    on<FetchNowPlayingTV>((event, emit) async {
      emit(PlayingNowTVLoading());
      final result = await getNowPlayingTv.execute();

      result.fold((failure) => emit(PlayingNowTVError(failure.message)),
          (data) => emit(PlayingNowTVHasData(data)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

// bloc event
abstract class PlayingNowTVEvent extends Equatable {
  const PlayingNowTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingTV extends PlayingNowTVEvent {}

// bloc state
abstract class PlayingNowTVState extends Equatable {
  const PlayingNowTVState();

  @override
  List<Object?> get props => [];
}

class PlayingNowTVEmpty extends PlayingNowTVState {}

class PlayingNowTVLoading extends PlayingNowTVState {}

class PlayingNowTVError extends PlayingNowTVState {
  final String message;
  const PlayingNowTVError(this.message);

  @override
  List<Object?> get props => [message];
}

class PlayingNowTVHasData extends PlayingNowTVState {
  final List<Tv> result;

  const PlayingNowTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}
