import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';

class TvSeriesTable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;

  TvSeriesTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tv) => TvSeriesTable(
    id: tv.id,
    name: tv.name,
    overview: tv.overview,
    posterPath: tv.posterPath,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'overview': overview,
    'posterPath': posterPath,
  };

  TvSeries toEntity() => TvSeries.watchList(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
    id: map['id'],
    name: map['name'],
    overview: map['overview'],
    posterPath: map['posterPath'],
  );
}
