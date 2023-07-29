import 'package:core/data/shared.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should get response 200 when success connect', () async {
    final client = await Shared.createLEClient(isTestMode: true);
    final responses =
        await client.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

    expect(responses.statusCode, 200);
    client.close();
  });
}
