import 'package:ditonton_revamp/common/dio_client.dart';
import 'package:ditonton_revamp/config/db/db_helper.dart';
import 'package:ditonton_revamp/feature/movie/data/data_sources/movie_local_data_source.dart';
import 'package:ditonton_revamp/feature/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:ditonton_revamp/feature/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton_revamp/feature/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

import 'package:ditonton_revamp/feature/movie/domain/repositories/movie_repository.dart';

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    TvSeriesRepository,
    TvSeriesRemoteDataSource,
    TvSeriesLocalDataSource,
    DatabaseHelper,
    DioClient,
  ],
  customMocks: [MockSpec<Dio>(as: #MockDio)],
)
void main() {}
