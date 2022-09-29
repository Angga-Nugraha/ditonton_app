import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTv getPopularTv;

  PopularTVBloc(this.getPopularTv) : super(PopularTVEmpty()) {
    on<FetchPopularTV>((event, emit) async {
      emit(PopularTVLoading());

      final result = await getPopularTv.execute();
      result.fold(
        (failure) => emit(PopularTVError(failure.message)),
        (data) => emit(PopularTVHasData(data)),
      );
    });
  }
}

// bloc event
abstract class PopularTVEvent extends Equatable {
  const PopularTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularTV extends PopularTVEvent {}

// bloc state
abstract class PopularTVState extends Equatable {
  const PopularTVState();

  @override
  List<Object?> get props => [];
}

class PopularTVEmpty extends PopularTVState {}

class PopularTVLoading extends PopularTVState {}

class PopularTVHasData extends PopularTVState {
  final List<Tv> result;

  const PopularTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularTVError extends PopularTVState {
  final String message;
  const PopularTVError(this.message);

  @override
  List<Object?> get props => [message];
}
