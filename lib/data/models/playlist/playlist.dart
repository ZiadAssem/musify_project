import '../../../domain/entities/playlist/playlist.dart';

class PlaylistModel{
  final String? title;
  final String? description;
  final String? imageURL;
  final List<String>? songURLs;

  PlaylistModel(this.title, this.description, this.imageURL, this.songURLs);

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      json['title'],
      json['description'],
      json['imageURL'],
      json['songURLs'].cast<String>(),
    );
  }

  factory PlaylistModel.fromEntity(PlaylistEntity entity) {
    return PlaylistModel(
      entity.title,
      entity.description,
      entity.imageURL,
      entity.songURLs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageURL': imageURL,
      'songURLs': songURLs,
    };
  }
   
 

}
 extension PlaylistModelX on PlaylistModel {
    PlaylistEntity toEntity() {
      return PlaylistEntity(
        title: title,
        description: description,
        imageURL: imageURL,
        // cast List<dynamic> to List<String>? to match the PlaylistEntity
        songURLs: songURLs,
      );
    }
  }