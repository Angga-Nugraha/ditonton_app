import 'dart:convert';

import 'package:core/entities/video.dart';
import 'package:equatable/equatable.dart';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel extends Equatable {
  final int id;
  final List<ResultModel> results;

  const VideoModel({
    required this.id,
    required this.results,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        results: List<ResultModel>.from(
            json["results"].map((x) => ResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  Video toEntity() => Video(
        id: id,
        results: results.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object> get props => [id, results];
}

class ResultModel extends Equatable {
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

  const ResultModel({
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

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        publishedAt: DateTime.parse(json["published_at"]),
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "published_at": publishedAt.toIso8601String(),
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "id": id,
      };

  Result toEntity() => Result(
      iso6391: iso6391,
      iso31661: iso31661,
      name: name,
      key: key,
      publishedAt: publishedAt,
      site: site,
      size: size,
      type: type,
      official: official,
      id: id);

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
