import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/domain/usecase/search_tv.dart';

import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) => emit(
          SearchHashData(data),
        ),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

class SearchTVBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTv _searchTv;
  SearchTVBloc(this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) => emit(
          SearchHashDataTV(data),
        ),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
