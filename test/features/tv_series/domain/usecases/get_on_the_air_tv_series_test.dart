import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));
  late GetOnTheAirTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetOnTheAirTvSeries(mockRepository);
  });

  final tvList = [
    TvSeries(id: 1, name: 'Now', overview: '...', posterPath: ''),
  ];

  test('should get now playing tv series', () async {
    when(
      mockRepository.getOnTheAirTvSeries(),
    ).thenAnswer((_) async => Right(tvList));

    final result = await usecase.execute();

    expect(result, Right(tvList));
    verify(mockRepository.getOnTheAirTvSeries());
  });
}
