import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_model.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_detail.json'));
      // act
      final result = TvDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTvDetailResponse.toJson();

      // assert
      expect(result, testTvDetailResponseMap);
    });
  });
}
