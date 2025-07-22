part of 'on_the_air_tv_series_bloc.dart';

abstract class OnTheAirTvSeriesState extends Equatable {
  const OnTheAirTvSeriesState();

  @override
  List<Object?> get props => [];
}

class OnTheAirTvSeriesInitial extends OnTheAirTvSeriesState {}

class OnTheAirTvSeriesLoading extends OnTheAirTvSeriesState {}

class OnTheAirTvSeriesLoaded extends OnTheAirTvSeriesState {
  final List<TvSeries> series;

  const OnTheAirTvSeriesLoaded(this.series);

  @override
  List<Object?> get props => [series];
}

class OnTheAirTvSeriesError extends OnTheAirTvSeriesState {
  final String message;

  const OnTheAirTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}
