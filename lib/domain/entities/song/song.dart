import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final String coverURL;
  final String songURL;
  final bool isFavorite;
  final String songId;

  SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.coverURL,
    required this.songURL,
    required this.isFavorite,
    required this.songId,
  });

  // Add the copyWith method here
  SongEntity copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releaseDate,
    String? coverURL,
    String? songURL,
    bool? isFavorite,
    String? songId,
  }) {
    return SongEntity(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      coverURL: coverURL ?? this.coverURL,
      songURL: songURL ?? this.songURL,
      isFavorite: isFavorite ?? this.isFavorite,
      songId: songId ?? this.songId,
    );
  }
}
