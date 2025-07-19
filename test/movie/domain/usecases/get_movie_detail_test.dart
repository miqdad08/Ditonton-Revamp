import 'package:ditonton_revamp/feature/movie/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart';

import 'package:ditonton_revamp/feature/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton_revamp/common/failure.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  provideDummy<Either<Failure, MovieDetail>>(Left(ServerFailure('dummy')));

  late GetMovieDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  const tId = 1;

  test('should return movie detail from repository when successful', () async {
    // arrange
    when(
      mockMovieRepository.getMovieDetail(tId),
    ).thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testMovieDetail));
    verify(mockMovieRepository.getMovieDetail(tId));
    verifyNoMoreInteractions(mockMovieRepository);
  });

  test('should return failure when repository returns error', () async {
    // arrange
    when(
      mockMovieRepository.getMovieDetail(tId),
    ).thenAnswer((_) async => Left(ServerFailure('Server error')));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Left(ServerFailure('Server error')));
  });
}
