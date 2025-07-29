import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils.dart';
import '../watchlist_movie_bloc/watchlist_movie_bloc.dart';
import '../watchlist_movie_bloc/watchlist_movie_event.dart';
import '../watchlist_movie_bloc/watchlist_movie_state.dart';
import '../widgets/movie_card_list.dart';
import 'movie_detail_page.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.message.isNotEmpty) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state.watchlistMovies.isEmpty) {
              return const Center(child: Text('Watchlist masih kosong'));
            } else {
              return ListView.builder(
                itemCount: state.watchlistMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.watchlistMovies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () {
                      context.pushNamed(
                        MovieDetailPage.routeName,
                        extra: movie.id,
                      ).then((value){
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies());
                        });
                      });
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
