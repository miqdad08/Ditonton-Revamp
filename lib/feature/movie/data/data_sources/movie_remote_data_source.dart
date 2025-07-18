import 'package:dio/dio.dart';
import '../../../../common/api_endpoint.dart';
import '../../../../common/dio_client.dart';
import '../../../../common/exception.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailResponse> getMovieDetail(int id);

  Future<List<MovieModel>> getMovieRecommendations(int id);

  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final DioClient dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await dio.get(ApiEndpoint.nowPlayingMovies);
      return MovieResponse.fromJson(response.data).movieList;
    } on DioException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await dio.get(ApiEndpoint.popularMovies);
      return MovieResponse.fromJson(response.data).movieList;
    } on DioException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await dio.get(ApiEndpoint.topRatedMovies);
      return MovieResponse.fromJson(response.data).movieList;
    } on DioException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    try {
      final response = await dio.get(ApiEndpoint.movieDetail(id));
      return MovieDetailResponse.fromJson(response.data);
    } on DioException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    try {
      final response = await dio.get(ApiEndpoint.movieRecommendations(id));
      return MovieResponse.fromJson(response.data).movieList;
    } on DioException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await dio.get(
        ApiEndpoint.searchMovies,
        queryParameters: {'query': query},
      );
      return MovieResponse.fromJson(response.data).movieList;
    } on DioException catch (_) {
      throw ServerException();
    }
  }
}
