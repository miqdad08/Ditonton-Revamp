class ApiEndpoint {
  static String baseUrl = "https://api.themoviedb.org/3";
  static String apiKey = "api_key=2174d146bb9c0eab47529b2e77d6b526";
  static final nowPlayingMovies = '$baseUrl/movie/now_playing?$apiKey';
  static final popularMovies = '$baseUrl/movie/popular?$apiKey';
  static final topRatedMovies = '$baseUrl/movie/top_rated?$apiKey';

  static String movieDetail(int id) => '$baseUrl/movie/$id?$apiKey';

  static String movieRecommendations(int id) => '$baseUrl/movie/$id/recommendations?$apiKey';
  static final searchMovies = '$baseUrl/search/movie?$apiKey';
}
