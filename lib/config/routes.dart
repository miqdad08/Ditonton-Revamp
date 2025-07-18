import 'package:ditonton_revamp/feature/movie/presentation/pages/about_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/search_movie_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:go_router/go_router.dart';

import '../feature/movie/presentation/pages/home_movie_page.dart';

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
    ],
    initialLocation: '/${HomeMoviePage.routeName}',
    debugLogDiagnostics: true,
  );
}
