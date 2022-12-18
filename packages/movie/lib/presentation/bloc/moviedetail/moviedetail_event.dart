part of 'moviedetail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailDataWithIdEvent extends MovieDetailEvent {
  final int id;
  const MovieDetailDataWithIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddWatchlistEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatusEvent extends MovieDetailEvent {
  final int id;
  const LoadWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}
