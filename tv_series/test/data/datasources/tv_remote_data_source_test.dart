// import 'dart:convert';

// import 'package:core/core.dart';
// import 'package:tv_series/data/datasources/tv_remote_data_source.dart';
// import 'package:tv_series/data/models/tv_response.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;

// import '../../helpers/test_helper.mocks.dart';
// import '../../json_reader.dart';

// void main() {
//   const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
//   const BASE_URL = 'https://api.themoviedb.org/3';

//   late TVRemoteDataSourceImpl dataSource;
//   late MockHttpClient mockHttpClient;

//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
//   });

//   // group('get Now Playing TV', () {
//   //   final tvList =
//   //       TvResponse.fromJson(json.decode(readJson('data/now_on_air_tv.json')))
//   //           .tvList;

//   //   test('should return list of TV Model when the response code is 200',
//   //       () async {
//   //     // arrange
//   //     when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
//   //         .thenAnswer((_) async =>
//   //             http.Response(readJson('data/now_on_air_tv.json'), 200));
//   //     // act
//   //     final result = await dataSource.getNowPlayingTv();
//   //     // assert
//   //     expect(result, equals(tvList));
//   //   });

//   test('should throw a ServerException when the response code is 404 or other',
//       () async {
//     // arrange
//     when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
//         .thenAnswer((_) async => http.Response('Not Found', 404));
//     // act
//     final call = dataSource.getNowPlayingTv();
//     // assert
//     expect(() => call, throwsA(isA<ServerException>()));
//   });
//   // });

//   group('get Popular TV', () {
//     final tvList =
//         TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
//             .tvList;

//     test('should return list of tv when response is success (200)', () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
//           .thenAnswer((_) async =>
//               http.Response(readJson('dummy_data/tv_popular.json'), 200));
//       // act
//       final result = await dataSource.getPopularTv();
//       // assert
//       expect(result, tvList);
//     });

//     test(
//         'should throw a ServerException when the response code is 404 or other',
//         () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       // act
//       final call = dataSource.getPopularTv();
//       // assert
//       expect(() => call, throwsA(isA<ServerException>()));
//     });
//   });

//   group('get Top Rated TV', () {
//     final tvList = TvResponse.fromJson(
//             json.decode(readJson('dummy_data/tv_top_rated.json')))
//         .tvList;

//     test('should return list of TV when response code is 200 ', () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
//           .thenAnswer((_) async =>
//               http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
//       // act
//       final result = await dataSource.getTopRatedTv();
//       // assert
//       expect(result, tvList);
//     });

//     test('should throw ServerException when response code is other than 200',
//         () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       // act
//       final call = dataSource.getTopRatedTv();
//       // assert
//       expect(() => call, throwsA(isA<ServerException>()));
//     });
//   });

//   group('get tv detail', () {
//     const tId = 1;

//     test('should throw Server Exception when the response code is 404 or other',
//         () async {
//       // arrange
//       when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       // act
//       final call = dataSource.getTvDetail(tId);
//       // assert
//       expect(() => call, throwsA(isA<ServerException>()));
//     });
//   });

//   group('get tv recommendations', () {
//     final tvList = TvResponse.fromJson(
//             json.decode(readJson('dummy_data/tv_recommendations.json')))
//         .tvList;
//     const tId = 1;

//     test('should return list of tv Model when the response code is 200',
//         () async {
//       // arrange
//       when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
//           .thenAnswer((_) async => http.Response(
//               readJson('dummy_data/tv_recommendations.json'), 200));
//       // act
//       final result = await dataSource.getTvRecommendations(tId);
//       // assert
//       expect(result, equals(tvList));
//     });

//     test('should throw Server Exception when the response code is 404 or other',
//         () async {
//       // arrange
//       when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       // act
//       final call = dataSource.getTvRecommendations(tId);
//       // assert
//       expect(() => call, throwsA(isA<ServerException>()));
//     });
//   });

//   group('search TV Series', () {
//     final tSearchResult =
//         TvResponse.fromJson(json.decode(readJson('dummy_data/search_tv.json')))
//             .tvList;
//     const tQuery = 'the lord';

//     test('should return list of tv when response code is 200', () async {
//       // arrange
//       when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
//           .thenAnswer((_) async =>
//               http.Response(readJson('dummy_data/search_tv.json'), 200));
//       // act
//       final result = await dataSource.searchTv(tQuery);
//       // assert
//       expect(result, tSearchResult);
//     });

//     test('should throw ServerException when response code is other than 200',
//         () async {
//       // arrange
//       when(mockHttpClient
//               .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       // act
//       final call = dataSource.searchTv(tQuery);
//       // assert
//       expect(() => call, throwsA(isA<ServerException>()));
//     });
//   });
// }
