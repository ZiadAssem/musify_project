import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify_project/data/models/song/song.dart';

import '../../../domain/entities/song/song.dart';
import '../../../domain/usecases/song/is_favorite.dart';
import '../../../service_locater.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either>
      getPlaylist(); //Hypothetical method, there are no actual playlists
  Future<Either> addOrRemoveToFavorites(String songId);
  Future<bool> isFavorite(String songId);
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      FirebaseStorage storage = FirebaseStorage.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var data = await firestore
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(5)
          .get();

      for (var element in data.docs) {
        var songData = element.data();
        var artist = songData['artist'];
        var title = songData['title'];
        var coverURL = '';
        var songURL = '';
        bool isFavorite = false;
        var songId = element.reference.id;

        Reference imageRef =
            storage.ref().child('covers/${artist.trim()} - $title.jpeg');
        Reference songRef =
            storage.ref().child('songs/${artist.trim()} - $title.mp3');

        // Get the download URL for cover images
        try {
          coverURL = await imageRef.getDownloadURL();
          songURL = await songRef.getDownloadURL();
                  isFavorite =
            await sl<IsFavoriteUseCase>().call(params: element.reference.id);

        } catch (e) {
          print('Error getting cover URL: ${e.toString()}');
        }
        songData['coverURL'] = coverURL;
        songData['songURL'] = songURL;
        songData['isFavorite'] = isFavorite;
        songData['songId'] = songId;

        print('TEEEEEESSSSSSSSSSSSSSSSTTTTTTT');

        var songModel = SongModel.fromJson(songData);

        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error has occurred: $e');
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs = [];
      FirebaseStorage storage = FirebaseStorage.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var data = await firestore
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(5)
          .get();

      for (var element in data.docs) {
        var songData = element.data();
        var artist = songData['artist'];
        var title = songData['title'];
        var coverURL = '';
        var songURL = '';
        bool isFavorite = false;
        var songId = element.reference.id;

        Reference imageRef =
            storage.ref().child('covers/${artist.trim()} - $title.jpeg');
        Reference songRef =
            storage.ref().child('songs/${artist.trim()} - $title.mp3');

        // Get the download URL for cover images
        try {
          coverURL = await imageRef.getDownloadURL();
          songURL = await songRef.getDownloadURL();
          isFavorite =
            await sl<IsFavoriteUseCase>().call(params: element.reference.id);
          
        } catch (e) {
          print('Error getting cover URL: $e');
        }

        songData['coverURL'] = coverURL;
        songData['songURL'] = songURL;
        songData['isFavorite'] = isFavorite;
        songData['songId'] = songId;
                

        var songModel = SongModel.fromJson(songData);

        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error has occurred: $e');
    }
  }

  @override
  Future<Either> addOrRemoveToFavorites(String songId) async {
    print('Test addOrRemoveToFavorites');
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final user = auth.currentUser;
      String uId = user!.uid;
      late bool isFavorite;

      QuerySnapshot favoriteSongs = await firestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedAt': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left('An error has occurred: $e');
    }
  }

  @override
  Future<bool> isFavorite(String songId) async {
    print('Testing isFavorite');
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final user = auth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      print('TESTING: ${favoriteSongs.docs.length}');
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
