
import 'package:dartz/dartz.dart';

import '../../../domain/repository/playlist/playlist.dart';
import '../../../service_locater.dart';
import '../../sources/playlist/playlist_firestore_service.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  

  @override
  Future<Either> getAllPlaylists() async {
    return await sl<PlaylistFirebaseService>().getAllPlaylists();
  }
}