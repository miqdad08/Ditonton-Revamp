import 'package:ditonton_revamp/feature/movie/presentation/pages/about_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/search_movie_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/watchlist_tv_series_page.dart';
import 'package:go_router/go_router.dart';

import '../feature/movie/presentation/pages/home_movie_page.dart';
import '../feature/tv_series/presentation/pages/popular_tv_series_page.dart';
import '../feature/tv_series/presentation/pages/tv_series_detail_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/${HomeMoviePage.routeName}",
        name: HomeMoviePage.routeName,
        builder: (context, state) {
          return const HomeMoviePage();
        },
      ),
      GoRoute(
        path: "/${AboutPage.routeName}",
        name: AboutPage.routeName,
        builder: (context, state) {
          return const AboutPage();
        },
      ),
      GoRoute(
        path: "/${PopularMoviesPage.routeName}",
        name: PopularMoviesPage.routeName,
        builder: (context, state) {
          return const PopularMoviesPage();
        },
      ),
      GoRoute(
        path: "/${TopRatedMoviesPage.routeName}",
        name: TopRatedMoviesPage.routeName,
        builder: (context, state) {
          return const TopRatedMoviesPage();
        },
      ),
      GoRoute(
        path: "/${SearchMoviePage.routeName}",
        name: SearchMoviePage.routeName,
        builder: (context, state) {
          return const SearchMoviePage();
        },
      ),
      GoRoute(
        path: "/${MovieDetailPage.routeName}",
        name: MovieDetailPage.routeName,
        builder: (context, state) {
          return MovieDetailPage(id: state.extra as int);
        },
      ),
      GoRoute(
        path: "/${WatchlistMoviesPage.routeName}",
        name: WatchlistMoviesPage.routeName,
        builder: (context, state) {
          return WatchlistMoviesPage();
        },
      ),

      GoRoute(
        path: "/${HomeTvSeriesPage.routeName}",
        name: HomeTvSeriesPage.routeName,
        builder: (context, state) {
          return const HomeTvSeriesPage();
        },
      ),
      GoRoute(
        path: "/${PopularTvSeriesPage.routeName}",
        name: PopularTvSeriesPage.routeName,
        builder: (context, state) {
          return const PopularTvSeriesPage();
        },
      ),
      GoRoute(
        path: "/${TopRatedTvSeriesPage.routeName}",
        name: TopRatedTvSeriesPage.routeName,
        builder: (context, state) {
          return const TopRatedTvSeriesPage();
        },
      ),
      GoRoute(
        path: "/${SearchTvSeriesPage.routeName}",
        name: SearchTvSeriesPage.routeName,
        builder: (context, state) {
          return const SearchTvSeriesPage();
        },
      ),
      GoRoute(
        path: "/${TvSeriesDetailPage.routeName}",
        name: TvSeriesDetailPage.routeName,
        builder: (context, state) {
          return TvSeriesDetailPage(id: state.extra as int);
        },
      ),
      GoRoute(
        path: "/${WatchlistTvSeriesPage.routeName}",
        name: WatchlistTvSeriesPage.routeName,
        builder: (context, state) {
          return WatchlistTvSeriesPage();
        },
      ),
    ],
    initialLocation: '/${HomeMoviePage.routeName}',
    debugLogDiagnostics: true,
  );
}
