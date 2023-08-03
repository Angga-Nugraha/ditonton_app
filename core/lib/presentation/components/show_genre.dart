part of 'components_helper.dart';

Widget showGenres(List<dynamic> genres) {
  String result = '';
  for (var genre in genres) {
    result += '${genre.name}, ';
  }

  if (result.isEmpty) {
    return const Text('');
  }

  return Text(result.substring(0, result.length - 2));
}
