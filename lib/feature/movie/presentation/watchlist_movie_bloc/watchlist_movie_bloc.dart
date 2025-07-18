import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_event.dart';
import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_watchlist_movies.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies)
    : super(const WatchlistMovieState()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(state.copyWith(isLoading: true, message: ''));

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, message: failure.message));
        },
        (moviesData) {
          emit(state.copyWith(isLoading: false, watchlistMovies: moviesData));
        },
      );
    });
  }
}
