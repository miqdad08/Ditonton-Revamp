import 'package:ditonton_revamp/feature/movie/presentation/pages/search_movie_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/top_rated_movies_bloc/top_rated_movies_bloc.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton_revamp/feature/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton_revamp/feature/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../../../tv_series/presentation/pages/watchlist_tv_series_page.dart';
import '../widgets/movie_list.dart';
import 'about_page.dart';
import '../now_playing_movies_bloc/now_playing_movies_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const String routeName = "home-movie-page";

  const HomeMoviePage({super.key});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(color: Colors.grey.shade900),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                context.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                context.pushNamed(HomeTvSeriesPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movies'),
              onTap: () {
                context.pushNamed(WatchlistMoviesPage.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.watch_later),
              title: Text('Watchlist Tv Series'),
              onTap: () {
                context.pushNamed(WatchlistTvSeriesPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                context.pushNamed(AboutPage.routeName);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(SearchMoviePage.routeName);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => throw Exception('Test Crash!'),
                child: const Text("Throw Test Exception"),
              ),
              Text('Now Playing', style: kHeading6),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NowPlayingMoviesLoaded) {
                    return MovieList(state.movies);
                  } else if (state is NowPlayingMoviesError) {
                    return Text(state.message);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => context.pushNamed(PopularMoviesPage.routeName),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PopularMoviesLoaded) {
                    return MovieList(state.movies);
                  } else if (state is PopularMoviesError) {
                    return Text(state.message);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => context.pushNamed(TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedMoviesLoaded) {
                    return MovieList(state.movies);
                  } else if (state is TopRatedMoviesError) {
                    return Text(state.message);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
