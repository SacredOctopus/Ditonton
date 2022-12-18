import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/routes.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv/presentation/bloc/tvdetail/tvdetail_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/detail_tv';

  final int id;
  const TvDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  TvDetailPageState createState() => TvDetailPageState();
}

class TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RecommendationTvBloc>().add(TvDataWithIdEvent(widget.id));
      context.read<TvDetailBloc>().add(TvDetailDataWithIdEvent(widget.id));
      context.read<TvDetailBloc>().add(LoadWatchlistStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvDetailBloc, TvDetailState>(
        listener: (context, state) async {
          if (state.watchlistMessage ==
                  TvDetailBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  TvDetailBloc.watchlistRemoveSuccessMessage) {
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
        listenWhen: (previousState, currentState) {
          return previousState.watchlistMessage !=
                  currentState.watchlistMessage &&
              currentState.watchlistMessage != '';
        },
        builder: (context, state) {
          if (state.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == RequestState.loaded) {
            final tv = state.tvDetail!;
            final status = state.isAddedToWatchlist;
            return SafeArea(
              child: DetailContent(
                tv,
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
  final TvDetail tv;
  final bool isAddedWatchlist;

  const DetailContent(this.tv, this.isAddedWatchlist, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<TvDetailBloc>()
                                      .add(AddWatchlistEvent(tv));
                                } else {
                                  context
                                      .read<TvDetailBloc>()
                                      .add(RemoveWatchlistEvent(tv));
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
                              _showGenres(tv.genres),
                            ),
                            Text(
                              _showTotalAir("Episodes", tv.numberOfEpisodes),
                            ),
                            Text(
                              _showTotalAir("Seasons", tv.numberOfSeasons),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvBloc, TvState>(
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
                                        final tv = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                tvDetailRoute,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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

  String _showTotalAir(String input, int total) {
    return 'Number of $input : $total';
  }
}
