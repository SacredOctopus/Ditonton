import 'dart:convert';

import 'package:tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvResponseModel.toJson();

      // assert
      expect(result, testTvResponseModelMap);
    });
  });
}
