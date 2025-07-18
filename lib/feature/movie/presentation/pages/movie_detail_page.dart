import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../movie_detail_bloc/movie_detail_bloc.dart';
import '../movie_detail_bloc/movie_detail_event.dart';
import '../movie_detail_bloc/movie_detail_state.dart';
import '../widgets/detail_content.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.message.isNotEmpty) {
            return Center(child: Text(state.message));
          } else if (state.movie != null) {
            return SafeArea(
              child: DetailContent(
                movie: state.movie!,
                recommendations: state.recommendations,
                isAddedToWatchlist: state.isAddedToWatchlist,
                watchlistMessage: state.watchlistMessage,
                onWatchlistTap: () {
                  if (state.isAddedToWatchlist) {
                    context.read<MovieDetailBloc>().add(
                      RemoveFromWatchlist(state.movie!),
                    );
                  } else {
                    context.read<MovieDetailBloc>().add(
                      AddToWatchlist(state.movie!),
                    );
                  }
                },
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        },
      ),
    );
  }
}
