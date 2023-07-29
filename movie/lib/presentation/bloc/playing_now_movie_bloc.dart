import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/movie.dart';

class PlayingNowMovieBloc
    extends Bloc<PlayingNowMovieEvent, PlayingNowMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  PlayingNowMovieBloc({required this.getNowPlayingMovies})
      : super(PlayingNowMovieListEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(PlayingNowMovieListLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(PlayingNowMovieListError(failure.message)),
        (data) => emit(PlayingNowMovieListHasData(result: data)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

// state bloc
abstract class PlayingNowMovieState extends Equatable {
  const PlayingNowMovieState();

  @override
  List<Object?> get props => [];
}

class PlayingNowMovieListEmpty extends PlayingNowMovieState {}

class PlayingNowMovieListLoading extends PlayingNowMovieState {}

class PlayingNowMovieListError extends PlayingNowMovieState {
  final String message;
  const PlayingNowMovieListError(this.message);

  @override
  List<Object> get props => [message];
}

class PlayingNowMovieListHasData extends PlayingNowMovieState {
  final List<Movie> result;

  const PlayingNowMovieListHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class PlayingNowMovieEvent extends Equatable {
  const PlayingNowMovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchNowPlayingMovies extends PlayingNowMovieEvent {}
