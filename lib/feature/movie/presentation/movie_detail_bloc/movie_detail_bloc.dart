import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState()) {
    on<FetchMovieDetail>(onFetchMovieDetail);
    on<AddToWatchlist>(onAddToWatchlist);
    on<RemoveFromWatchlist>(onRemoveFromWatchlist);
    on<LoadWatchlistStatus>(onLoadWatchlistStatus);
  }

  void onFetchMovieDetail(FetchMovieDetail event, emit) async {
    emit(state.copyWith(isLoading: true, message: ''));

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult = await getMovieRecommendations.execute(
      event.id,
    );

    detailResult.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, message: failure.message));
      },
      (movieDetail) {
        emit(
          state.copyWith(
            movie: movieDetail,
            isLoading: false,
            isRecommendationLoading: true,
          ),
        );

        recommendationResult.fold(
          (failure) {
            emit(
              state.copyWith(
                isRecommendationLoading: false,
                message: failure.message,
              ),
            );
          },
          (recommendations) {
            emit(
              state.copyWith(
                recommendations: recommendations,
                isRecommendationLoading: false,
              ),
            );
          },
        );
      },
    );
  }

  void onAddToWatchlist(AddToWatchlist event, emit) async {
    final result = await saveWatchlist.execute(event.movieDetail);
    final message = result.fold(
      (failure) => failure.message,
      (success) => success,
    );
    emit(state.copyWith(watchlistMessage: message));
    add(LoadWatchlistStatus(event.movieDetail.id));
  }

  void onRemoveFromWatchlist(RemoveFromWatchlist event, emit) async {
    final result = await removeWatchlist.execute(event.movieDetail);
    final message = result.fold(
      (failure) => failure.message,
      (success) => success,
    );
    emit(state.copyWith(watchlistMessage: message));
    add(LoadWatchlistStatus(event.movieDetail.id));
  }

  void onLoadWatchlistStatus(LoadWatchlistStatus event, emit) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }
}
