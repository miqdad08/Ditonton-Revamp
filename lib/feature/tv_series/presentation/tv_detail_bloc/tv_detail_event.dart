part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent {
  const TvDetailEvent();
}

class OnFetchTvDetail extends TvDetailEvent {
  final int tvId;

  OnFetchTvDetail(this.tvId);
}

class OnAddToWatchlist extends TvDetailEvent {
  final TvSeriesDetail tvDetail;

  OnAddToWatchlist(this.tvDetail);
}

class OnRemoveFromWatchlist extends TvDetailEvent {
  final TvSeriesDetail tvDetail;

  OnRemoveFromWatchlist(this.tvDetail);
}
