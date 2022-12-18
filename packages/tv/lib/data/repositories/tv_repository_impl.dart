import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/network_info.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowPlayingTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingTv();
        localDataSource.cacheNowPlayingTv(
            result.map((tv) => TvTable.fromDTO(tv)).toList());
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure(''));
      } on TlsException {
        return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedNowPlayingTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
