import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/movie.dart';
import 'package:ditonton_revamp/feature/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  provideDummy<Either<Failure, List<Movie>>>(Left(ServerFailure('dummy')));

  late GetWatchlistMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(
      mockMovieRepository.getWatchlistMovies(),
    ).thenAnswer((_) async => Right(tMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovieList));
  });
}
