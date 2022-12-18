import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieBloc(this._getNowPlayingMovies) : super(EmptyData()) {
    on<MoviesDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getNowPlayingMovies.execute();

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

class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(EmptyData()) {
    on<MoviesDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getPopularMovies.execute();

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

class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieBloc(this._getTopRatedMovies) : super(EmptyData()) {
    on<MoviesDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedMovies.execute();

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

class RecommendationMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesBloc(
    this._getMovieRecommendations,
  ) : super(EmptyData()) {
    on<MovieDataWithIdEvent>((event, emit) async {
      final id = event.id;
      emit(Loading());
      final result = await _getMovieRecommendations.execute(id);

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

class WatchlistMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(this._getWatchlistMovies) : super(EmptyData()) {
    on<MoviesDataEvent>((event, emit) async {
      emit(Loading());
      final result = await _getWatchlistMovies.execute();

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
