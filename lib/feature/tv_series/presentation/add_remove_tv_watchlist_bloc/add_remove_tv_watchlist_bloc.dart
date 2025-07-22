import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'add_remove_tv_watchlist_event.dart';

part 'add_remove_tv_watchlist_state.dart';

class AddRemoveTvWatchlistBloc
    extends Bloc<AddRemoveTvWatchlistEvent, AddRemoveTvWatchlistState> {
  final GetTvSeriesWatchListStatus getTvSeriesWatchListStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;

  AddRemoveTvWatchlistBloc({
    required this.getTvSeriesWatchListStatus,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
  }) : super(AddRemoveWatchlistHasData('', false)) {
    on<OnFetchTvSeriesWatchlistStatus>((event, emit) async {
      final result = await getTvSeriesWatchListStatus.execute(event.tvSeriesId);
      emit(AddRemoveWatchlistHasData('', result));
    });

    on<OnAddTvSeriesWatchlist>((event, emit) async {
      final result = await saveTvSeriesWatchlist.execute(event.tvSeriesDetail);

      result.fold(
        (error) {
          emit(AddRemoveWatchlistError(error.message));
        },
        (success) {
          emit(AddRemoveWatchlistHasData(success, true));
        },
      );
    });

    on<OnRemoveTvSeriesWatchlist>((event, emit) async {
      final result = await removeTvSeriesWatchlist.execute(
        event.tvSeriesDetail,
      );
      result.fold(
        (error) {
          emit(AddRemoveWatchlistError(error.message));
        },
        (success) {
          emit(AddRemoveWatchlistHasData(success, false));
        },
      );
    });
  }
}
