part of 'tvdetail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class TvDetailDataWithIdEvent extends TvDetailEvent {
  final int id;
  const TvDetailDataWithIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends TvDetailEvent {
  final TvDetail tvDetail;

  const AddWatchlistEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveWatchlistEvent extends TvDetailEvent {
  final TvDetail tvDetail;

  const RemoveWatchlistEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistStatusEvent extends TvDetailEvent {
  final int id;
  const LoadWatchlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}
