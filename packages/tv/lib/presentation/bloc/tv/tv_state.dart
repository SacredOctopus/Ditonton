part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class EmptyData extends TvState {}

class Loading extends TvState {}

class Error extends TvState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedData extends TvState {
  final List<Tv> result;

  const LoadedData(this.result);

  @override
  List<Object> get props => [result];
}
