import 'dart:convert';

import 'package:movie/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('return a model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = MovieResponse.fromJson(jsonMap);
      // assert
      expect(result, testMovieResponseModel);
    });
  });

  group('toJson', () {
    test('return a JSON map containing data', () async {
      // arrange

      // act
      final result = testMovieResponseModel.toJson();
      // assert

      expect(result, testMovieResponseModelMap);
    });
  });
}
