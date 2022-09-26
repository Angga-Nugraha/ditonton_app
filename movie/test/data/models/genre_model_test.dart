import 'package:movie/data/models/genre_model.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const genreModel = GenreModel(id: 1, name: 'name');
  const genre = Genre(id: 1, name: 'name');

  test('should be a subclass of TV Series entity', () async {
    final result = genreModel.toEntity();
    expect(result, genre);
  });
}
