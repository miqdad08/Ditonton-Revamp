import 'package:ditonton_revamp/feature/movie/presentation/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/constants.dart';
import 'config/routes.dart';
import 'feature/movie/presentation/now_playing_movies_bloc/now_playing_movies_bloc.dart';
import 'feature/movie/presentation/popular_movies_bloc/popular_movies_bloc.dart';
import 'feature/movie/presentation/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
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
        BlocProvider(create: (_) => locator<WatchlistMovieBloc>()),
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
