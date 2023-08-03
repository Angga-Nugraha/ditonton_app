import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetTrailerEpisode {
  TvRepository tvRepository;

  GetTrailerEpisode(this.tvRepository);

  Future<Either<Failure, Video>> execute(
      int tvId, int numbSeason, int numbEpisode) async {
    return tvRepository.getTrailerEpisode(tvId, numbSeason, numbEpisode);
  }
}
