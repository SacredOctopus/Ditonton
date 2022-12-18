import 'package:movie/domain/entities/movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChangedEvent>((event, emit) async {
      final query = event.query;

      emit(Loading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(Error(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
