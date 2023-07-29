import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovieDetail;

  DetailMovieBloc({required this.getMovieDetail}) : super(DetailMovieEmpty()) {
    on<FetchDetailMovie>(
      (event, emit) async {
        final id = event.id;
        emit(DetailMovieLoading());
        final result = await getMovieDetail.execute(id);

        result.fold(
          (failure) => emit(DetailMovieError(failure.message)),
          (data) => emit(DetailMovieHasData(result: data)),
        );
      },
    );
  }
}

// state bloc
abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object?> get props => [];
}

class DetailMovieEmpty extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieError extends DetailMovieState {
  final String message;
  const DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailMovieHasData extends DetailMovieState {
  final MovieDetail result;

  const DetailMovieHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;
  const FetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}
