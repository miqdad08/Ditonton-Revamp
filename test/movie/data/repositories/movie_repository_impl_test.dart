import 'dart:io';

import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/data/repositories/movie_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('Get Now Playing Movies', () {
    test(
      'should return movie list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getNowPlayingMovies(),
        ).thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        result.match(
          (l) => fail('Expected success but got failure: $l'),
          (r) => expect(r, tMovieList),
        );
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getNowPlayingMovies(),
        ).thenThrow(const SocketException('Failed to connect'));

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        expect(result.isLeft(), true);
        result.match(
          (l) => expect(l, isA<ConnectionFailure>()),
          (r) => fail('Expected failure but got success'),
        );
      },
    );
  });

  group('Get Movie Detail', () {
    test('should return movie detail when call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.getMovieDetail(1),
      ).thenAnswer((_) async => testMovieDetailModel);

      // act
      final result = await repository.getMovieDetail(1);

      // assert
      result.match(
        (l) => fail('Expected success but got failure: $l'),
        (r) => expect(r, testMovieDetail),
      );
    });
  });

  group('Get Recommendations', () {
    test('should return list of movies when call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.getMovieRecommendations(1),
      ).thenAnswer((_) async => tMovieModelList);

      // act
      final result = await repository.getMovieRecommendations(1);

      // assert
      result.match(
        (l) => fail('Expected success but got failure: $l'),
        (r) => expect(r, tMovieList),
      );
    });
  });

  group('Watchlist', () {
    test('should return success message when saving watchlist', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testMovieTable),
      ).thenAnswer((_) async => 'Added to Watchlist');

      // act
      final result = await repository.saveWatchlist(testMovieDetail);

      // assert
      result.match(
        (l) => fail('Expected success but got failure: $l'),
        (r) => expect(r, 'Added to Watchlist'),
      );
    });

    test('should return success message when removing watchlist', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testMovieTable),
      ).thenAnswer((_) async => 'Removed from Watchlist');

      // act
      final result = await repository.removeWatchlist(testMovieDetail);

      // assert
      result.match(
        (l) => fail('Expected success but got failure: $l'),
        (r) => expect(r, 'Removed from Watchlist'),
      );
    });

    test('should return true when movie is in watchlist', () async {
      // arrange
      when(
        mockLocalDataSource.getMovieById(1),
      ).thenAnswer((_) async => testMovieTable);

      // act
      final result = await repository.isAddedToWatchlist(1);

      // assert
      expect(result, true);
    });

    test('should return false when movie is not in watchlist', () async {
      // arrange
      when(mockLocalDataSource.getMovieById(1)).thenAnswer((_) async => null);

      // act
      final result = await repository.isAddedToWatchlist(1);

      // assert
      expect(result, false);
    });

    test('should return watchlist movies', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlistMovies(),
      ).thenAnswer((_) async => [testMovieTable]);

      // act
      final result = await repository.getWatchlistMovies();

      // assert
      result.match(
        (l) => fail('Expected success but got failure: $l'),
        (r) => expect(r, [testWatchlistMovie]),
      );
    });
  });
}
