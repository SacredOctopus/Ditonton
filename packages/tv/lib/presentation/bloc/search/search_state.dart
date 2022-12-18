part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchTvState {}

class Loading extends SearchTvState {}

class Error extends SearchTvState {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchTvState {
  final List<Tv> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
