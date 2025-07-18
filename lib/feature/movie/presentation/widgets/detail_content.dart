import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/constants.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../pages/movie_detail_page.dart';

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;
  final String watchlistMessage;
  final VoidCallback onWatchlistTap;

  const DetailContent({
    super.key,
    required this.movie,
    required this.recommendations,
    required this.isAddedToWatchlist,
    required this.watchlistMessage,
    required this.onWatchlistTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Image.network(
          '$BASE_IMAGE_URL${movie.posterPath}',
          width: screenWidth,
          fit: BoxFit.cover,
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            initialChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: kHeading5),
                      FilledButton.icon(
                        onPressed: onWatchlistTap,
                        icon: Icon(
                          isAddedToWatchlist ? Icons.check : Icons.add,
                        ),
                        label: const Text('Watchlist'),
                      ),
                      Text('Genres: ${movie.genres.map((e) => e.name).join(', ')}'),
                      Text('Duration: ${_formatDuration(movie.runtime)}'),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: movie.voteAverage / 2,
                            itemCount: 5,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: kMikadoYellow,
                            ),
                            itemSize: 24,
                          ),
                          Text('${movie.voteAverage}')
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Overview', style: kHeading6),
                      Text(movie.overview),
                      const SizedBox(height: 16),
                      Text('Recommendations', style: kHeading6),
                      recommendations.isEmpty
                          ? const Text('No recommendations')
                          : SizedBox(
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
                                    MovieDetailPage.routeName,
                                    extra: rec.id,
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    '$BASE_IMAGE_URL${rec.posterPath}',
                                    width: 100,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDuration(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }
}
