part of 'add_remove_tv_watchlist_bloc.dart';

abstract class AddRemoveTvWatchlistState extends Equatable {
  const AddRemoveTvWatchlistState();

  @override
  List<Object> get props => [];
}

final class AddRemoveWatchlistInitial extends AddRemoveTvWatchlistState {}

class AddRemoveWatchlistError extends AddRemoveTvWatchlistState {
  final String message;

  const AddRemoveWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class AddRemoveWatchlistHasData extends AddRemoveTvWatchlistState {
  final String message;

  final bool isInWatchlist;

  const AddRemoveWatchlistHasData(this.message, this.isInWatchlist);

  @override
  List<Object> get props => [message, isInWatchlist];
}
