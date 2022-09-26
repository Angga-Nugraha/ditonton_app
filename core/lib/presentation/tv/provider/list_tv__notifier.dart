import 'package:core/core.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_now_playing_on_air_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TVListNotifier extends ChangeNotifier {
  var _nowPlayingOnAirTV = <Tv>[];
  List<Tv> get nowPlayingOnAirTV => _nowPlayingOnAirTV;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTV = <Tv>[];
  List<Tv> get popularTV => _popularTV;

  RequestState _popularTVState = RequestState.Empty;
  RequestState get popularTVState => _popularTVState;

  var _topRatedTV = <Tv>[];
  List<Tv> get topRatedTV => _topRatedTV;

  RequestState _topRatedTVState = RequestState.Empty;
  RequestState get topRatedTVState => _topRatedTVState;

  String _message = '';
  String get message => _message;

  TVListNotifier({
    required this.getNowPlayingTV,
    required this.getPopularTV,
    required this.getTopRatedTV,
  });

  final GetNowPlayingTv getNowPlayingTV;
  final GetPopularTv getPopularTV;
  final GetTopRatedTv getTopRatedTV;

  Future<void> fetchNowPlayingOnAirTV() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTV.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingOnAirTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTV() async {
    _popularTVState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        _popularTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTVState = RequestState.Loaded;
        _popularTV = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTV() async {
    _topRatedTVState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        _topRatedTVState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTVState = RequestState.Loaded;
        _topRatedTV = tvData;
        notifyListeners();
      },
    );
  }
}
