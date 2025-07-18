import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>(onQueryChanged);
  }

  void onQueryChanged(OnQueryChanged event, emit) async {
    final query = event.query;

    emit(MovieSearchLoading());

    final result = await searchMovies.execute(query);

    result.fold(
      (failure) => emit(MovieSearchError(failure.message)),
      (data) => emit(MovieSearchHasData(data)),
    );
  }
}
