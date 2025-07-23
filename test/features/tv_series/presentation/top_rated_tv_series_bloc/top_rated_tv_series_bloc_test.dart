import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));

  late TopRatedTvSeriesBloc bloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  test('initial state should be TopRatedTvSeriesInitial', () {
    expect(bloc.state, TopRatedTvSeriesInitial());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'emits [Loading, Loaded] when data is fetched successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesLoaded(testTvSeriesList),
    ],
    verify: (_) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'emits [Loading, Error] when getting data fails',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
