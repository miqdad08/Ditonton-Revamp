import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));

  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvSeriesBloc bloc;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    bloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  test('initial state should be WatchlistTvSeriesState default', () {
    expect(bloc.state, const WatchlistTvSeriesState());
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'emits [loading, loaded] when fetch is successful',
    build: () {
      when(
        mockGetWatchlistTvSeries.execute(),
      ).thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      const WatchlistTvSeriesState(isLoading: true, message: ''),
      WatchlistTvSeriesState(
        isLoading: false,
        watchlistTvSeries: testTvSeriesList,
        message: '',
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'emits [loading, error] when fetch fails',
    build: () {
      when(
        mockGetWatchlistTvSeries.execute(),
      ).thenAnswer((_) async => Left(DatabaseFailure('DB Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      const WatchlistTvSeriesState(isLoading: true, message: ''),
      const WatchlistTvSeriesState(isLoading: false, message: 'DB Error'),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
