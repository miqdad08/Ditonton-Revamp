import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_event.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies)
    : super(NowPlayingMoviesInitial()) {
    on<FetchNowPlayingMovies>(onFetchNowPlayingMovies);
  }

  void onFetchNowPlayingMovies(FetchNowPlayingMovies event, emit) async {
    emit(NowPlayingMoviesLoading());

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) => emit(NowPlayingMoviesError(failure.message)),
      (movies) => emit(NowPlayingMoviesLoaded(movies)),
    );
  }
}
