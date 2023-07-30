import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

final now = DateTime.now();
void main() {
  final kresultModel = ResultModel(
    iso6391: 'iso6391',
    iso31661: 'iso31661',
    name: 'name',
    key: 'key',
    publishedAt: now,
    site: 'site',
    size: 1,
    type: 'type',
    official: true,
    id: 'id',
  );
  final kVideoModel = VideoModel(id: 1, results: <ResultModel>[kresultModel]);

  final kResult = Result(
    iso6391: 'iso6391',
    iso31661: 'iso31661',
    name: 'name',
    key: 'key',
    publishedAt: now,
    site: 'site',
    size: 1,
    type: 'type',
    official: true,
    id: 'id',
  );

  final kVideo = Video(id: 1, results: <Result>[kResult]);

  test('should be a trailer of Movie entity', () {
    final result = kVideoModel.toEntity();
    expect(result, kVideo);
  });
}
