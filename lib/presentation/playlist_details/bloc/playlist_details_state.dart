import 'package:spotify_project/domain/entities/song/song.dart';

abstract class PlaylistDetailsState{}

class PlaylistDetailsLoading extends PlaylistDetailsState{}

class PlaylistDetailsLoaded extends PlaylistDetailsState{
  final List<SongEntity> songs;

  PlaylistDetailsLoaded({required this.songs});
}

class PlaylistDetailsLoadFailure extends PlaylistDetailsState{
  final String message;

  PlaylistDetailsLoadFailure({required this.message});
}