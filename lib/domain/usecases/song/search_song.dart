import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locater.dart';
import '../../repository/song/song.dart';

class SearchSongUseCase extends UseCase<Either, Map<String,dynamic>> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().searchSongs(params!['query'],songs: params['songs']);
  }
}