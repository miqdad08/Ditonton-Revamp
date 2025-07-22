import 'package:dio/dio.dart';

import '../../../../common/api_endpoint.dart';
import '../../../../common/dio_client.dart';
import '../../../../common/exception.dart';
import '../models/tv_series_detail_model.dart';
import '../models/tv_series_model.dart';
import '../models/tv_series_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();

  Future<List<TvSeriesModel>> getPopularTvSeries();

  Future<List<TvSeriesModel>> getTopRatedTvSeries();

  Future<TvSeriesDetailModel> getTvSeriesDetail(int id);

  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);

  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final DioClient dio;

  TvSeriesRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    try {
      final response = await dio.get(ApiEndpoint.onTheAirTvSeries);
      return TvSeriesResponse.fromJson(response.data).tvSeriesList;
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    try {
      final response = await dio.get(ApiEndpoint.popularTvSeries);
      return TvSeriesResponse.fromJson(response.data).tvSeriesList;
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    try {
      final response = await dio.get(ApiEndpoint.topRatedTvSeries);
      return TvSeriesResponse.fromJson(response.data).tvSeriesList;
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id) async {
    try {
      final response = await dio.get(ApiEndpoint.tvSeriesDetail(id));
      return TvSeriesDetailModel.fromJson(response.data);
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    try {
      final response = await dio.get(ApiEndpoint.tvSeriesRecommendations(id));
      return TvSeriesResponse.fromJson(response.data).tvSeriesList;
    } on DioException {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoint.searchTvSeries,
        queryParameters: {'query': query},
      );
      return TvSeriesResponse.fromJson(response.data).tvSeriesList;
    } on DioException {
      throw ServerException();
    }
  }
}
