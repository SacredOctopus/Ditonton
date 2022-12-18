import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('return a model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/movie_detail.json'));
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, testMovieDetailResponse);
    });
  });

  group('toJson', () {
    test('return a JSON map containing data', () async {
      // arrange

      // act
      final result = testMovieDetailResponse.toJson();

      // assert
      expect(result, testMovieDetailResponseMap);
    });
  });
}
