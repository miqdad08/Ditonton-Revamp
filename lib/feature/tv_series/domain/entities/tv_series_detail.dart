import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<Genre> genres;
  final int runtime;

  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
    required this.runtime,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        voteAverage,
        genres,
        runtime,
      ];
}
