part of 'moviedetail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  final RequestState state;

  const MovieDetailState({
    required this.movieDetail,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
    required this.state,
  });

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
    RequestState? state,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      state: state ?? this.state,
    );
  }

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movieDetail: null,
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
