import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:core/utils/exception.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
  Future<void> cacheNowPlayingTv(List<TvTable> tv);
  Future<List<TvTable>> getCachedNowPlayingTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheNowPlayingTv(List<TvTable> tv) async {
    await databaseHelper.clearCacheTv('now playing');
    await databaseHelper.insertTvCacheTransaction(tv, 'now playing');
  }

  @override
  Future<List<TvTable>> getCachedNowPlayingTv() async {
    final result = await databaseHelper.getCacheTv('now playing');
    if (result.isNotEmpty) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data");
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
