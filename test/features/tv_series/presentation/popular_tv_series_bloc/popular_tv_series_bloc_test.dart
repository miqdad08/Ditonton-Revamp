import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));
  late PopularTvSeriesBloc bloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    bloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  test('initial state should be PopularTvSeriesInitial', () {
    expect(bloc.state, PopularTvSeriesInitial());
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Right([testTvSeries]));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesLoaded([testTvSeries]),
    ],
    verify: (_) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'emits [Loading, Error] when get data fails',
    build: () {
      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
