import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../add_remove_tv_watchlist_bloc/add_remove_tv_watchlist_bloc.dart';
import '../pages/tv_series_detail_page.dart';

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tv;
  final List<TvSeries> recommendations;

  const DetailContent(this.tv, this.recommendations, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${tv.posterPath}',
          width: screenWidth,
          placeholder: (_, __) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 56),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tv.name, style: kHeading5),
                            const SizedBox(height: 8),
                            _buildWatchlistButton(context),
                            const SizedBox(height: 8),
                            Text(_showGenres(tv.genres)),
                            Text(_showDuration(tv.runtime)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (_, __) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(' ${tv.voteAverage.toStringAsFixed(1)}'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tv.overview),
                            const SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            _buildRecommendations(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 4,
                        width: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWatchlistButton(BuildContext context) {
    return BlocBuilder<AddRemoveTvWatchlistBloc, AddRemoveTvWatchlistState>(
      builder: (context, state) {
        if (state is AddRemoveWatchlistHasData) {
          return FilledButton.icon(
            onPressed: () {
              final isInWatchlist = state.isInWatchlist;
              context.read<AddRemoveTvWatchlistBloc>().add(
                isInWatchlist
                    ? OnRemoveTvSeriesWatchlist(tv)
                    : OnAddTvSeriesWatchlist(tv),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 500),
                  content: Text(
                    isInWatchlist
                        ? 'Removed from watchlist'
                        : 'Added to watchlist',
                  ),
                ),
              );
            },
            icon: Icon(state.isInWatchlist ? Icons.check : Icons.add),
            label: const Text('Watchlist'),
          );
        } else if (state is AddRemoveWatchlistError) {
          Future.microtask(() {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(content: Text(state.message)),
            );
          });
        }

        return ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Watchlist'),
        );
      },
    );
  }

  Widget _buildRecommendations() {
    if (recommendations.isEmpty) {
      return const Text('No Recommendations');
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final rec = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                context.pushReplacementNamed(
                  TvSeriesDetailPage.routeName,
                  extra: rec.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${rec.posterPath}',
                  placeholder: (_, __) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _showGenres(List<Genre> genres) =>
      genres.map((g) => g.name).join(', ');

  String _showDuration(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }
}
