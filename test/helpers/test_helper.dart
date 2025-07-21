import 'package:ditonton_revamp/common/dio_client.dart';
import 'package:ditonton_revamp/config/db/db_helper.dart';
import 'package:ditonton_revamp/feature/movie/data/data_sources/movie_local_data_source.dart';
import 'package:ditonton_revamp/feature/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';

import 'package:ditonton_revamp/feature/movie/domain/repositories/movie_repository.dart';

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    DatabaseHelper,
    DioClient,
  ],
  customMocks: [MockSpec<Dio>(as: #MockDio)],
)

void main() {}
