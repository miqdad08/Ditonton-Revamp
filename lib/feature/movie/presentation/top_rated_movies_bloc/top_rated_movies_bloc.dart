import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMoviesMovies;

  TopRatedMoviesBloc(this.getTopRatedMoviesMovies)
    : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMovies>(onFetchTopRatedMoviesMovies);
  }

  void onFetchTopRatedMoviesMovies(FetchTopRatedMovies event, emit) async {
    emit(TopRatedMoviesLoading());

    final result = await getTopRatedMoviesMovies.execute();

    result.fold(
      (failure) => emit(TopRatedMoviesError(failure.message)),
      (movies) => emit(TopRatedMoviesLoaded(movies)),
    );
  }
}
