import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class SongModel {
  String title;
  String artist;
  num duration;
  Timestamp releaseDate;
  String coverURL;
  String songURL;
  bool isFavorite;
  String songId;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.coverURL,
      required this.songURL,
      required this.isFavorite,
      required this.songId});

  factory SongModel.fromJson(Map<String, dynamic> map) {
    return SongModel(
        title: map['title'],
        artist: map['artist'],
        duration: map['duration'],
        releaseDate: map['releaseDate'],
        coverURL: map['coverURL'],
        songURL: map['songURL'],
        isFavorite: map['isFavorite'],
        songId: map['songId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'coverURL': coverURL,
      'songURL': songURL,
      'isFavorite': isFavorite,
      'songId': songId
    };
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        title: title,
        artist: artist,
        duration: duration,
        releaseDate: releaseDate,
        coverURL: coverURL,
        songURL: songURL,
        isFavorite: isFavorite,
        songId: songId);
  }
}
