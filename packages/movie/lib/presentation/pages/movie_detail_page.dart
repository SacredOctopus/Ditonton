import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie/presentation/bloc/moviedetail/moviedetail_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail_movie';

  final int id;
  const MovieDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  MovieDetailPageState createState() => MovieDetailPageState();
}

class MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RecommendationMoviesBloc>()
          .add(MovieDataWithIdEvent(widget.id));
      context
          .read<MovieDetailBloc>()
          .add(MovieDetailDataWithIdEvent(widget.id));
      context.read<MovieDetailBloc>().add(LoadWatchlistStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) async {
          if (state.watchlistMessage ==
                  MovieDetailBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  MovieDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.watchlistMessage),
              duration: const Duration(seconds: 1),
            ));
          } else {
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.watchlistMessage),
                  );
                });
          }
        },
        listenWhen: (previousState, currentState) =>
            previousState.watchlistMessage != currentState.watchlistMessage &&
            currentState.watchlistMessage != '',
        builder: (context, state) {
          if (state.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == RequestState.loaded) {
            final movie = state.movieDetail!;
            final status = state.isAddedToWatchlist;
            return SafeArea(
              child: DetailContent(
                movie,
                status,
              ),
            );
          } else {
            return const Center(child: Text("Failed to load"));
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.isAddedWatchlist, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<MovieDetailBloc>()
                                      .add(AddWatchlistEvent(movie));
                                } else {
                                  context
                                      .read<MovieDetailBloc>()
                                      .add(RemoveWatchlistEvent(movie));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMoviesBloc, MovieState>(
                              builder: (context, state) {
                                if (state is Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedData) {
                                  final result = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                movieDetailRoute,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else {
                                  return const Text('Failed');
                                }
                              },
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                color: Colors.white,
                                height: 4,
                                width: 48,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
