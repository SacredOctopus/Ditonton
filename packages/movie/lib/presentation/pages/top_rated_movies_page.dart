import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top_rated_movie';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  TopRatedMoviesPageState createState() => TopRatedMoviesPageState();
}

class TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMovieBloc>().add(const MoviesDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, MovieState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is Error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
