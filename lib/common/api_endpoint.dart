class ApiEndpoint {
  static String baseUrl = "https://api.themoviedb.org/3";
  static String apiKey = "api_key=2174d146bb9c0eab47529b2e77d6b526";
  static final nowPlayingMovies = '$baseUrl/movie/now_playing?$apiKey';
  static final popularMovies = '$baseUrl/movie/popular?$apiKey';
  static final topRatedMovies = '$baseUrl/movie/top_rated?$apiKey';

  static String movieDetail(int id) => '$baseUrl/movie/$id?$apiKey';

  static String movieRecommendations(int id) => '$baseUrl/movie/$id/recommendations?$apiKey';
  static final searchMovies = '$baseUrl/search/movie?$apiKey';

  // TV Series Endpoints
  static final String onTheAirTvSeries = '$baseUrl/tv/on_the_air?$apiKey';
  static final String popularTvSeries = '$baseUrl/tv/popular?$apiKey';
  static final String topRatedTvSeries = '$baseUrl/tv/top_rated?$apiKey';
  static String tvSeriesDetail(int id) => '$baseUrl/tv/$id?$apiKey';
  static String tvSeriesRecommendations(int id) => '$baseUrl/tv/$id/recommendations?$apiKey';
  static final String searchTvSeries = '$baseUrl/search/tv?$apiKey';

}
