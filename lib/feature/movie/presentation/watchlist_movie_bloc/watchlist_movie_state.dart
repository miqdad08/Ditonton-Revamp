import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

class WatchlistMovieState extends Equatable {
  final List<Movie> watchlistMovies;
  final bool isLoading;
  final String message;

  const WatchlistMovieState({
    this.watchlistMovies = const [],
    this.isLoading = false,
    this.message = '',
  });

  WatchlistMovieState copyWith({
    List<Movie>? watchlistMovies,
    bool? isLoading,
    String? message,
  }) {
    return WatchlistMovieState(
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistMovies, isLoading, message];
}
