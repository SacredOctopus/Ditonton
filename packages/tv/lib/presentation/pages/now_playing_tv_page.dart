import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class NowPlayingTvPage extends StatefulWidget {
  static const routeName = '/now_playing_tv';

  const NowPlayingTvPage({Key? key}) : super(key: key);

  @override
  NowPlayingTvPageState createState() => NowPlayingTvPageState();
}

class NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvBloc>().add(const TvDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvBloc, TvState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
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
