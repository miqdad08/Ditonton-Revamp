import 'package:ditonton_revamp/feature/movie/presentation/add_remove_watchlist_bloc/add_remove_watchlist_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_detail_bloc/movie_detail_bloc.dart';
import '../movie_detail_bloc/movie_detail_event.dart';
import '../movie_detail_bloc/movie_detail_state.dart';
import '../widgets/detail_content.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/movie-detail';

  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieDetailBloc>().add(OnFetchMovieDetail(widget.id));
      context.read<AddRemoveWatchlistBloc>().add(
        OnFetchMovieWatchlistStatus(widget.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (_, movieState) {
          if (movieState is MovieDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (movieState is MovieDetailHasData) {
            return SafeArea(
              child: Center(
                child: DetailContent(
                  movieState.movieDetail,
                  movieState.movieRecommendation,
                  // watchlistState.isInWatchlist,
                ),
              ),
            );
          } else if (movieState is MovieDetailError) {
            return Center(child: Text(movieState.message));
          } else {
            return Center(
              child: Icon(
                Icons.credit_card_off_sharp,
                size: 150,
                color: Color(0x34CECECE),
              ),
            );
          }
        },
      ),
    );
  }
}
