import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockRepository);
  });

  final tvList = [
    TvSeries(
      id: 3,
      name: 'The Wire',
      overview: '...',
      posterPath: '',
    ),
  ];

  test('should get top rated tv series', () async {
    when(mockRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tvList));

    final result = await usecase.execute();

    expect(result, Right(tvList));
    verify(mockRepository.getTopRatedTvSeries());
  });
}
