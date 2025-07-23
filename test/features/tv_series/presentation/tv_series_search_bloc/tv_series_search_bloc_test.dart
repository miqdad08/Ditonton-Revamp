import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/search_tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/tv_series_search_bloc/tv_series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));

  late TvSeriesSearchBloc bloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    bloc = TvSeriesSearchBloc(mockSearchTvSeries);
  });

  const tQuery = 'Breaking Bad';

  test('initial state should be TvSeriesSearchEmpty', () {
    expect(bloc.state, TvSeriesSearchEmpty());
  });

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'emits [Loading, HasData] when search is successful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'emits [Loading, Error] when search fails',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Search failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Search failed'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
