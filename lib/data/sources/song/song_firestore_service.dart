import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify_project/data/models/song/song.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either>
      getPlaylist(); //Hypothetical method, there are no actual playlists
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> getNewSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      FirebaseStorage storage = FirebaseStorage.instance;

      for (var element in data.docs) {
        var songData = element.data();
        var artist = songData['artist'];
        var title = songData['title'];
        var coverURL = '';

        // Reference to the specific file
        Reference fileRef =
            storage.ref().child('covers/${artist.trim()} - $title.jpeg');

        // Get the download URL
        try {
          coverURL = await fileRef.getDownloadURL();
        } catch (e) {
          print('Error getting cover URL: $e');
        }

        songData['coverURL'] = coverURL;
        var songModel = SongModel.fromJson(songData);
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error has occurred: ' + e.toString());
    }
  }

  @override
  Future<Either> getPlaylist() {
    // TODO: implement getPlaylist
    throw UnimplementedError();
  }
}
