import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final int id;
  final List<Result> results;

  const Video({
    required this.id,
    required this.results,
  });

  @override
  List<Object> get props => [id, results];
}

class Result extends Equatable {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final DateTime publishedAt;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String id;

  const Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.publishedAt,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.id,
  });

  @override
  List<Object?> get props => [
        iso31661,
        iso31661,
        name,
        key,
        publishedAt,
        site,
        size,
        type,
        official,
        id,
      ];
}
