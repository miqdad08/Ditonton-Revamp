import 'package:ditonton_revamp/feature/movie/data/models/genre_model.dart';
import 'package:ditonton_revamp/feature/movie/data/models/movie_detail_model.dart';
import 'package:ditonton_revamp/feature/movie/data/models/movie_model.dart';
import 'package:ditonton_revamp/feature/movie/data/models/movie_table.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/genre.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/movie.dart';
import 'package:ditonton_revamp/feature/movie/domain/entities/movie_detail.dart';

/// =========================
/// MovieModel & Movie Entity
/// =========================
final tMovieModel = MovieModel(
  adult: false,
  backdropPath: "/path.jpg",
  genreIds: [1, 2, 3, 4],
  id: 1,
  originalTitle: "Original Title",
  overview: "Overview",
  popularity: 1.0,
  posterPath: "/path.jpg",
  releaseDate: "2020-05-05",
  title: "Title",
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

final tMovie = tMovieModel.toEntity();
final tMovieModelList = <MovieModel>[tMovieModel];
final tMovieList = <Movie>[tMovie];

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

/// =====================
/// MovieDetail Model & Entity
/// =====================

final testMovieDetailModel = MovieDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  budget: 100,
  genres: [GenreModel(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  imdbId: 'imdb1',
  originalLanguage: 'en',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  revenue: 12000,
  runtime: 120,
  status: 'Status',
  tagline: 'Tagline',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

final testMovieDetail = MovieDetail(
  id: 1,
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

/// ==============
/// MovieTable
/// ==============

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

/// ==============
/// Map Dummies
/// ==============

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testMovieListMap = {
  "results": [
    {
      "adult": false,
      "backdrop_path": "/backdrop.jpg",
      "genre_ids": [28, 12],
      "id": 1,
      "original_title": "Spider-Man",
      "overview": "Test overview...",
      "popularity": 150.0,
      "poster_path": "/path.jpg",
      "release_date": "2020-12-01",
      "title": "Spider-Man",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 1000
    }
  ]
};

final testMovieModelList = [
  MovieModel(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [28, 12],
    id: 1,
    originalTitle: 'Spider-Man',
    overview: 'Test overview...',
    popularity: 150.0,
    posterPath: '/path.jpg',
    releaseDate: '2020-12-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.5,
    voteCount: 1000,
  ),
];


final testMovieModel = MovieModel(
  id: 1,
  title: 'Spider-Man',
  overview: 'Test overview...',
  releaseDate: '2020-12-01',
  genreIds: [28, 12],
  voteAverage: 7.5,
  voteCount: 1000,
  posterPath: '/path.jpg',
  backdropPath: '/backdrop.jpg',
  popularity: 150.0,
  adult: false,
  video: false,
  originalTitle: 'Spider-Man',
);

// final testMovieModelList = [testMovieModel];

// final testMovieListMap = {
//   'results': testMovieModelList.map((movie) => movie.toJson()).toList(),
// };

final testMovieDetailMap = testMovieDetailModel.toJson(); // dari MovieDetailModel
