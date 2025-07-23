import 'dart:convert';

import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    posterPath: "/fAvlT0rYOaMIzxdjVd6kGEXLMaL.jpg",
    id: 618,
    overview:
    "Bitten by a radioactive spider, Peter Parker uses his superpowers to fight crime across New York City while trying to maintain a normal life as a college student.",
    name: "Spider-Man: The Animated Series",
  );

  final tTvSeriesResponseModel = TvSeriesResponse(
    tvSeriesList: <TvSeriesModel>[tTvSeriesModel],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('dummy_data/on_the_air_tv_series.json'),
      );
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvSeriesResponseModel.toJson();
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/fAvlT0rYOaMIzxdjVd6kGEXLMaL.jpg",
            "id": 618,
            "overview":
            "Bitten by a radioactive spider, Peter Parker uses his superpowers to fight crime across New York City while trying to maintain a normal life as a college student.",
            "name": "Spider-Man: The Animated Series",
          },
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
