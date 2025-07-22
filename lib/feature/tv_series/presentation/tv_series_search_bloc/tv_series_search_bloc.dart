import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/search_tv_series.dart';

part 'tv_series_search_event.dart';

part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc(this.searchTvSeries) : super(TvSeriesSearchEmpty()) {
    on<OnQueryChanged>(onQueryChanged);
  }

  void onQueryChanged(OnQueryChanged event, emit) async {
    final query = event.query;

    emit(TvSeriesSearchLoading());

    final result = await searchTvSeries.execute(query);

    result.fold(
      (failure) => emit(TvSeriesSearchError(failure.message)),
      (data) => emit(TvSeriesSearchHasData(data)),
    );
  }
}
