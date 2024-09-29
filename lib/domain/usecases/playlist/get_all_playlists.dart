import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';

import '../../../service_locater.dart';
import '../../repository/playlist/playlist.dart';

class GetAllPlaylistsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<PlaylistRepository>().getAllPlaylists();
  }
}
