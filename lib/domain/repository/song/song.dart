import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> getNewSongs();
  Future<Either> getPlaylist(); //Hypothetical method, there are no actual playlists

}