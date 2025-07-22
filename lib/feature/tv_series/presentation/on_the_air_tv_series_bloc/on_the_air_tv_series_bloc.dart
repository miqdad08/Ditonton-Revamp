import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_the_air_tv_series_event.dart';

part 'on_the_air_tv_series_state.dart';

class OnTheAirTvSeriesBloc
    extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries getOnTheAirTvSeries;

  OnTheAirTvSeriesBloc(this.getOnTheAirTvSeries)
    : super(OnTheAirTvSeriesInitial()) {
    on<FetchOnTheAirTvSeries>(onFetchOnTheAirTvSeries);
  }

  void onFetchOnTheAirTvSeries(FetchOnTheAirTvSeries event, emit) async {
    emit(OnTheAirTvSeriesLoading());

    final result = await getOnTheAirTvSeries.execute();

    result.fold(
      (failure) => emit(OnTheAirTvSeriesError(failure.message)),
      (tv) => emit(OnTheAirTvSeriesLoaded(tv)),
    );
  }
}
