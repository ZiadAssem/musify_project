import 'package:dartz/dartz.dart';
import 'package:spotify_project/domain/repository/song/song.dart';

import '../../../service_locater.dart';
import '../../sources/song/song_firestore_service.dart';

class SongsRepositoryImpl extends SongsRepository{
  @override
  Future<Either> getNewSongs() async{
    return await sl<SongFirebaseService>().getNewSongs();
  }
  
  @override
  Future<Either> getAllSongs() async {
    return await sl<SongFirebaseService>().getAllSongs();
  }
  
  @override
  Future<Either> addOrRemoveToFavorites(String songId)async {
    return await sl<SongFirebaseService>().addOrRemoveToFavorites(songId);
  }
  
  @override
  Future<bool> isFavorite(String songId)async {
    return await sl<SongFirebaseService>().isFavorite(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs()async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}