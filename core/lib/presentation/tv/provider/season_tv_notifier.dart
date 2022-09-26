import 'package:core/core.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/usecases/get_season_tv.dart';
import 'package:flutter/cupertino.dart';

class SeasonTVNotifier extends ChangeNotifier {
  final GetSeasonTV seasonTV;

  SeasonTVNotifier({required this.seasonTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  late SeasonDetail _seasonResult;
  SeasonDetail get season => _seasonResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeason(int id, int numSeason) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await seasonTV.execute(id, numSeason);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _seasonResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
