import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
  }) : super(TvDetailEmpty()) {
    on<OnFetchTvDetail>((event, emit) async {
      emit(TvDetailLoading());
      final tvId = event.tvId;
      final detailResult = await getTvSeriesDetail.execute(tvId);
      final recommendationResult = await getTvSeriesRecommendations.execute(
        tvId,
      );

      detailResult.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (tv) {
          recommendationResult.fold(
            (failure) {
              emit(TvDetailError(failure.message));
            },
            (tvs) {
              emit(
                TvDetailHasData(
                  tvSeriesDetail: tv,
                  tvSeriesRecommendation: tvs,
                ),
              );
            },
          );
        },
      );
    });
  }
}
