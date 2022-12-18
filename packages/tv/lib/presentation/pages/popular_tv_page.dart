import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular_tv';

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  PopularTvPageState createState() => PopularTvPageState();
}

class PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvBloc>().add(const TvDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, TvState>(
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
