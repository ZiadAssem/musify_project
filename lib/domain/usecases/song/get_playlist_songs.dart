import 'package:dartz/dartz.dart';
import 'package:spotify_project/domain/repository/song/song.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locater.dart';

class GetPlaylistSongsUseCase extends UseCase<Either, dynamic> {


 @override
  Future<Either> call({params}) async {
    return sl<SongsRepository>().getPlaylistSongs(params);
  }
}