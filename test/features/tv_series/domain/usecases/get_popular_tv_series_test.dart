import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockRepository);
  });

  final tvList = [
    TvSeries(
      id: 1,
      name: 'Breaking Bad',
      overview: 'desc',
      posterPath: '/poster.jpg',
    ),
  ];

  test('should get list of popular tv series from the repository', () async {
    // arrange
    when(
      mockRepository.getPopularTvSeries(),
    ).thenAnswer((_) async => Right(tvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvList));
    verify(mockRepository.getPopularTvSeries());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when something goes wrong', () async {
    // arrange
    when(
      mockRepository.getPopularTvSeries(),
    ).thenAnswer((_) async => Left(ServerFailure('error')));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Left(ServerFailure('error')));
  });
}
