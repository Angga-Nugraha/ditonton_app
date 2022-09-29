part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class AddMovieWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  const AddMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteMovieWatchlist extends WatchlistEvent {
  final MovieDetail movie;

  const DeleteMovieWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class AddTvWatchlist extends WatchlistEvent {
  final TvDetail tv;

  const AddTvWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class DeleteTvWatchlist extends WatchlistEvent {
  final TvDetail tv;

  const DeleteTvWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistStatus extends WatchlistEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class LoadWatchlistTVStatus extends WatchlistEvent {
  final int id;

  const LoadWatchlistTVStatus(this.id);

  @override
  List<Object> get props => [id];
}
