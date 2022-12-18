import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('toJson', () {
    test('return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvCache.toJson();

      // assert
      expect(result, testTvCacheMap);
    });
  });
}
