import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_tv_series_event.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this.getTopRatedTvSeries)
    : super(TopRatedTvSeriesInitial()) {
    on<FetchTopRatedTvSeries>(onFetchTopRatedTvSeries);
  }

  void onFetchTopRatedTvSeries(FetchTopRatedTvSeries event, emit) async {
    emit(TopRatedTvSeriesLoading());

    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) => emit(TopRatedTvSeriesError(failure.message)),
      (tv) => emit(TopRatedTvSeriesLoaded(tv)),
    );
  }
}
