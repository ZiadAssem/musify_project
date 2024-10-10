import 'package:dartz/dartz.dart';
import 'package:spotify_project/domain/entities/playlist/playlist.dart';

abstract class PlaylistRepository{
  Future<Either> getAllPlaylists();
  Future<Either> createNewPlaylist(PlaylistEntity playlist);
}