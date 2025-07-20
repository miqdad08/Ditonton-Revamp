import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'add_remove_watchlist_event.dart';

part 'add_remove_watchlist_state.dart';

class AddRemoveWatchlistBloc
    extends Bloc<AddRemoveWatchlistEvent, AddRemoveWatchlistState> {
  final GetWatchListStatus getMovieWatchListStatus;
  final SaveWatchlist saveMovieWatchlist;
  final RemoveWatchlist removeMovieWatchlist;

  AddRemoveWatchlistBloc({
    required this.getMovieWatchListStatus,
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
  }) : super(AddRemoveWatchlistHasData('', false)) {
    on<OnFetchMovieWatchlistStatus>((event, emit) async {
      final result = await getMovieWatchListStatus.execute(event.movieId);
      emit(AddRemoveWatchlistHasData('', result));
    });

    on<OnAddMovieWatchlist>((event, emit) async {
      final result = await saveMovieWatchlist.execute(event.movieDetail);

      result.fold(
        (error) {
          emit(AddRemoveWatchlistError(error.message));
        },
        (success) {
          emit(AddRemoveWatchlistHasData(success, true));
        },
      );
    });

    on<OnRemoveMovieWatchlist>((event, emit) async {
      final result = await removeMovieWatchlist.execute(event.movieDetail);
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
