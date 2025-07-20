// import 'dart:io';
//
// import 'package:ditonton_revamp/common/failure.dart';
// import 'package:ditonton_revamp/feature/movie/data/repositories/movie_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
//
// import '../../../dummy_data/dummy_objects.dart';
// import '../../../helpers/test_helper.mocks.dart';
//
// void main() {
//   late MovieRepositoryImpl repository;
//   late MockMovieRemoteDataSource mockRemoteDataSource;
//   late MockMovieLocalDataSource mockLocalDataSource;
//
//   setUp(() {
//     mockRemoteDataSource = MockMovieRemoteDataSource();
//     mockLocalDataSource = MockMovieLocalDataSource();
//     repository = MovieRepositoryImpl(
//       remoteDataSource: mockRemoteDataSource,
//       localDataSource: mockLocalDataSource,
//     );
//   });
//
//   group('Get Now Playing Movies', () {
//     test(
//       'should return movie list when call to data source is successful',
//           () async {
//         // arrange
//         when(
//           mockRemoteDataSource.getNowPlayingMovies(),
//         ).thenAnswer((_) async => tMovieModelList);
//
//         // act
//         final result = await repository.getNowPlayingMovies();
//
//         // assert
//         result.match(
//               (l) => fail('Expected success but got failure: $l'),
//               (r) => expect(r, tMovieList),
//         );
//       },
//     );
//
//     test(
//       'should return ConnectionFailure when device is not connected to internet',
//           () async {
//         // arrange
//         when(
//           mockRemoteDataSource.getNowPlayingMovies(),
//         ).thenThrow(const SocketException('Failed to connect'));
//
//         // act
//         final result = await repository.getNowPlayingMovies();
//
//         // assert
//         expect(result.isLeft(), true);
//         result.match(
//               (l) => expect(l, isA<ConnectionFailure>()),
//               (r) => fail('Expected failure but got success'),
//         );
//       },
//     );
//   });
//
//   group('Get Movie Detail', () {
//     test('should return movie detail when call is successful', () async {
//       // arrange
//       when(
//         mockRemoteDataSource.getMovieDetail(1),
//       ).thenAnswer((_) async => testMovieDetailModel);
//
//       // act
//       final result = await repository.getMovieDetail(1);
//
//       // assert
//       result.match(
//             (l) => fail('Expected success but got failure: $l'),
//             (r) => expect(r, testMovieDetail),
//       );
//     });
//   });
//
//   group('Get Recommendations', () {
//     test('should return list of movies when call is successful', () async {
//       // arrange
//       when(
//         mockRemoteDataSource.getMovieRecommendations(1),
//       ).thenAnswer((_) async => tMovieModelList);
//
//       // act
//       final result = await repository.getMovieRecommendations(1);
//
//       // assert
//       result.match(
//             (l) => fail('Expected success but got failure: $l'),
//             (r) => expect(r, tMovieList),
//       );
//     });
//   });
//
//   group('Watchlist', () {
//     test('should return success message when saving watchlist', () async {
//       // arrange
//       when(
//         mockLocalDataSource.insertWatchlist(testMovieTable),
//       ).thenAnswer((_) async => 'Added to Watchlist');
//
//       // act
//       final result = await repository.saveWatchlist(testMovieDetail);
//
//       // assert
//       result.match(
//             (l) => fail('Expected success but got failure: $l'),
//             (r) => expect(r, 'Added to Watchlist'),
//       );
//     });
//
//     test('should return success message when removing watchlist', () async {
//       // arrange
//       when(
//         mockLocalDataSource.removeWatchlist(testMovieTable),
//       ).thenAnswer((_) async => 'Removed from Watchlist');
//
//       // act
//       final result = await repository.removeWatchlist(testMovieDetail);
//
//       // assert
//       result.match(
//             (l) => fail('Expected success but got failure: $l'),
//             (r) => expect(r, 'Removed from Watchlist'),
//       );
//     });
//
//     test('should return true when movie is in watchlist', () async {
//       // arrange
//       when(
//         mockLocalDataSource.getMovieById(1),
//       ).thenAnswer((_) async => testMovieTable);
//
//       // act
//       final result = await repository.isAddedToWatchlist(1);
//
//       // assert
//       expect(result, true);
//     });
//
//     test('should return false when movie is not in watchlist', () async {
//       // arrange
//       when(mockLocalDataSource.getMovieById(1)).thenAnswer((_) async => null);
//
//       // act
//       final result = await repository.isAddedToWatchlist(1);
//
//       // assert
//       expect(result, false);
//     });
//
//     test('should return watchlist movies', () async {
//       // arrange
//       when(
//         mockLocalDataSource.getWatchlistMovies(),
//       ).thenAnswer((_) async => [testMovieTable]);
//
//       // act
//       final result = await repository.getWatchlistMovies();
//
//       // assert
//       result.match(
//             (l) => fail('Expected success but got failure: $l'),
//             (r) => expect(r, [testWatchlistMovie]),
//       );
//     });
//   });
// }

