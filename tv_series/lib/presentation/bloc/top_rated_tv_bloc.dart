import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTVBloc(this.getTopRatedTv) : super(TopRatedTVEmpty()) {
    on<FetchTopRatedTV>((event, emit) async {
      emit(TopRatedTVLoading());

      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) => emit(TopRatedTVError(failure.message)),
        (data) => emit(TopRatedTVHasData(data)),
      );
    });
  }
}

// bloc event
abstract class TopRatedTVEvent extends Equatable {
  const TopRatedTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopRatedTV extends TopRatedTVEvent {}

// bloc state
abstract class TopRatedTVState extends Equatable {
  const TopRatedTVState();

  @override
  List<Object?> get props => [];
}

class TopRatedTVEmpty extends TopRatedTVState {}

class TopRatedTVLoading extends TopRatedTVState {}

class TopRatedTVHasData extends TopRatedTVState {
  final List<Tv> result;

  const TopRatedTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TopRatedTVError extends TopRatedTVState {
  final String message;
  const TopRatedTVError(this.message);

  @override
  List<Object?> get props => [message];
}
