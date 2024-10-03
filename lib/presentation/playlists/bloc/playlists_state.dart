import 'package:spotify_project/domain/entities/playlist/playlist.dart';

abstract class PlaylistsState {
}

class PlaylistsLoading extends PlaylistsState {
}

class PlaylistsLoaded extends PlaylistsState {
  final List<PlaylistEntity> playlists;
  PlaylistsLoaded({required this.playlists});
}

class PlaylistsFailure extends PlaylistsState {
  final String message;

  PlaylistsFailure({required this.message});
}