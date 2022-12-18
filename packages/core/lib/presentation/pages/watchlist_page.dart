import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart' as movieblloc;
import 'package:tv/presentation/bloc/tv/tv_bloc.dart' as tvbloc;
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class Watchlist extends StatefulWidget {
  static const routeName = '/watchlist';

  const Watchlist({Key? key}) : super(key: key);

  @override
  WatchlistState createState() => WatchlistState();
}

class WatchlistState extends State<Watchlist> with RouteAware {
  final List<Widget> watchList = [
    const _WatchlistMoviesList(),
    const _WatchlistTvList()
  ];
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<movieblloc.WatchlistMovieBloc>()
          .add(const movieblloc.MoviesDataEvent());
      context.read<tvbloc.WatchlistTvBloc>().add(const tvbloc.TvDataEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context
        .read<movieblloc.WatchlistMovieBloc>()
        .add(const movieblloc.MoviesDataEvent());
    context.read<tvbloc.WatchlistTvBloc>().add(const tvbloc.TvDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: TabBar(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // Creates border
                color: Colors.blueGrey[600]),
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.movie),
                    SizedBox(width: 6),
                    Text('Movie'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.tv),
                    SizedBox(width: 6),
                    Text('Tv'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: watchList),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class _WatchlistMoviesList extends StatelessWidget {
  const _WatchlistMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<movieblloc.WatchlistMovieBloc, movieblloc.MovieState>(
        builder: (context, state) {
          if (state is movieblloc.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is movieblloc.LoadedData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
            );
          } else if (state is movieblloc.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class _WatchlistTvList extends StatelessWidget {
  const _WatchlistTvList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<tvbloc.WatchlistTvBloc, tvbloc.TvState>(
        builder: (context, state) {
          if (state is tvbloc.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is tvbloc.LoadedData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.result[index];
                return TvCard(tvShow);
              },
              itemCount: state.result.length,
            );
          } else if (state is tvbloc.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
