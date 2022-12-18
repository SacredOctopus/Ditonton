import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/drawer_menu.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = '/home_tv';

  const HomeTvPage({Key? key}) : super(key: key);
  @override
  HomeTvPageState createState() => HomeTvPageState();
}

class HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          context.read<TvBloc>().add(const TvDataEvent()),
          context.read<PopularTvBloc>().add(const TvDataEvent()),
          context.read<TopRatedTvBloc>().add(const TvDataEvent()),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(currentRoute: 'tv'),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchTvRoute);
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
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, nowplayingTvRoute),
              ),
              BlocBuilder<TvBloc, TvState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, populartvRoute),
              ),
              BlocBuilder<PopularTvBloc, TvState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedData) {
                    final result = state.result;
                    return TvList(result);
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return const Text('Failed to load data');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(context, topRatedTvRoute),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedData) {
                    final result = state.result;
                    return TvList(result);
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

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final singleTv = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: singleTv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${singleTv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
