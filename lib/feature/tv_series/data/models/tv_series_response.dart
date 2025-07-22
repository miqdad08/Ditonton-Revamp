import 'package:ditonton_revamp/feature/tv_series/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvSeriesList;

  const TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesResponse(
      tvSeriesList: List<TvSeriesModel>.from(
        json["results"].map((x) => TvSeriesModel.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson()))};
  }

  @override
  List<Object?> get props => [tvSeriesList];
}
