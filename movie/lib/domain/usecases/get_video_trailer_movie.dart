import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class GetTrailerMovie {
  MovieRepository movieRepository;

  GetTrailerMovie({required this.movieRepository});

  Future<Either<Failure, Video>> execute(int movieId) async {
    return movieRepository.getTrailerMovies(movieId);
  }
}
