import 'package:ditonton_revamp/common/type_defs.dart';

import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies();

  FutureEither<List<Movie>> getPopularMovies();

  FutureEither<List<Movie>> getTopRatedMovies();

  FutureEither<MovieDetail> getMovieDetail(int id);

  FutureEither<List<Movie>> getMovieRecommendations(int id);

  FutureEither<List<Movie>> searchMovies(String query);

  FutureEither<String> saveWatchlist(MovieDetail movie);

  FutureEither<String> removeWatchlist(MovieDetail movie);

  Future<bool> isAddedToWatchlist(int id);

  FutureEither<List<Movie>> getWatchlistMovies();
}
