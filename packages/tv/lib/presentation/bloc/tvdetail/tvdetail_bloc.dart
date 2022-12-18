import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'tvdetail_event.dart';
part 'tvdetail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailBloc({
    required this.getTvDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailState.initial()) {
    on<TvDetailDataWithIdEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));
      final detailResult = await getTvDetail.execute(event.id);

      detailResult.fold(
        (failure) async {
          emit(state.copyWith(state: RequestState.error));
        },
        (tv) async {
          emit(state.copyWith(
            tvDetail: tv,
            state: RequestState.loaded,
          ));
        },
      );
    });
    on<AddWatchlistEvent>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatusEvent(event.tvDetail.id));
    });
    on<RemoveWatchlistEvent>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(LoadWatchlistStatusEvent(event.tvDetail.id));
    });
    on<LoadWatchlistStatusEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
