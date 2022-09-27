import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

import '../../domain/entities/movie.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc({required this.getPopularMovies})
      : super(PopularMovieListEmpty()) {
    on<FetchPopularMovies>(
      (event, emit) async {
        emit(PopularMovieLoading());
        final result = await getPopularMovies.execute();

        result.fold(
          (failure) => emit(PopularMovieError(failure.message)),
          (data) => emit(PopularMovieHasData(result: data)),
        );
      },
    );
  }
}

// state bloc
abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object?> get props => [];
}

class PopularMovieListEmpty extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieError extends PopularMovieState {
  final String message;
  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieHasData extends PopularMovieState {
  final List<Movie> result;

  const PopularMovieHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularMovies extends PopularMovieEvent {}
