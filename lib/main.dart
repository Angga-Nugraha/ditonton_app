import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:submission_akhir/firebase_options.dart';
import 'package:submission_akhir/injection.dart' as di;
import 'package:core/data/ssl_pinning.dart';
import 'package:core/watchlist/bloc/watchlist_bloc.dart';

import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';
import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:about/about_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<PlayingNowMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PlayingNowTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeasonTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => const WatchListPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case HOME_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => const HomeTVPage());
            case POPULAR_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => const PopularTVPage());
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(
                  id: id,
                ),
              );
            case TOP_RATED_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => const TopRatedTVPage());
            case SEARCH_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => const SearchTVPage());
            case SEASON_TV_ROUTE:
              final id = settings.arguments as List;
              return MaterialPageRoute(
                builder: (_) => SeasonTVPage(id: id[0], numSeason: id[1]),
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
