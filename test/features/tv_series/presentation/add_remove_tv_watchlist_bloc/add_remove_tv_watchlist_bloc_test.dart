import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/add_remove_tv_watchlist_bloc/add_remove_tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'add_remove_tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesWatchListStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  provideDummy<Either<Failure, String>>(Right('dummy'));
  late MockGetTvSeriesWatchListStatus mockGetWatchlistStatus;
  late MockSaveTvSeriesWatchlist mockSaveWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveWatchlist;
  late AddRemoveTvWatchlistBloc bloc;

  const tId = 1;

  setUp(() {
    mockGetWatchlistStatus = MockGetTvSeriesWatchListStatus();
    mockSaveWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveWatchlist = MockRemoveTvSeriesWatchlist();

    bloc = AddRemoveTvWatchlistBloc(
      getTvSeriesWatchListStatus: mockGetWatchlistStatus,
      saveTvSeriesWatchlist: mockSaveWatchlist,
      removeTvSeriesWatchlist: mockRemoveWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, const AddRemoveWatchlistHasData('', false));
  });

  blocTest<AddRemoveTvWatchlistBloc, AddRemoveTvWatchlistState>(
    'emits [HasData] when OnFetchTvSeriesWatchlistStatus',
    build: () {
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchTvSeriesWatchlistStatus(tId)),
    expect: () => [const AddRemoveWatchlistHasData('', true)],
  );

  blocTest<AddRemoveTvWatchlistBloc, AddRemoveTvWatchlistState>(
    'emits [HasData] when tv series added to watchlist',
    build: () {
      when(mockSaveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return bloc;
    },
    act: (bloc) => bloc.add(OnAddTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [const AddRemoveWatchlistHasData('Added to Watchlist', true)],
  );

  blocTest<AddRemoveTvWatchlistBloc, AddRemoveTvWatchlistState>(
    'emits [Error] when adding tv series to watchlist fails',
    build: () {
      when(mockSaveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnAddTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [const AddRemoveWatchlistError('Failed')],
  );

  blocTest<AddRemoveTvWatchlistBloc, AddRemoveTvWatchlistState>(
    'emits [HasData] when tv series removed from watchlist',
    build: () {
      when(mockRemoveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return bloc;
    },
    act: (bloc) => bloc.add(OnRemoveTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [const AddRemoveWatchlistHasData('Removed from Watchlist', false)],
  );

  blocTest<AddRemoveTvWatchlistBloc, AddRemoveTvWatchlistState>(
    'emits [Error] when removing tv series from watchlist fails',
    build: () {
      when(mockRemoveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnRemoveTvSeriesWatchlist(testTvSeriesDetail)),
    expect: () => [const AddRemoveWatchlistError('Failed')],
  );
}
