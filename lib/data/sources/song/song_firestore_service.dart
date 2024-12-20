import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spotify_project/data/models/song/song.dart';

import '../../../domain/entities/song/song.dart';
import '../../../domain/usecases/song/is_favorite.dart';
import '../../../service_locater.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs();
  Future<Either> getAllSongs(); //Hypothetical method,
  Future<Either> getPlaylistSongs(List<String> songURLs);
  Future<Either> addOrRemoveToFavorites(String songId);
  Future<bool> isFavorite(String songId);
  Future<Either> getUserFavoriteSongs();
  Future<Either> searchSongs(String query, {List<SongEntity>? playlistSongs});
  Future<Either> addToPlaylist(String playlistId, List<String> songId);
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
        var artist = songData['artist'] ?? '';
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
  Future<Either> getAllSongs() async {
    try {
      List<SongEntity> songs = [];
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var data = await firestore
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songData = element.data();
        var artist = songData['artist'];
        var title = songData['title'];
        var coverURL = '';
        var songURL = '';
        bool isFavorite = false;
        var songId = element.reference.id;

        coverURL = await _getCoverDownloadURL(artist, title);
        songURL = await _getSongDownloadURL(artist, title);
        isFavorite =
            await sl<IsFavoriteUseCase>().call(params: element.reference.id);

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
  Future<Either> getPlaylistSongs(List<String> songURLs) async {
    try {
      List<SongEntity> playlistSongs = [];

      for (var songURL in songURLs) {
        playlistSongs.add(await _getSong(songURL, false));
      }

      return Right(playlistSongs);
    } on Exception catch (e) {
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
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      var user = auth.currentUser;
      String uId = user!.uid;
      List<SongEntity> favoriteSongs = [];

      QuerySnapshot favoritesSnapshot = await firestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];
        SongEntity song = await _getSong(songId, true);
        favoriteSongs.add(song);
      }

      return Right(favoriteSongs);
    } on Exception catch (e) {
      return Left('An error has occurred: $e');
    }
  }

  Future<SongEntity> _getSong(String songID, bool isFavorite) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var data = await firestore.collection('Songs').doc(songID).get();

    var songData = data.data()!;
    var artist = songData['artist'];
    var title = songData['title'];
    var coverURL = '';
    var songURL = '';

    coverURL = await _getCoverDownloadURL(artist, title);
    songURL = await _getSongDownloadURL(artist, title);

    songData['coverURL'] = coverURL;
    songData['songURL'] = songURL;
    songData['isFavorite'] = isFavorite;
    songData['songId'] = songID;
    var songModel = SongModel.fromJson(songData);

    return songModel.toEntity();
  }

  Future<String> _getSongDownloadURL(String artist, String title) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference songRef =
        storage.ref().child('songs/${artist.trim()} - $title.mp3');

    String songURL = await songRef.getDownloadURL();
    return songURL;
  }

  Future<String> _getCoverDownloadURL(String artist, String title) async {
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference imageRef =
        storage.ref().child('covers/${artist.trim()} - $title.jpeg');

    String coverURL = await imageRef.getDownloadURL();

    return coverURL;
  }

  @override
  Future<Either> searchSongs(String query,
      {List<SongEntity>? playlistSongs}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<SongEntity> songs = [];
    List<SongEntity> existingSongs = playlistSongs ?? [];
    print('QUERY $query');
    try {
      // Use .get() instead of .snapshots() for querying data once
      final snapshot = await firestore
          .collection('Songs')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: '$query\uf8ff')
          .get(); // Query the data once, not as a stream
      // Map the query snapshot to a list of SongEntity

      for(var doc in snapshot.docs){
                var songData = doc.data();
        var artist = songData['artist'];
        var title = songData['title'];
        var coverURL = '';
        var songURL = '';
        bool isFavorite = false;
        var songId = doc.reference.id;

        coverURL = await _getCoverDownloadURL(artist, title);
        songURL = await _getSongDownloadURL(artist, title);
        isFavorite =
            await sl<IsFavoriteUseCase>().call(params: doc.reference.id);

        songData['coverURL'] = coverURL;
        songData['songURL'] = songURL;
        songData['isFavorite'] = isFavorite;
        songData['songId'] = songId;
        var songModel = SongModel.fromJson(songData);
        SongEntity songEntity = songModel.toEntity();
        songs.add(songEntity);

      }

      
      // songs = snapshot.docs
      //     .map((doc) => SongModel.fromFirestore(doc).toEntity())
      //     .toList();

      // Remove existing songs from the result
      songs.removeWhere((song) => existingSongs.contains(song));
    } on Exception catch (e) {
      return Left('An error has occurred: $e');
    }

    return Right(songs);
  }

  @override
  Future<Either> addToPlaylist(String playlistId, List<String> songId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final uId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await firestore
          .collection('Users')
          .doc(uId)
          .collection('Playlists')
          .doc(playlistId)
          .update({'songURLs': FieldValue.arrayUnion(songId)});
      return Right('Songs added to playlist');
    } on Exception catch (e) {
      return Left('An error has occurred: $e');
    }
  }
}
