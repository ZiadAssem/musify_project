import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locater.dart';


class IsFavoriteUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavorite(params!);
  }
}
