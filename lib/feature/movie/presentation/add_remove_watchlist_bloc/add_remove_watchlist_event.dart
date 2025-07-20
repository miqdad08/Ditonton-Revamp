part of 'add_remove_watchlist_bloc.dart';

abstract class AddRemoveWatchlistEvent {
  const AddRemoveWatchlistEvent();
}

/// Movie
class OnAddMovieWatchlist extends AddRemoveWatchlistEvent {
  final MovieDetail movieDetail;
  OnAddMovieWatchlist(this.movieDetail);
}

class OnRemoveMovieWatchlist extends AddRemoveWatchlistEvent {
  final MovieDetail movieDetail;
  OnRemoveMovieWatchlist(this.movieDetail);
}

class OnFetchMovieWatchlistStatus extends AddRemoveWatchlistEvent {
  final int movieId;
  OnFetchMovieWatchlistStatus(this.movieId);
}
