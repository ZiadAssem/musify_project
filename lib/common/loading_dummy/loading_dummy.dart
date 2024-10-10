import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/song/song.dart';

class LoadingDummy{
  static  final List<SongEntity> dummySongs = [
    SongEntity(
        title: 'title for song',
        artist: 'artist for',
        duration: 1,
        releaseDate: Timestamp.now(),
        coverURL: 'coverURL',
        songURL: 'songURL',
        isFavorite: false,
        songId: 'songId'),
    SongEntity(
        title: 'title for song',
        artist: 'artist for',
        duration: 1,
        releaseDate: Timestamp.now(),
        coverURL: 'coverURL',
        songURL: 'songURL',
        isFavorite: false,
        songId: 'songId'),
    SongEntity(
        title: 'title for song',
        artist: 'artist for',
        duration: 1,
        releaseDate: Timestamp.now(),
        coverURL: 'coverURL',
        songURL: 'songURL',
        isFavorite: false,
        songId: 'songId'),
  ];

}