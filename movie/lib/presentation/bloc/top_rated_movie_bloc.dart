import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

import '../../domain/entities/movie.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc({required this.getTopRatedMovies})
      : super(TopRatedMovieListEmpty()) {
    on<FetchTopRatedMovies>(
      (event, emit) async {
        emit(TopRatedMovieListLoading());
        final result = await getTopRatedMovies.execute();

        result.fold(
          (failure) => emit(TopRatedMovieListError(failure.message)),
          (data) => emit(TopRatedMovieListHasData(result: data)),
        );
      },
    );
  }
}

// state bloc
abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object?> get props => [];
}

class TopRatedMovieListEmpty extends TopRatedMovieState {}

class TopRatedMovieListLoading extends TopRatedMovieState {}

class TopRatedMovieListError extends TopRatedMovieState {
  final String message;
  const TopRatedMovieListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieListHasData extends TopRatedMovieState {
  final List<Movie> result;

  const TopRatedMovieListHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopRatedMovies extends TopRatedMovieEvent {}
