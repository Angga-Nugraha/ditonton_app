import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetWatchListTVStatus {
  final TvRepository repository;

  GetWatchListTVStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
