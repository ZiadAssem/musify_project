import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final String coverURL;
  final String songURL;

  SongEntity({required this.title, required this.artist, required this.duration, required this.releaseDate, required this.coverURL,required this.songURL});

  

}
