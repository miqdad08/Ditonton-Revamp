import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movie;
  final List<Movie> recommendations;
  final bool isLoading;
  final bool isRecommendationLoading;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MovieDetailState({
    this.movie,
    this.recommendations = const [],
    this.isLoading = false,
    this.isRecommendationLoading = false,
    this.message = '',
    this.watchlistMessage = '',
    this.isAddedToWatchlist = false,
  });

  MovieDetailState copyWith({
    MovieDetail? movie,
    List<Movie>? recommendations,
    bool? isLoading,
    bool? isRecommendationLoading,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      isRecommendationLoading:
          isRecommendationLoading ?? this.isRecommendationLoading,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props => [
    movie,
    recommendations,
    isLoading,
    isRecommendationLoading,
    message,
    watchlistMessage,
    isAddedToWatchlist,
  ];
}
