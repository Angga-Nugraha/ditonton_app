import 'dart:convert';
import 'package:core/core.dart';
import 'package:http/http.dart' as http;

import 'package:tv_series/data/models/season_detail_model.dart';
import 'package:tv_series/data/models/tv_detail_model.dart';
import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/data/models/tv_response.dart';

abstract class TVRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTv();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRatedTv();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTv(String query);
  Future<SeasonDetailModel> getSeasonTv(int id, int numSeason);
  Future<VideoModel> getTrailerTv(int tvId);
  Future<VideoModel> getTrailerEpisode(
      int tvId, int numbSeason, int numbEpisode);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int? id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getSeasonTv(int id, int numSeason) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/season/$numSeason?$apiKey'));
    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VideoModel> getTrailerTv(int tvId) async {
    final response =
        await client.get(Uri.parse("$baseUrl/tv/$tvId/videos?$apiKey"));

    if (response.statusCode == 200) {
      return VideoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VideoModel> getTrailerEpisode(
      int tvId, int numbSeason, int numbEpisode) async {
    final response = await client.get(Uri.parse(
        "$baseUrl/tv/$tvId/season/$numbSeason/episode/$numbEpisode/videos?$apiKey"));
    if (response.statusCode == 200) {
      return VideoModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
