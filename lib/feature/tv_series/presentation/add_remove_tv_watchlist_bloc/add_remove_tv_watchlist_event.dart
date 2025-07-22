part of 'add_remove_tv_watchlist_bloc.dart';

abstract class AddRemoveTvWatchlistEvent {
  const AddRemoveTvWatchlistEvent();
}

class OnAddTvSeriesWatchlist extends AddRemoveTvWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;
  OnAddTvSeriesWatchlist(this.tvSeriesDetail);
}

class OnRemoveTvSeriesWatchlist extends AddRemoveTvWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;
  OnRemoveTvSeriesWatchlist(this.tvSeriesDetail);
}

class OnFetchTvSeriesWatchlistStatus extends AddRemoveTvWatchlistEvent {
  final int tvSeriesId;
  OnFetchTvSeriesWatchlistStatus(this.tvSeriesId);
}
