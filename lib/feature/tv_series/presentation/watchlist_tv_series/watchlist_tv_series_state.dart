part of 'watchlist_tv_series_bloc.dart';

class WatchlistTvSeriesState extends Equatable {
  final List<TvSeries> watchlistTvSeries;
  final bool isLoading;
  final String message;

  const WatchlistTvSeriesState({
    this.watchlistTvSeries = const [],
    this.isLoading = false,
    this.message = '',
  });

  WatchlistTvSeriesState copyWith({
    List<TvSeries>? watchlistTvSeries,
    bool? isLoading,
    String? message,
  }) {
    return WatchlistTvSeriesState(
      watchlistTvSeries: watchlistTvSeries ?? this.watchlistTvSeries,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistTvSeries, isLoading, message];
}
