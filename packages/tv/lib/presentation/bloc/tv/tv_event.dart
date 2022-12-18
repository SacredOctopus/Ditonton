part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();
}

class TvDataEvent extends TvEvent {
  const TvDataEvent();

  @override
  List<Object> get props => [];
}

class TvDataWithIdEvent extends TvEvent {
  final int id;
  const TvDataWithIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
