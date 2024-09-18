 import '../../../domain/entities/song/song.dart';

abstract class PlaylistState {

  const PlaylistState();
}

class PlaylistLoading extends PlaylistState {
  const PlaylistLoading();
}

class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;

  const PlaylistLoaded({required this.songs});
}

class PlaylistLoadFailure extends PlaylistState {
  final String message;

  const PlaylistLoadFailure({required this.message});
}