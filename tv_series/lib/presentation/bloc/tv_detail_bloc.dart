import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';

class DetailTVBloc extends Bloc<DetailTVEvent, DetailTVState> {
  final GetTvDetail getTVDetail;

  DetailTVBloc({required this.getTVDetail}) : super(DetailTVEmpty()) {
    on<FetchDetailTV>(
      (event, emit) async {
        final id = event.id;
        emit(DetailTVLoading());
        final result = await getTVDetail.execute(id);

        result.fold(
          (failure) => emit(DetailTVError(failure.message)),
          (data) => emit(DetailTVHasData(result: data)),
        );
      },
    );
  }
}

// state bloc
abstract class DetailTVState extends Equatable {
  const DetailTVState();

  @override
  List<Object?> get props => [];
}

class DetailTVEmpty extends DetailTVState {}

class DetailTVLoading extends DetailTVState {}

class DetailTVError extends DetailTVState {
  final String message;
  const DetailTVError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTVHasData extends DetailTVState {
  final TvDetail result;

  const DetailTVHasData({required this.result});

  @override
  List<Object> get props => [result];
}

// event bloc
abstract class DetailTVEvent extends Equatable {
  const DetailTVEvent();

  @override
  List<Object?> get props => [];
}

class FetchDetailTV extends DetailTVEvent {
  final int id;
  const FetchDetailTV(this.id);

  @override
  List<Object> get props => [id];
}
