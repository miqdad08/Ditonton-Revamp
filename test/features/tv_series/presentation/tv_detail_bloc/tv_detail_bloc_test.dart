import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail, GetTvSeriesRecommendations])
void main() {
  setUpAll(() {
    provideDummy<Either<Failure, TvSeriesDetail>>(Left(ServerFailure('dummy')));
    provideDummy<Either<Failure, List<TvSeries>>>(Left(ServerFailure('dummy')));
  });
  late TvDetailBloc bloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    bloc = TvDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
    );
  });

  const tId = 1;

  test('initial state should be TvDetailEmpty', () {
    expect(bloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [Loading, HasData] when data fetched successfully',
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesDetail));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendation: testTvSeriesList,
      ),
    ],
    verify: (_) {
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [Loading, Error] when getting detail fails',
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Failed')));

      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right([]));

      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
    expect: () => [TvDetailLoading(), const TvDetailError('Failed')],
    verify: (_) {
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [Loading, Error] when getting recommendation fails',
    build: () {
      when(
        mockGetTvSeriesDetail.execute(tId),
      ).thenAnswer((_) async => Right(testTvSeriesDetail));
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Left(ServerFailure('Failed Recs')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
    expect: () => [TvDetailLoading(), const TvDetailError('Failed Recs')],
    verify: (_) {
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );
}
