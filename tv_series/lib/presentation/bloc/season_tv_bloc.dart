import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

class SeasonTVBloc extends Bloc<SeasonTVEvent, SeasonTVState> {
  final GetSeasonTV getTVSeason;

  SeasonTVBloc({required this.getTVSeason}) : super(SeasonTVEmpty()) {
    on<FetchSeasonTV>(
      (event, emit) async {
        final id = event.id;
        final numSeason = event.numSeason;
        emit(SeasonTVLoading());
        final result = await getTVSeason.execute(id, numSeason);

        result.fold(
          (failure) => emit(SeasonTVError(failure.message)),
          (data) => emit(SeasonTVHasData(result: data)),
        );
      },
    );
  }
}

// state bloc
abstract class SeasonTVState extends Equatable {
  const SeasonTVState();

  @override
  List<Object?> get props => [];
}

class SeasonTVEmpty extends SeasonTVState {}

class SeasonTVLoading extends SeasonTVState {}

class SeasonTVError extends SeasonTVState {
  final String message;
  const SeasonTVError(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonTVHasData extends SeasonTVState {
  final SeasonDetail result;

  const SeasonTVHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class SeasonTVEvent extends Equatable {
  const SeasonTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchSeasonTV extends SeasonTVEvent {
  final int id;
  final int numSeason;
  const FetchSeasonTV(this.id, this.numSeason);

  @override
  List<Object> get props => [id];
}
