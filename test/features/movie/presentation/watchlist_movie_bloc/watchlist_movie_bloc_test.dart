import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/movie.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_event.dart';
import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  provideDummy<Either<Failure, List<Movie>>>(Right([]));

  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  test('initial state should be WatchlistMovieState()', () {
    expect(watchlistMovieBloc.state, const WatchlistMovieState());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [loading, hasData] when getWatchlistMovies is successful',
    build: () {
      when(
        mockGetWatchlistMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(isLoading: true, message: ''),
      WatchlistMovieState(isLoading: false, watchlistMovies: testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [loading, error] when getWatchlistMovies fails',
    build: () {
      when(
        mockGetWatchlistMovies.execute(),
      ).thenAnswer((_) async => Left(DatabaseFailure('Database Error')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(isLoading: true, message: ''),
      const WatchlistMovieState(isLoading: false, message: 'Database Error'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  test('WatchlistMovieState supports value comparison', () {
    expect(
      const WatchlistMovieState(),
      equals(const WatchlistMovieState()),
    );
  });

  test('WatchlistMovieState copyWith works correctly', () {
    final state = const WatchlistMovieState();

    final newState = state.copyWith(
      isLoading: true,
      watchlistMovies: testMovieList,
      message: 'Success',
    );

    expect(newState.isLoading, true);
    expect(newState.watchlistMovies, testMovieList);
    expect(newState.message, 'Success');
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [loading, hasData (empty)] when watchlist is empty',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(isLoading: true, message: ''),
      const WatchlistMovieState(isLoading: false, watchlistMovies: []),
    ],
    verify: (_) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit proper states when FetchWatchlistMovies is added',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(isLoading: true),
      WatchlistMovieState(isLoading: false, watchlistMovies: testMovieList),
    ],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit error when fetching watchlist fails',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(isLoading: true),
      const WatchlistMovieState(isLoading: false, message: 'Failed', watchlistMovies: []),
    ],
  );

}
