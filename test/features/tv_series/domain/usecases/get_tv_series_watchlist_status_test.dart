import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchListStatus usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesWatchListStatus(mockTvSeriesRepository);
  });

  test('should get tv series watchlist status from repository', () async {
    // arrange
    when(
      mockTvSeriesRepository.isAddedToWatchlist(1),
    ).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
