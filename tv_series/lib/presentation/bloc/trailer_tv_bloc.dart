import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_trailer_tv.dart';

class TrailerTvBloc extends Bloc<TrailerTvEvent, TrailerTvState> {
  GetTrailerTv getTrailerTv;

  TrailerTvBloc({required this.getTrailerTv}) : super(TrailerTvEmpty()) {
    on<FetchTrailerTv>((event, emit) async {
      emit(TrailerTvLoading());

      final result = await getTrailerTv.execute(event.tvId);

      result.fold((failure) => emit(TrailerTvError(message: failure.message)),
          (data) => emit(TrailerTvHasData(result: data)));
    });
  }
}

// BLOC EVENT
abstract class TrailerTvEvent extends Equatable {
  const TrailerTvEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailerTv extends TrailerTvEvent {
  final int tvId;

  const FetchTrailerTv({required this.tvId});

  @override
  List<Object> get props => [tvId];
}

// BLOC STATE
class TrailerTvState extends Equatable {
  const TrailerTvState();

  @override
  List<Object> get props => [];
}

class TrailerTvEmpty extends TrailerTvState {}

class TrailerTvLoading extends TrailerTvState {}

class TrailerTvHasData extends TrailerTvState {
  final Video result;

  const TrailerTvHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class TrailerTvError extends TrailerTvState {
  final String message;

  const TrailerTvError({required this.message});

  @override
  List<Object> get props => [message];
}
