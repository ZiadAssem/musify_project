import 'package:spotify_project/domain/entities/song/song.dart';

abstract class FavoriteSongsState{}

class FavoriteSongsLoading extends FavoriteSongsState{}

class FavoriteSongsLoaded extends FavoriteSongsState{
  final List<SongEntity> songs;
  FavoriteSongsLoaded({required this.songs});
}

class FavoriteSongsFailure extends FavoriteSongsState{
  final String message;
  FavoriteSongsFailure({required this.message});
}