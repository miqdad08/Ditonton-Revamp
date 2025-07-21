import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/movie.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/search_movies.dart';
import 'package:ditonton_revamp/feature/movie/presentation/movie_search_bloc/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  provideDummy<Either<Failure, List<Movie>>>(Right([]));
  late MovieSearchBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchBloc(mockSearchMovies);
  });

  const tQuery = 'Avengers';

  test('initial state should be MovieSearchEmpty', () {
    expect(bloc.state, MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [Loading, HasData] when search is successful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 100), // optional debounce simulation
    expect: () => [
      MovieSearchLoading(),
      MovieSearchHasData(testMovieList),
    ],
    verify: (_) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [Loading, Error] when search fails',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchError('Server Failure'),
    ],
    verify: (_) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
