part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

class OnQueryChangedEvent extends SearchMovieEvent {
  final String query;

  const OnQueryChangedEvent(this.query);

  @override
  List<Object> get props => [query];
}
