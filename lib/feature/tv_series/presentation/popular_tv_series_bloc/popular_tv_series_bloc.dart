import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_popular_tv_series.dart';

part 'popular_tv_series_event.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc(this.getPopularTvSeries)
    : super(PopularTvSeriesInitial()) {
    on<FetchPopularTvSeries>(onFetchPopularTvSeriesTvSeries);
  }

  void onFetchPopularTvSeriesTvSeries(FetchPopularTvSeries event, emit) async {
    emit(PopularTvSeriesLoading());

    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) => emit(PopularTvSeriesError(failure.message)),
      (movies) => emit(PopularTvSeriesLoaded(movies)),
    );
  }
}
