import 'package:ditonton_revamp/feature/movie/domain/usecases/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMoviesMovies;

  PopularMoviesBloc(this.getPopularMoviesMovies)
    : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>(onFetchPopularMoviesMovies);
  }

  void onFetchPopularMoviesMovies(FetchPopularMovies event, emit) async {
    emit(PopularMoviesLoading());

    final result = await getPopularMoviesMovies.execute();

    result.fold(
      (failure) => emit(PopularMoviesError(failure.message)),
      (movies) => emit(PopularMoviesLoaded(movies)),
    );
  }
}
