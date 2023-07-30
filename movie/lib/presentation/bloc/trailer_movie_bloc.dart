import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/get_video_trailer_movie.dart';

class TrailerMovieBloc extends Bloc<TrailerMovieEvent, TrailerMovieState> {
  GetTrailerMovie getTrailerMovie;

  TrailerMovieBloc({required this.getTrailerMovie})
      : super(TrailerMovieEmpty()) {
    on<FetchTrailerMovie>((event, emit) async {
      emit(TrailerMovieLoading());

      final result = await getTrailerMovie.execute(event.movieid);

      result.fold(
          (failure) => emit(TrailerMovieError(message: failure.message)),
          (data) => emit(TrailerMovieHasData(result: data)));
    });
  }
}

// BLOC EVENT
abstract class TrailerMovieEvent extends Equatable {
  const TrailerMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailerMovie extends TrailerMovieEvent {
  final int movieid;

  const FetchTrailerMovie({required this.movieid});

  @override
  List<Object> get props => [movieid];
}

// BLOC STATE
class TrailerMovieState extends Equatable {
  const TrailerMovieState();

  @override
  List<Object> get props => [];
}

class TrailerMovieEmpty extends TrailerMovieState {}

class TrailerMovieLoading extends TrailerMovieState {}

class TrailerMovieHasData extends TrailerMovieState {
  final Video result;

  const TrailerMovieHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class TrailerMovieError extends TrailerMovieState {
  final String message;

  const TrailerMovieError({required this.message});

  @override
  List<Object> get props => [message];
}
