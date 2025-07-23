import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton_revamp/common/exception.dart';
import 'package:ditonton_revamp/feature/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_response.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';


void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = TvSeriesRemoteDataSourceImpl(dio: mockDioClient);
  });

  group('get On The Air TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/on_the_air_tv_series.json')),
    ).tvSeriesList;

    test('should return list of TV Series Model when the response code is 200', () async {
      // arrange
      when(mockDioClient.get(any)).thenAnswer((_) async => Response(
        data: json.decode(readJson('dummy_data/on_the_air_tv_series.json')),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      // act
      final result = await dataSource.getOnTheAirTvSeries();
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test('should throw ServerException when the response is error', () async {
      when(mockDioClient.get(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
      ));
      final call = dataSource.getOnTheAirTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/popular_tv_series.json')),
    ).tvSeriesList;

    test('should return list of TV Series Model when successful', () async {
      when(mockDioClient.get(any)).thenAnswer((_) async => Response(
        data: json.decode(readJson('dummy_data/popular_tv_series.json')),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await dataSource.getPopularTvSeries();
      expect(result, tTvSeriesList);
    });
  });

  group('get Top Rated TV Series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/top_rated_tv_series.json')),
    ).tvSeriesList;

    test('should return list of TV Series Model when successful', () async {
      when(mockDioClient.get(any)).thenAnswer((_) async => Response(
        data: json.decode(readJson('dummy_data/top_rated_tv_series.json')),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));
      final result = await dataSource.getTopRatedTvSeries();
      expect(result, tTvSeriesList);
    });
  });

  group('get TV Series Detail', () {
    const tId = 1;
    final tDetail = TvSeriesDetailModel.fromJson(
      json.decode(readJson('dummy_data/tv_series_detail.json')),
    );

    test('should return TV Series Detail when successful', () async {
      when(mockDioClient.get(any)).thenAnswer((_) async => Response(
        data: json.decode(readJson('dummy_data/tv_series_detail.json')),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.getTvSeriesDetail(tId);
      expect(result, tDetail);
    });
  });

  group('get TV Series Recommendations', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/tv_series_recommendations.json')),
    ).tvSeriesList;

    test('should return list of TV Series Recommendations when successful', () async {
      when(mockDioClient.get(any)).thenAnswer((_) async => Response(
        data: json.decode(readJson('dummy_data/tv_series_recommendations.json')),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.getTvSeriesRecommendations(1);
      expect(result, tTvSeriesList);
    });
  });

  group('search TV Series', () {
    final tQuery = "spiderman";
    final tSearchResult = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data/search_spiderman_tv_series.json')),
    ).tvSeriesList;

    test('should return search result list when successful', () async {
      when(mockDioClient.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
        data: json.decode(readJson('dummy_data/search_spiderman_tv_series.json')),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.searchTvSeries(tQuery);
      expect(result, tSearchResult);
    });
  });
}
