import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/entities/playlist/playlist.dart';

import '../../../service_locater.dart';
import '../../repository/playlist/playlist.dart';

class CreateNewPlaylistUseCase implements UseCase<Either, PlaylistEntity> {
  @override
  Future<Either> call({PlaylistEntity? params}) async {
    return await sl<PlaylistRepository>().createNewPlaylist(params!);
  }
}
