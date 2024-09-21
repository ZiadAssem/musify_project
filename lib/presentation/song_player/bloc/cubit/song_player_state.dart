part of 'song_player_cubit.dart';

abstract class SongPlayerState {}



class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  
}

class SongPlayerLoadFailure extends SongPlayerState {
  final String message;
  SongPlayerLoadFailure(this.message);
}
