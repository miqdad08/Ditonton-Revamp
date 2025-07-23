import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton_revamp/feature/tv_series/domain/entities/tv_series.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    id: 1,
    name: 'Breaking Bad',
    overview: 'A high school chemistry teacher turned methamphetamine producer.',
    posterPath: '/bbPoster.jpg',
  );

  const tTvSeries = TvSeries(
    id: 1,
    name: 'Breaking Bad',
    overview: 'A high school chemistry teacher turned methamphetamine producer.',
    posterPath: '/bbPoster.jpg',
  );

  final tTvSeriesJson = {
    'id': 1,
    'name': 'Breaking Bad',
    'overview': 'A high school chemistry teacher turned methamphetamine producer.',
    'poster_path': '/bbPoster.jpg',
  };

  group('TvSeriesModel', () {
    test('fromJson should return valid model', () {
      final result = TvSeriesModel.fromJson(tTvSeriesJson);
      expect(result, tTvSeriesModel);
    });

    test('toJson should return correct map', () {
      final result = tTvSeriesModel.toJson();
      expect(result, tTvSeriesJson);
    });

    test('toEntity should return correct TvSeries entity', () {
      final result = tTvSeriesModel.toEntity();
      expect(result, tTvSeries);
    });

    test('props should contain correct values for equality check', () {
      final other = const TvSeriesModel(
        id: 1,
        name: 'Breaking Bad',
        overview: 'A high school chemistry teacher turned methamphetamine producer.',
        posterPath: '/bbPoster.jpg',
      );
      expect(tTvSeriesModel, other);
    });
  });
}
