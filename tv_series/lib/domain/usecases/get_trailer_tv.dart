import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetTrailerTv {
  TvRepository tvRepository;

  GetTrailerTv(this.tvRepository);

  Future<Either<Failure, Video>> execute(int tvId) async {
    return tvRepository.getTrailerTv(tvId);
  }
}
