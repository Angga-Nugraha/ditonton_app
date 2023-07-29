import 'package:core/core.dart';
import 'package:tv_series/domain/entities/season_detail.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetSeasonTV {
  final TvRepository repository;

  GetSeasonTV(this.repository);
  Future<Either<Failure, SeasonDetail>> execute(int id, int numSeason) {
    return repository.getSeasonTv(id, numSeason);
  }
}
