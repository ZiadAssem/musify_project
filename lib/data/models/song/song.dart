import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class SongModel {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final String coverURL;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.coverURL
      });

  factory SongModel.fromJson(Map<String, dynamic> map) {
    
    return SongModel(
      title: map['title'],
      artist: map['artist'],
      duration: map['duration'],
      releaseDate: map['releaseDate'],
      coverURL: map['coverURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'coverURL': coverURL,
    };
  }
}


extension SongModelX on SongModel{

  SongEntity toEntity(){
    return SongEntity( 
      artist: artist,
      title: title,
      duration: duration,
      releaseDate: releaseDate,
      coverURL: coverURL
    );
  }
}