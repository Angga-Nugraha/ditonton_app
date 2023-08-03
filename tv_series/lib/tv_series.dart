library tv_series;

// data
export 'package:tv_series/data/datasources/tv_local_data_source.dart';
export 'package:tv_series/data/datasources/tv_remote_data_source.dart';

export 'package:tv_series/data/models/episode_model.dart';
export 'package:tv_series/data/models/season_detail_model.dart';
export 'package:tv_series/data/models/season_model.dart';
export 'package:tv_series/data/models/tv_detail_model.dart';
export 'package:tv_series/data/models/tv_model.dart';
export 'package:tv_series/data/models/tv_response.dart';
export 'package:tv_series/data/models/tv_table.dart';

export 'package:tv_series/data/repositories/tv_repository_impl.dart';

export 'package:tv_series/domain/entities/episode.dart';
export 'package:tv_series/domain/entities/season.dart';
export 'package:tv_series/domain/entities/season_detail.dart';
export 'package:tv_series/domain/entities/tv.dart';
export 'package:tv_series/domain/entities/tv_detail.dart';

export 'package:tv_series/domain/repositories/tv_repository.dart';

// domain
export 'package:tv_series/domain/usecases/get_now_playing_on_air_tv.dart';
export 'package:tv_series/domain/usecases/get_popular_tv.dart';
export 'package:tv_series/domain/usecases/get_season_tv.dart';
export 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
export 'package:tv_series/domain/usecases/get_tv_detail.dart';
export 'package:tv_series/domain/usecases/get_tv_recomendations.dart';
export 'package:tv_series/domain/usecases/get_watchlist_status.dart';
export 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
export 'package:tv_series/domain/usecases/remove_watchlist.dart';
export 'package:tv_series/domain/usecases/save_watchlist.dart';
export 'package:tv_series/domain/usecases/get_trailer_tv.dart';
export 'package:tv_series/domain/usecases/get_trailer_episode.dart';

// presentation
export 'package:tv_series/presentation/pages/detail_tv_page.dart';
export 'package:tv_series/presentation/pages/popular_tv_page.dart';
export 'package:tv_series/presentation/pages/season_tv_page.dart';
export 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
export 'package:tv_series/presentation/pages/tv_series_page.dart';
export 'package:tv_series/presentation/widgets/recomendations_tv_list.dart';
export 'package:tv_series/presentation/widgets/season_list.dart';
export 'package:tv_series/presentation/widgets/tv_card_list.dart';
export 'package:tv_series/presentation/widgets/watchlist_tv.dart';

export 'package:tv_series/presentation/bloc/playing_now_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/season_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_detail_bloc.dart';
export 'package:tv_series/presentation/bloc/recommendations_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/watchlist_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/trailer_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/trailer_episode_bloc.dart';
