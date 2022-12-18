import 'package:core/utils/exception.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('return success message when insert to database is success', () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tId = 1;

    test('return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tv', () {
    test('return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });

  group('cache now playing tv', () {
    test('call database helper to save data', () async {
      // arrange
      when(mockDatabaseHelper.clearCacheTv('now playing'))
          .thenAnswer((_) async => 1);
      // act
      await dataSource.cacheNowPlayingTv([testTvCache]);
      // assert
      verify(mockDatabaseHelper.clearCacheTv('now playing'));
      verify(mockDatabaseHelper
          .insertTvCacheTransaction([testTvCache], 'now playing'));
    });

    test('return list of Tv from db when data exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTv('now playing'))
          .thenAnswer((_) async => [testTvCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingTv();
      // assert
      expect(result, [testTvCache]);
    });

    test('throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockDatabaseHelper.getCacheTv('now playing'))
          .thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingTv();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
