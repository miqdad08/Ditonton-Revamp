import '../../../../common/type_defs.dart';
import '../entities/tv_series.dart';
import '../entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  FutureEither<List<TvSeries>> getPopularTvSeries();
  FutureEither<List<TvSeries>> getOnTheAirTvSeries();
  FutureEither<List<TvSeries>> getTopRatedTvSeries();
  FutureEither< TvSeriesDetail> getTvSeriesDetail(int id);
  FutureEither< List<TvSeries>> getTvSeriesRecommendations(int id);
  FutureEither< List<TvSeries>> searchTvSeries(String query);
  FutureEither< String> saveWatchlist(TvSeriesDetail movie);
  FutureEither< String> removeWatchlist(TvSeriesDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  FutureEither<List<TvSeries>> getWatchlistTvSeries();
}
