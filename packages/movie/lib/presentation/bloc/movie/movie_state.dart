part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class EmptyData extends MovieState {}

class Loading extends MovieState {}

class Error extends MovieState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedData extends MovieState {
  final List<Movie> result;

  const LoadedData(this.result);

  @override
  List<Object> get props => [result];
}
