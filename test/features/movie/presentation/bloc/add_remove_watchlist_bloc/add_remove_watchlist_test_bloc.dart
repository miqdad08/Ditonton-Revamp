import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton_revamp/feature/movie/presentation/add_remove_watchlist_bloc/add_remove_watchlist_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'add_remove_watchlist_test_bloc.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  provideDummy<Either<Failure, String>>(Right('dummy'));
  late MockGetWatchListStatus mockGetMovieWatchListStatus;
  late MockSaveWatchlist mockSaveMovieWatchlist;
  late MockRemoveWatchlist mockRemoveMovieWatchlist;
  late AddRemoveWatchlistBloc bloc;

  const tId = 1;

  setUp(() {
    mockGetMovieWatchListStatus = MockGetWatchListStatus();
    mockSaveMovieWatchlist = MockSaveWatchlist();
    mockRemoveMovieWatchlist = MockRemoveWatchlist();

    bloc = AddRemoveWatchlistBloc(
      saveMovieWatchlist: mockSaveMovieWatchlist,
      removeMovieWatchlist: mockRemoveMovieWatchlist,
      getMovieWatchListStatus: mockGetMovieWatchListStatus,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, AddRemoveWatchlistHasData('', false));
  });

  blocTest<AddRemoveWatchlistBloc, AddRemoveWatchlistState>(
    'emits [HasData] when OnFetchMovieWatchlistStatus',
    build: () {
      when(
        mockGetMovieWatchListStatus.execute(tId),
      ).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchMovieWatchlistStatus(tId)),
    expect: () => [AddRemoveWatchlistHasData('', true)],
  );

  blocTest<AddRemoveWatchlistBloc, AddRemoveWatchlistState>(
    'emits [HasData] when movie added to watchlist',
    build: () {
      when(
        mockSaveMovieWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => const Right('Added to Watchlist'));
      return bloc;
    },
    act: (bloc) => bloc.add(OnAddMovieWatchlist(testMovieDetail)),
    expect: () => [AddRemoveWatchlistHasData('Added to Watchlist', true)],
  );

  blocTest<AddRemoveWatchlistBloc, AddRemoveWatchlistState>(
    'emits [Error] when adding movie to watchlist fails',
    build: () {
      when(
        mockSaveMovieWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnAddMovieWatchlist(testMovieDetail)),
    expect: () => [AddRemoveWatchlistError('Failed')],
  );

  blocTest<AddRemoveWatchlistBloc, AddRemoveWatchlistState>(
    'emits [HasData] when movie removed from watchlist',
    build: () {
      when(
        mockRemoveMovieWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => const Right('Removed from Watchlist'));
      return bloc;
    },
    act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
    expect: () => [AddRemoveWatchlistHasData('Removed from Watchlist', false)],
  );

  blocTest<AddRemoveWatchlistBloc, AddRemoveWatchlistState>(
    'emits [Error] when removing movie from watchlist fails',
    build: () {
      when(
        mockRemoveMovieWatchlist.execute(testMovieDetail),
      ).thenAnswer((_) async => Left(ServerFailure('Failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
    expect: () => [AddRemoveWatchlistError('Failed')],
  );
}
