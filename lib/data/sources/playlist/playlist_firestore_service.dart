import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/domain/entities/playlist/playlist.dart';

import '../../models/playlist/playlist.dart';

abstract class PlaylistFirebaseService{
  Future<Either> getAllPlaylists();
}

class PlaylistFirebaseServiceImpl implements PlaylistFirebaseService{

  @override
  Future<Either> getAllPlaylists()async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    List<PlaylistEntity> playlists = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try{
      var data = await firestore.collection('Users').doc(userId).collection('Playlists').get();
      for(var element in data.docs){
        final List<String> songURLs = List<String>.from(element['songURLs']);
        element.data()['songURLs'] = songURLs;
        final playlistModel = PlaylistModel.fromJson(element.data());
        final playlistEntity = playlistModel.toEntity();
        playlists.add(playlistEntity);

      }
      return Right(playlists);
    }catch(e){
      return Left(e);
    }
  }
}