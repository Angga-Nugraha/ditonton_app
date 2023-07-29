import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:rxdart/rxdart.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations getMovieRecommendations;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  RecommendationMovieBloc({required this.getMovieRecommendations})
      : super(RecommendationMovieEmpty()) {
    on<FetchRecommendationMovie>(
      (event, emit) async {
        final id = event.id;
        emit(RecommendationMovieLoading());
        final result = await getMovieRecommendations.execute(id);

        result.fold(
          (failure) => emit(RecommendationMovieError(failure.message)),
          (data) => emit(RecommendationMovieHasData(result: data)),
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

// state bloc
abstract class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object?> get props => [];
}

class RecommendationMovieEmpty extends RecommendationMovieState {}

class RecommendationMovieLoading extends RecommendationMovieState {}

class RecommendationMovieError extends RecommendationMovieState {
  final String message;
  const RecommendationMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMovieHasData extends RecommendationMovieState {
  final List<Movie> result;

  const RecommendationMovieHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class RecommendationMovieEvent extends Equatable {
  const RecommendationMovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecommendationMovie extends RecommendationMovieEvent {
  final int id;
  const FetchRecommendationMovie(this.id);

  @override
  List<Object> get props => [id];
}
