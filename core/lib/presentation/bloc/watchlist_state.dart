part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {
  bool value = false;

  WatchlistInitial(this.value);

  @override
  List<Object> get props => [value];
}

// Movie Watchlist State
class WatchlistFailure extends WatchlistState {
  final String message;

  const WatchlistFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSuccess extends WatchlistState {
  final String message;

  const WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistState {
  final bool isAdded;

  const WatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}
