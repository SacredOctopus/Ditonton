import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv _getNowPlayingTv;

  TvBloc(this._getNowPlayingTv) : super(EmptyData()) {
    on<TvDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getNowPlayingTv.execute();

      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv _getPopularTv;
  PopularTvBloc(this._getPopularTv) : super(EmptyData()) {
    on<TvDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getPopularTv.execute();

      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv _getTopRatedTv;
  TopRatedTvBloc(this._getTopRatedTv) : super(EmptyData()) {
    on<TvDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedTv.execute();

      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class RecommendationTvBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(
    this._getTvRecommendations,
  ) : super(EmptyData()) {
    on<TvDataWithIdEvent>((event, emit) async {
      final id = event.id;
      emit(Loading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}

class WatchlistTvBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTv _getWatchlistTv;
  WatchlistTvBloc(this._getWatchlistTv) : super(EmptyData()) {
    on<TvDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(LoadedData(data));
        },
      );
    });
  }
}
