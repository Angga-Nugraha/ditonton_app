import 'package:core/core.dart';
import 'package:core/presentation/tv/provider/watchlist_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

class WatchListTV extends StatelessWidget {
  const WatchListTV({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistTVNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Empty) {
            return const Center(
              child: Text('Watchlist is empty'),
            );
          } else if (data.watchlistState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = data.watchlistTV[index];
                return TVCard(tv);
              },
              itemCount: data.watchlistTV.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
