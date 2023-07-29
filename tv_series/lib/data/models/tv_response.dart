import 'tv_model.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvList;

  const TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from((json["results"] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) =>
                element.posterPath != null &&
                element.backdropPath != null &&
                element.originalLanguage != null &&
                element.originalLanguage != null &&
                element.originalName != null &&
                element.overview != null &&
                element.popularity != null &&
                element.posterPath != null &&
                element.voteAverage != null &&
                element.voteCount != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvList];
}
