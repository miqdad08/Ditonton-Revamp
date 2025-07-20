part of 'add_remove_watchlist_bloc.dart';

abstract class AddRemoveWatchlistState extends Equatable {
  const AddRemoveWatchlistState();

  @override
  List<Object> get props => [];
}

final class AddRemoveWatchlistInitial extends AddRemoveWatchlistState {}

class AddRemoveWatchlistError extends AddRemoveWatchlistState {
  final String message;

  const AddRemoveWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class AddRemoveWatchlistHasData extends AddRemoveWatchlistState {
  final String message;

  /// true = in watchlist,
  /// false = not in watchlist
  final bool isInWatchlist;

  const AddRemoveWatchlistHasData(this.message, this.isInWatchlist);

  @override
  List<Object> get props => [message, isInWatchlist];
}
