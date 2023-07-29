import 'package:core/data/shared.dart';
import 'package:flutter_test/flutter_test.dart';

const apiKey = 'apiKey=2174d146bb9c0eab47529b2e77d6b526';
const baseUrl = 'https://api.themoviedb.org/3';

void main() {
  test('Should get response 200 when success connect', () async {
    final client = await Shared.createLEClient(isTestMode: true);
    final responses =
        await client.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

    expect(responses.statusCode, 200);
    client.close();
  });
}
