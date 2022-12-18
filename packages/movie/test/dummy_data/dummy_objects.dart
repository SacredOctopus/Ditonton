import 'package:core/data/models/genre_model.dart';
import 'package:movie/data/models/movie_detail_model.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: "/path.jpg",
  genreIds: const [1, 2, 3, 4],
  id: 1,
  originalTitle: 'Original Title',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: "/path.jpg",
  releaseDate: '2020-05-05',
  title: 'Title',
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testMovieCache = MovieTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testMovieModel = MovieModel(
  adult: false,
  backdropPath: "/path.jpg",
  genreIds: [1, 2, 3, 4],
  id: 1,
  originalTitle: 'Original Title',
  overview: 'Overview',
  popularity: 1.0,
  posterPath: "/path.jpg",
  releaseDate: '2020-05-05',
  title: 'Title',
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);
const testMovieResponseModel =
    MovieResponse(movieList: <MovieModel>[testMovieModel]);

const testMovieResponseModelMap = {
  "results": [
    {
      "adult": false,
      "backdrop_path": "/path.jpg",
      "genre_ids": [1, 2, 3, 4],
      "id": 1,
      "original_title": "Original Title",
      "overview": "Overview",
      "popularity": 1.0,
      "poster_path": "/path.jpg",
      "release_date": "2020-05-05",
      "title": "Title",
      "video": false,
      "vote_average": 1.0,
      "vote_count": 1
    }
  ],
};

const testMovieDetailResponse = MovieDetailResponse(
  adult: false,
  backdropPath: "/path.jpg",
  budget: 100,
  genres: [GenreModel(id: 1, name: "Action")],
  homepage: "https://google.com",
  id: 1,
  imdbId: "imdb1",
  originalLanguage: "en",
  originalTitle: "OriginalTitle",
  overview: "Overview",
  popularity: 1.0,
  posterPath: "/path.jpg",
  releaseDate: "2020-05-05",
  revenue: 12000,
  runtime: 120,
  status: "Status",
  tagline: "Tagline",
  title: "Title",
  video: false,
  voteAverage: 1.0,
  voteCount: 1,
);

const testMovieDetailResponseMap = {
  'adult': false,
  'backdrop_path': '/path.jpg',
  'budget': 100,
  'genres': [
    {'id': 1, 'name': 'Action'}
  ],
  'homepage': 'https://google.com',
  'id': 1,
  'imdb_id': 'imdb1',
  'original_language': 'en',
  'original_title': 'OriginalTitle',
  'overview': 'Overview',
  'popularity': 1.0,
  'poster_path': '/path.jpg',
  'release_date': '2020-05-05',
  'revenue': 12000,
  'runtime': 120,
  'status': 'Status',
  'tagline': 'Tagline',
  'title': 'Title',
  'video': false,
  'vote_average': 1.0,
  'vote_count': 1
};
