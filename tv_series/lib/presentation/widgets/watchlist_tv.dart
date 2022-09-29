import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

class WatchListTV extends StatelessWidget {
  const WatchListTV({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTVBloc, WatchlistTVState>(
        builder: (context, state) {
          if (state is WatchlistTVEmpty) {
            return const Center(
              child: Text('Watchlist is empty'),
            );
          } else if (state is WatchlistTVLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTVHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.result[index];
                return TVCard(tv);
              },
              itemCount: state.result.length,
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}
