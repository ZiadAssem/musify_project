
import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/playlist/playlist.dart';

import '../../../domain/entities/playlist/playlist.dart';
import '../../../domain/repository/playlist/playlist.dart';
import '../../../service_locater.dart';
import '../../sources/playlist/playlist_firestore_service.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  

  @override
  Future<Either> getAllPlaylists() async {
    return await sl<PlaylistFirebaseService>().getAllPlaylists();
  }

  @override
  Future<Either> createNewPlaylist(PlaylistEntity playlist) async {
    final PlaylistModel model = PlaylistModel.fromEntity(playlist);
    return await sl<PlaylistFirebaseService>().createNewPlaylist(model);
  }
}