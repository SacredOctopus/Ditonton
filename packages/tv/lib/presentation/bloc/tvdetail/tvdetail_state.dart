part of 'tvdetail_bloc.dart';

class TvDetailState extends Equatable {
  final TvDetail? tvDetail;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final RequestState state;

  const TvDetailState({
    required this.tvDetail,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.state,
  });

  TvDetailState copyWith({
    TvDetail? tvDetail,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    RequestState? state,
  }) {
    return TvDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      state: state ?? this.state,
    );
  }

  factory TvDetailState.initial() {
    return const TvDetailState(
      tvDetail: null,
      watchlistMessage: '',
      isAddedToWatchlist: false,
      state: RequestState.empty,
    );
  }

  @override
  List<Object> get props => [
        watchlistMessage,
        isAddedToWatchlist,
        state,
      ];
}
