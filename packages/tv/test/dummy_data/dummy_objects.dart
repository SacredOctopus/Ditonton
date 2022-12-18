import 'package:core/data/models/genre_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTv = Tv(
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  popularity: 47.432451,
  id: 31917,
  backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
  voteAverage: 5.04,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  firstAirDate: "2010-06-08",
  originCountry: const ["US"],
  genresId: const [18, 9648],
  originalLanguage: "en",
  voteCount: 133,
  name: "Pretty Little Liars",
  title: "Pretty Little Liars",
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
  genres: [Genre(id: 10765, name: "Sci-Fi & Fantasy")],
  id: 1399,
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  title: "Game of Thrones",
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  popularity: 369.594,
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  status: "Ended",
  voteAverage: 8.3,
  voteCount: 11504,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTvCache = TvTable(
  id: 1399,
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  title: 'Game Of Thrones',
);

final testTvCacheMap = {
  "id": 1399,
  "overview":
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  "posterPath": "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  "title": 'Game Of Thrones',
};

final testTvFromCache = Tv.watchlist(
  id: 1399,
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  title: 'Game Of Thrones',
);

const testTvModel = TvModel(
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  popularity: 47.432451,
  id: 31917,
  backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
  voteAverage: 5.04,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  firstAirDate: "2010-06-08",
  originCountry: ["US"],
  genresId: [18, 9648],
  originalLanguage: "en",
  voteCount: 133,
  name: "Pretty Little Liars",
  title: "Pretty Little Liars",
);

const testTvResponseModel = TvResponse(tvList: <TvModel>[testTvModel]);

final testTvResponseModelMap = {
  "results": [
    {
      "poster_path": "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
      "popularity": 47.432451,
      "id": 31917,
      "backdrop_path": "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
      "vote_average": 5.04,
      "overview":
          "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
      "first_air_date": "2010-06-08",
      "origin_country": ["US"],
      "genre_ids": [18, 9648],
      "original_language": "en",
      "vote_count": 133,
      "name": "Pretty Little Liars",
      "title": "Pretty Little Liars"
    }
  ]
};

const testTvDetailResponse = TvDetailResponse(
  backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
  genres: [GenreModel(id: 10765, name: "Sci-Fi & Fantasy")],
  id: 1399,
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  title: "Game of Thrones",
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  popularity: 369.594,
  posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  status: "Ended",
  voteAverage: 8.3,
  voteCount: 11504,
  episodeRunTime: [60],
  firstAirDate: "2011-04-17",
  homepage: "http://www.hbo.com/game-of-thrones",
  inProduction: false,
  languages: ["en"],
  lastAirDate: "2019-05-19",
  name: "Game of Thrones",
  nextEpisodeToAir: false,
  originalLanguage: 'en',
  originCountry: ["US"],
  tagline: "Winter Is Coming",
  type: 'script',
);

final testTvDetailResponseMap = {
  'backdrop_path': '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
  'episode_run_time': [60],
  'first_air_date': '2011-04-17',
  'genres': [
    {'id': 10765, 'name': 'Sci-Fi & Fantasy'}
  ],
  'homepage': 'http://www.hbo.com/game-of-thrones',
  'id': 1399,
  'in_production': false,
  'languages': ['en'],
  'last_air_date': '2019-05-19',
  'name': 'Game of Thrones',
  'next_episode_to_air': false,
  'number_of_episodes': 73,
  'number_of_seasons': 8,
  'origin_country': ['US'],
  'original_language': 'en',
  'original_name': 'Game of Thrones',
  'overview':
      'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  'popularity': 369.594,
  'poster_path': '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  'status': 'Ended',
  'tagline': 'Winter Is Coming',
  'type': 'script',
  'vote_average': 8.3,
  'vote_count': 11504
};
