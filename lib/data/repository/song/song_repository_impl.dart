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
  Future<Either> getPlaylist() {
    // TODO: implement getPlaylist
    throw UnimplementedError();
  }
}