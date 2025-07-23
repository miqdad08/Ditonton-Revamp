import 'dart:io';

import 'package:ditonton_revamp/common/exception.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/genre_model.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton_revamp/feature/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
    posterPath: 'posterPath',
    id: 23,
    overview: 'overview',
    name: 'Arcane',
  );

  final tTvSeries = TvSeries(
    posterPath: 'posterPath',
    id: 23,
    overview: 'overview',
    name: 'Arcane',
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getOnTheAirTvSeries(),
        ).thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvSeries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<TvSeries> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getOnTheAirTvSeries(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvSeries());
        expect(result, Left(ServerFailure('Server error')));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getOnTheAirTvSeries(),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getOnTheAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnTheAirTvSeries());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Popular Tv Series', () {
    test(
      'should return tv series list when call to data source is success',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getPopularTvSeries(),
        ).thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<TvSeries> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getPopularTvSeries(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        expect(result, Left(ServerFailure('Server error')));
      },
    );

    test(
      'should return connection failure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getPopularTvSeries(),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getPopularTvSeries();
        // assert
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Top Rated Tv Series', () {
    test(
      'should return tv series list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTopRatedTvSeries(),
        ).thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<TvSeries> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTopRatedTvSeries(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        expect(result, Left(ServerFailure('Server error')));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTopRatedTvSeries(),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTopRatedTvSeries();
        // assert
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Get Tv Series Detail', () {
    final tId = testTvSeriesDetail.id;
    final tTvSeriesResponse = TvSeriesDetailModel(
      id: testTvSeriesDetail.id,
      name: testTvSeriesDetail.name,
      overview: testTvSeriesDetail.overview,
      posterPath: testTvSeriesDetail.posterPath,
      voteAverage: testTvSeriesDetail.voteAverage,
      genres: testTvSeriesDetail.genres.map((g) => GenreTvModel(id: g.id, name: g.name)).toList(),
      episodeRunTime: [1],
    );

    test(
      'should return Tv Series data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvSeriesDetail(tId),
        ).thenAnswer((_) async => tTvSeriesResponse);
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(result, equals(Right(testTvSeriesDetail)));
      },
    );

    test(
      'should return Server Failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvSeriesDetail(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(result, Left(ServerFailure('Server error')));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvSeriesDetail(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTvSeriesDetail(tId);
        // assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Get Tv Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test(
      'should return data (Tv series list) when the call is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenAnswer((_) async => tTvSeriesList);
        // act
        final result = await repository.getTvSeriesRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<TvSeries> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, equals(tTvSeriesList));
      },
    );

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTvSeriesRecommendations(tId);
        // assertbuild runner
        verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
        expect(result, Left(ServerFailure('Server error')));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvSeriesRecommendations(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTvSeriesRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Search Tv Series', () {
    final tQuery = 'arcane';

    test(
      'should return tv series list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<TvSeries> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(ServerException());
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(result, Left(ServerFailure('Server error')));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(any),
      ).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(any),
      ).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(any),
      ).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(any),
      ).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(
        mockLocalDataSource.getTvSeriesById(tId),
      ).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of Tv Series', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlistTvSeries(),
      ).thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      late List<TvSeries> resultList;

      result.match((l) => resultList = [], (r) => resultList = r);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
