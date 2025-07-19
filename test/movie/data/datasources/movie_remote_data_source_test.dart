import 'package:dio/dio.dart';
import 'package:ditonton_revamp/common/api_endpoint.dart';
import 'package:ditonton_revamp/common/exception.dart';
import 'package:ditonton_revamp/feature/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = MovieRemoteDataSourceImpl(dio: mockDioClient);
  });

  group('get now playing movies', () {
    test('should return list of MovieModel when call to Dio is successful', () async {
      when(mockDioClient.get(ApiEndpoint.nowPlayingMovies)).thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: testMovieListMap,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getNowPlayingMovies();

      expect(result, equals(testMovieModelList));
    });

    test('should throw ServerException when Dio throws error', () async {
      when(mockDioClient.get(ApiEndpoint.nowPlayingMovies))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final call = dataSource.getNowPlayingMovies();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular movies', () {
    test('should return list of MovieModel when call is successful', () async {
      when(mockDioClient.get(ApiEndpoint.popularMovies)).thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: testMovieListMap,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getPopularMovies();

      expect(result, equals(testMovieModelList));
    });

    test('should throw ServerException on error', () async {
      when(mockDioClient.get(ApiEndpoint.popularMovies))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final call = dataSource.getPopularMovies();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated movies', () {
    test('should return list of MovieModel when call is successful', () async {
      when(mockDioClient.get(ApiEndpoint.topRatedMovies)).thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: testMovieListMap,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getTopRatedMovies();

      expect(result, equals(testMovieModelList));
    });

    test('should throw ServerException on error', () async {
      when(mockDioClient.get(ApiEndpoint.topRatedMovies))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final call = dataSource.getTopRatedMovies();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;

    test('should return MovieDetailModel when call is successful', () async {
      when(mockDioClient.get(ApiEndpoint.movieDetail(tId))).thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: testMovieDetailMap,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getMovieDetail(tId);

      expect(result, equals(testMovieDetailModel));
    });

    test('should throw ServerException on error', () async {
      when(mockDioClient.get(ApiEndpoint.movieDetail(tId)))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final call = dataSource.getMovieDetail(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    const tId = 1;

    test('should return list of MovieModel when call is successful', () async {
      when(mockDioClient.get(ApiEndpoint.movieRecommendations(tId))).thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: testMovieListMap,
          statusCode: 200,
        ),
      );

      final result = await dataSource.getMovieRecommendations(tId);

      expect(result, equals(testMovieModelList));
    });

    test('should throw ServerException on error', () async {
      when(mockDioClient.get(ApiEndpoint.movieRecommendations(tId)))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final call = dataSource.getMovieRecommendations(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    const query = 'Avengers';

    test('should return list of MovieModel when call is successful', () async {
      when(mockDioClient.get(ApiEndpoint.searchMovies, queryParameters: {'query': query}))
          .thenAnswer(
            (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: testMovieListMap,
          statusCode: 200,
        ),
      );

      final result = await dataSource.searchMovies(query);

      expect(result, equals(testMovieModelList));
    });

    test('should throw ServerException on error', () async {
      when(mockDioClient.get(ApiEndpoint.searchMovies, queryParameters: {'query': query}))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final call = dataSource.searchMovies(query);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
