import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:core/utils/utils.dart';

import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/watchlist_movie.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc.dart';

import 'package:tv_series/presentation/widgets/watchlist_tv.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieBloc>(context, listen: false)
          .add(FetchMovieWatchlist());
      Provider.of<WatchlistTVBloc>(context, listen: false)
          .add(FetchTVWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieBloc>(context, listen: false)
        .add(FetchMovieWatchlist());
    Provider.of<WatchlistTVBloc>(context, listen: false).add(
      FetchTVWatchlist(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(
              text: 'Movies',
            ),
            Tab(
              text: 'TV Series',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          WatchListMovies(),
          WatchListTV(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.dispose();
    super.dispose();
  }
}