import 'dart:io';

import 'package:ditonton_revamp/common/exception.dart';
import 'package:ditonton_revamp/common/failure.dart';
import 'package:ditonton_revamp/feature/movie/data/models/genre_model.dart';
import 'package:ditonton_revamp/feature/movie/data/models/movie_detail_model.dart';
import 'package:ditonton_revamp/feature/movie/data/models/movie_model.dart';
import 'package:ditonton_revamp/feature/movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
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

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getNowPlayingMovies(),
        ).thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<Movie> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tMovieList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getNowPlayingMovies(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(result.isLeft(), true);
        result.match((l) {
          expect(l, isA<ServerFailure>());
          expect((l as ServerFailure).message, 'Server error');
        }, (r) => fail('Should not return success'));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getNowPlayingMovies(),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Popular Movies', () {
    test(
      'should return movie list when call to data source is success',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getPopularMovies(),
        ).thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getPopularMovies();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<Movie> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tMovieList);
      },
    );

    test(
      'should return server failure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getPopularMovies(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getPopularMovies();
        // assert
        expect(result.isLeft(), true);
        result.match((l) {
          expect(l, isA<ServerFailure>());
          expect((l as ServerFailure).message, 'Server error');
        }, (r) => fail('Should not return success'));
      },
    );

    test(
      'should return connection failure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getPopularMovies(),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getPopularMovies();
        // assert
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Top Rated Movies', () {
    test(
      'should return movie list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTopRatedMovies(),
        ).thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<Movie> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tMovieList);
      },
    );

    test(
      'should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTopRatedMovies(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        expect(result.isLeft(), true);
        result.match((l) {
          expect(l, isA<ServerFailure>());
          expect((l as ServerFailure).message, 'Server error');
        }, (r) => fail('Should not return success'));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTopRatedMovies(),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
      'should return Movie data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenAnswer((_) async => tMovieResponse);
        // act
        final result = await repository.getMovieDetail(tId);
        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, equals(Right(testMovieDetail)));
      },
    );

    test(
      'should return Server Failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getMovieDetail(tId);
        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result.isLeft(), true);
        result.match((l) {
          expect(l, isA<ServerFailure>());
          expect((l as ServerFailure).message, 'Server error');
        }, (r) => fail('Should not return success'));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMovieDetail(tId);
        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      late List<Movie> resultList;

      result.match((l) => resultList = [], (r) => resultList = r);

      expect(resultList, equals(tMovieList));
    });

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieRecommendations(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assertbuild runner
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(result.isLeft(), true);
        result.match((l) {
          expect(l, isA<ServerFailure>());
          expect(
            (l as ServerFailure).message,
            'Server error',
          ); // Sesuaikan jika message dummy berbeda
        }, (_) => fail('Expected a ServerFailure'));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieRecommendations(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Seach Movies', () {
    final tQuery = 'spiderman';

    test(
      'should return movie list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        late List<Movie> resultList;

        result.match((l) => resultList = [], (r) => resultList = r);
        expect(resultList, tMovieList);
      },
    );

    test(
      'should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenThrow(ServerException());
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        expect(result.isLeft(), true);
        result.match((l) {
          expect(l, isA<ServerFailure>());
          expect(
            (l as ServerFailure).message,
            'Server error',
          ); // Sesuaikan jika message dummy berbeda
        }, (_) => fail('Expected a ServerFailure'));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.searchMovies(tQuery);
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
        mockLocalDataSource.insertWatchlist(testMovieTable),
      ).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testMovieTable),
      ).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testMovieTable),
      ).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testMovieTable),
      ).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlistMovies(),
      ).thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      late List<Movie> resultList;

      result.match((l) => resultList = [], (r) => resultList = r);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}
