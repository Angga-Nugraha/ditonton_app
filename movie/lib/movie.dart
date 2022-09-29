library movie;

// data
export 'package:movie/data/datasource/movie_local_data_source.dart';
export 'package:movie/data/datasource/movie_remote_data_source.dart';

export 'package:movie/data/models/genre_model.dart';
export 'package:movie/data/models/movie_detail_model.dart';
export 'package:movie/data/models/movie_model.dart';
export 'package:movie/data/models/movie_response.dart';
export 'package:movie/data/models/movie_table.dart';

export 'package:movie/data/repositories/movie_repository_impl.dart';

export 'package:movie/domain/entities/genre.dart';
export 'package:movie/domain/entities/movie.dart';
export 'package:movie/domain/entities/movie_detail.dart';

export 'package:movie/domain/repositories/movie_repository.dart';

// domain
export 'package:movie/domain/usecases/get_movie_detail.dart';
export 'package:movie/domain/usecases/get_movie_recommendations.dart';
export 'package:movie/domain/usecases/get_now_playing_movies.dart';
export 'package:movie/domain/usecases/get_popular_movies.dart';
export 'package:movie/domain/usecases/get_top_rated_movies.dart';
export 'package:movie/domain/usecases/get_watchlist_movies.dart';
export 'package:movie/domain/usecases/get_watchlist_status.dart';
export 'package:movie/domain/usecases/remove_watchlist.dart';
export 'package:movie/domain/usecases/save_watchlist.dart';

// presentation
export 'package:movie/presentation/pages/home_movie_page.dart';
export 'package:movie/presentation/pages/movie_detail_page.dart';
export 'package:movie/presentation/pages/popular_movies_page.dart';
export 'package:movie/presentation/pages/top_rated_movies_page.dart';
export 'package:movie/presentation/pages/watchlist_page.dart';
export 'package:movie/presentation/widgets/movie_card_list.dart';
export 'package:movie/presentation/widgets/recomendations_movie_list.dart';

export 'package:movie/presentation/bloc/detail_movie_bloc.dart';
export 'package:movie/presentation/bloc/playing_now_movie_bloc.dart';
export 'package:movie/presentation/bloc/popular_movie_bloc.dart';
export 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';
export 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
export 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
