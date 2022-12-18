import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constants.dart';
import 'package:core/presentation/widgets/drawer_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/movie/movie_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const routeName = '/home_movie';

  const HomeMoviePage({Key? key}) : super(key: key);
  @override
  HomeMoviePageState createState() => HomeMoviePageState();
}

class HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          context.read<MovieBloc>().add(const MoviesDataEvent()),
          context.read<PopularMovieBloc>().add(const MoviesDataEvent()),
          context.read<TopRatedMovieBloc>().add(const MoviesDataEvent()),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(currentRoute: 'movie'),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchMovieRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, popularMoviesRoute),
              ),
              BlocBuilder<PopularMovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedMovieRoute),
              ),
              BlocBuilder<TopRatedMovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
