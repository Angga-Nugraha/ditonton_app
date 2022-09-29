import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

class RecommendationTVBloc
    extends Bloc<RecommendationTVEvent, RecommendationTVState> {
  final GetTvRecommendations getTVRecommendation;

  RecommendationTVBloc({required this.getTVRecommendation})
      : super(RecommendationTVEmpty()) {
    on<FetchRecommendationTV>(
      (event, emit) async {
        final id = event.id;
        emit(RecommendationTVLoading());
        final result = await getTVRecommendation.execute(id);

        result.fold(
          (failure) => emit(RecommendationTVError(failure.message)),
          (data) => emit(RecommendationTVHasData(result: data)),
        );
      },
    );
  }
}

// state bloc
abstract class RecommendationTVState extends Equatable {
  const RecommendationTVState();

  @override
  List<Object?> get props => [];
}

class RecommendationTVEmpty extends RecommendationTVState {}

class RecommendationTVLoading extends RecommendationTVState {}

class RecommendationTVError extends RecommendationTVState {
  final String message;
  const RecommendationTVError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationTVHasData extends RecommendationTVState {
  final List<Tv> result;

  const RecommendationTVHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class RecommendationTVEvent extends Equatable {
  const RecommendationTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchRecommendationTV extends RecommendationTVEvent {
  final int id;
  const FetchRecommendationTV(this.id);

  @override
  List<Object> get props => [id];
}
