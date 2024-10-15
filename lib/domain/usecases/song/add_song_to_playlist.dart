import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';

import '../../../service_locater.dart';
import '../../repository/song/song.dart';

class AddSongToPlaylistUseCase extends UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().addToPlaylist(params.playlistId, params.songId);
  }
}