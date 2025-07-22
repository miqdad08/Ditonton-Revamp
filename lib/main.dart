import 'package:ditonton_revamp/feature/movie/presentation/add_remove_watchlist_bloc/add_remove_watchlist_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/on_the_air_tv_series_bloc/on_the_air_tv_series_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/tv_series_search_bloc/tv_series_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/constants.dart';
import 'config/routes.dart';
import 'feature/movie/presentation/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'feature/movie/presentation/popular_movies_bloc/popular_movies_bloc.dart';
import 'feature/movie/presentation/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'feature/tv_series/presentation/add_remove_tv_watchlist_bloc/add_remove_tv_watchlist_bloc.dart';
import 'feature/tv_series/presentation/tv_detail_bloc/tv_detail_bloc.dart';
import 'feature/tv_series/presentation/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (_) => locator<PopularMoviesBloc>()),
        BlocProvider(create: (_) => locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => locator<MovieSearchBloc>()),
        BlocProvider(create: (_) => locator<AddRemoveWatchlistBloc>()),
        BlocProvider(create: (_) => locator<WatchlistMovieBloc>()),

        BlocProvider(create: (_) => locator<OnTheAirTvSeriesBloc>()),
        BlocProvider(create: (_) => locator<PopularTvSeriesBloc>()),
        BlocProvider(create: (_) => locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => locator<TvDetailBloc>()),
        BlocProvider(create: (_) => locator<TvSeriesSearchBloc>()),
        BlocProvider(create: (_) => locator<AddRemoveTvWatchlistBloc>()),
        BlocProvider(create: (_) => locator<WatchlistTvSeriesBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
      ),
    );
  }
}
