import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_series_detail.dart';
import 'genre_model.dart';

class TvSeriesDetailModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<GenreTvModel> genres;
  final List<int> episodeRunTime;

  const TvSeriesDetailModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genres,
    required this.episodeRunTime,
  });

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesDetailModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      genres: List<GenreTvModel>.from(
        json['genres'].map((x) => GenreTvModel.fromJson(x)),
      ),
      episodeRunTime: List<int>.from(json['episode_run_time']),
    );
  }

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      genres: genres.map((g) => g.toEntity()).toList(),
      runtime: episodeRunTime.isNotEmpty ? episodeRunTime.first : 0,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath,
    voteAverage,
    genres,
    episodeRunTime,
  ];
}
