import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/on_the_air_tv_series_bloc/on_the_air_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvSeries])
void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));
  late OnTheAirTvSeriesBloc bloc;
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvSeries;

  setUp(() {
    mockGetOnTheAirTvSeries = MockGetOnTheAirTvSeries();
    bloc = OnTheAirTvSeriesBloc(mockGetOnTheAirTvSeries);
  });

  test('initial state should be initial', () {
    expect(bloc.state, OnTheAirTvSeriesInitial());
  });

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Right([testTvSeries]));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      OnTheAirTvSeriesLoading(),
      OnTheAirTvSeriesLoaded([testTvSeries]),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
    'emits [Loading, Error] when get data fails',
    build: () {
      when(mockGetOnTheAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTvSeries()),
    expect: () => [
      OnTheAirTvSeriesLoading(),
      OnTheAirTvSeriesError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetOnTheAirTvSeries.execute());
    },
  );
}
