import 'package:dartz/dartz.dart';

abstract class SongsRepository {
  Future<Either> getNewSongs(); 
  Future<Either> getAllSongs(); //Hypothetical method, there are no actual playlists
  Future<Either> addOrRemoveToFavorites(String songId);
  Future<bool> isFavorite(String songId);
  Future<Either> getUserFavoriteSongs();

}