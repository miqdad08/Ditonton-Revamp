import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc(this.getWatchlistTvSeries)
    : super(const WatchlistTvSeriesState()) {
    on<FetchWatchlistTvSeries>((event, emit) async {
      emit(state.copyWith(isLoading: true, message: ''));

      final result = await getWatchlistTvSeries.execute();

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, message: failure.message));
        },
        (moviesData) {
          emit(state.copyWith(isLoading: false, watchlistTvSeries: moviesData));
        },
      );
    });
  }
}
