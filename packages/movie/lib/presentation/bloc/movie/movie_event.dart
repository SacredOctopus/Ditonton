part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MoviesDataEvent extends MovieEvent {
  const MoviesDataEvent();

  @override
  List<Object> get props => [];
}

class MovieDataWithIdEvent extends MovieEvent {
  final int id;
  const MovieDataWithIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
