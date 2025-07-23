import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton_revamp/feature/movie/presentation/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton_revamp/feature/movie/domain/entities/movie.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);

    provideDummy<Either<Failure, List<Movie>>>(Left(ServerFailure('dummy')));
  });

  test('initial state should be PopularMoviesInitial', () {
    expect(popularMoviesBloc.state, PopularMoviesInitial());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(testMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [PopularMoviesLoading(), PopularMoviesLoaded(testMovieList)],
    verify: (_) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emits [Loading, Error] when getting data fails',
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
    verify: (_) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
