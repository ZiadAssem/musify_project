import 'package:dartz/dartz.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

abstract class SongsRepository {
  Future<Either> getNewSongs(); 
  Future<Either> getAllSongs(); //Hypothetical method, there are no actual playlists
  Future<Either> addOrRemoveToFavorites(String songId);
  Future<bool> isFavorite(String songId);
  Future<Either> getUserFavoriteSongs();
  Future<Either> getPlaylistSongs(List<String> songURLs);
  Future<Either> searchSongs(String query, {List<SongEntity>? songs});
  Future<Either> addToPlaylist(String playlistId, List< String> songId);

}