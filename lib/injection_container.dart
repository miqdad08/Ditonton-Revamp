import 'package:get_it/get_it.dart';

import 'common/dio_client.dart';
import 'config/db/db_helper.dart';
import 'feature/movie/data/data_sources/movie_local_data_source.dart';
import 'feature/movie/data/data_sources/movie_remote_data_source.dart';
import 'feature/movie/data/repositories/movie_repository_impl.dart';
import 'feature/movie/domain/repositories/movie_repository.dart';
import 'feature/movie/domain/usecases/get_movie_detail.dart';
import 'feature/movie/domain/usecases/get_movie_recommendations.dart';
import 'feature/movie/domain/usecases/get_now_playing_movies.dart';
import 'feature/movie/domain/usecases/get_popular_movies.dart';
import 'feature/movie/domain/usecases/get_top_rated_movies.dart';
import 'feature/movie/domain/usecases/get_watchlist_movies.dart';
import 'feature/movie/domain/usecases/get_watchlist_status.dart';
import 'feature/movie/domain/usecases/remove_watchlist.dart';
import 'feature/movie/domain/usecases/save_watchlist.dart';
import 'feature/movie/domain/usecases/search_movies.dart';
import 'feature/movie/presentation/movie_detail_bloc/movie_detail_bloc.dart';
import 'feature/movie/presentation/movie_search_bloc/movie_search_bloc.dart';
import 'feature/movie/presentation/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'feature/movie/presentation/popular_movies_bloc/popular_movies_bloc.dart';
import 'feature/movie/presentation/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'feature/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'feature/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'feature/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'feature/tv_series/domain/repositories/tv_series_repository.dart';
import 'feature/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'feature/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'feature/tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'feature/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'feature/tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'feature/tv_series/domain/usecases/get_tv_series_watchlist_status.dart';
import 'feature/tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'feature/tv_series/domain/usecases/remove_tv_series_watchlist.dart';
import 'feature/tv_series/domain/usecases/save_tv_series_watchlist.dart';
import 'feature/tv_series/domain/usecases/search_tv_series.dart';
import 'feature/tv_series/presentation/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'feature/tv_series/presentation/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';
import 'feature/tv_series/presentation/tv_detail_bloc/tv_detail_bloc.dart';
import 'feature/tv_series/presentation/tv_series_search_bloc/tv_series_search_bloc.dart';
import 'feature/tv_series/presentation/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:dio/dio.dart';
import 'package:ditonton_revamp/feature/movie/presentation/add_remove_watchlist_bloc/add_remove_watchlist_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/add_remove_tv_watchlist_bloc/add_remove_tv_watchlist_bloc.dart';

import 'package:ditonton_revamp/feature/tv_series/presentation/on_the_air_tv_series_bloc/on_the_air_tv_series_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {

  ///Bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));

  locator.registerFactory(() {
    return MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    );
  });

  locator.registerFactory(
    () => AddRemoveWatchlistBloc(
      getMovieWatchListStatus: locator(),
      saveMovieWatchlist: locator(),
      removeMovieWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => WatchlistMovieBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));

  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => OnTheAirTvSeriesBloc(locator()));

  locator.registerFactory(
    () => TvDetailBloc(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => AddRemoveTvWatchlistBloc(
      getTvSeriesWatchListStatus: locator(),
      saveTvSeriesWatchlist: locator(),
      removeTvSeriesWatchlist: locator(),
    ),
  );

  locator.registerFactory(() => WatchlistTvSeriesBloc(locator()));

  locator.registerFactory(() => TvSeriesSearchBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  /// repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /// data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(dio: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(dio: locator()),
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // dio
  locator.registerLazySingleton<DioClient>(() => DioClient(locator<Dio>()));
  locator.registerLazySingleton<Dio>(() => Dio());
}
