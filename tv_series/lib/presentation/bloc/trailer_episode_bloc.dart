import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_trailer_episode.dart';

class TrailerEpisodeBloc
    extends Bloc<TrailerEpisodeEvent, TrailerEpisodeState> {
  GetTrailerEpisode getTrailerEpisode;

  TrailerEpisodeBloc({required this.getTrailerEpisode})
      : super(TrailerEpisodeEmpty()) {
    on<FetchTrailerEpisode>((event, emit) async {
      emit(TrailerEpisodeLoading());

      final result = await getTrailerEpisode.execute(
          event.tvId, event.numbSeason, event.numbEpisode);

      result.fold(
          (failure) => emit(TrailerEpisodeError(message: failure.message)),
          (data) => emit(TrailerEpisodeHasData(result: data)));
    });
  }
}

// BLOC EVENT
abstract class TrailerEpisodeEvent extends Equatable {
  const TrailerEpisodeEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailerEpisode extends TrailerEpisodeEvent {
  final int tvId;
  final int numbSeason;
  final int numbEpisode;

  const FetchTrailerEpisode(
      {required this.tvId,
      required this.numbSeason,
      required this.numbEpisode});

  @override
  List<Object> get props => [tvId, numbSeason, numbEpisode];
}

// BLOC STATE
class TrailerEpisodeState extends Equatable {
  const TrailerEpisodeState();

  @override
  List<Object> get props => [];
}

class TrailerEpisodeEmpty extends TrailerEpisodeState {}

class TrailerEpisodeLoading extends TrailerEpisodeState {}

class TrailerEpisodeHasData extends TrailerEpisodeState {
  final Video result;

  const TrailerEpisodeHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class TrailerEpisodeError extends TrailerEpisodeState {
  final String message;

  const TrailerEpisodeError({required this.message});

  @override
  List<Object> get props => [message];
}
