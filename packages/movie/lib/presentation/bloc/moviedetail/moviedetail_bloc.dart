import 'package:movie/domain/usecases/get_watchlist_status_movie.dart';
import 'package:movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'moviedetail_event.dart';
part 'moviedetail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatusMovie getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<MovieDetailDataWithIdEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));
      final detailResult = await getMovieDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(state: RequestState.error));
        },
        (movie) async {
          emit(state.copyWith(
            state: RequestState.loaded,
            movieDetail: movie,
          ));
        },
      );
    });
    on<AddWatchlistEvent>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatusEvent(event.movieDetail.id));
    });
    on<RemoveWatchlistEvent>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatusEvent(event.movieDetail.id));
    });
    on<LoadWatchlistStatusEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
