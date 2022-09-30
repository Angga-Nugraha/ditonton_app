import 'package:core/data/shared.dart';
import 'package:flutter_test/flutter_test.dart';

const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const BASE_URL = 'https://api.themoviedb.org/3';

void main() {
  test('Should get response 200 when success connect', () async {
    final client = await Shared.createLEClient(isTestMode: true);
    final responses =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    expect(responses.statusCode, 200);
    client.close();
  });
}
