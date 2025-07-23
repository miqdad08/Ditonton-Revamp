import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));

  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockRepository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test(
    'should get list of tv series recommendations from the repository',
    () async {
      // arrange
      when(
        mockRepository.getTvSeriesRecommendations(tId),
      ).thenAnswer((_) async => Right(tTvSeries));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(tTvSeries));
    },
  );
}
