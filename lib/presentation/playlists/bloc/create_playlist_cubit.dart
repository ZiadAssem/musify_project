import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/playlist/playlist.dart';
import '../../../domain/usecases/playlist/create_new_playlist.dart';
import '../../../service_locater.dart';
import 'create_playlist_state.dart';

class CreatePlaylistCubit extends Cubit<CreatePlaylistState>{
  CreatePlaylistCubit() :super(CreatePlaylistInitial());

    void createPlaylist(String title, String description, List<String> songURLs) async {
    if (title.isEmpty || description.isEmpty) {
      emit(CreatePlaylistFailure(message: 'Title and description cannot be empty'));
    } else {
      emit(CreatingPlaylist());
      // Call the create playlist usecase
      final PlaylistEntity playlist = PlaylistEntity(
        title: title,
        description: description,
        songURLs: songURLs,
      );
      var result = await sl<CreateNewPlaylistUseCase>().call(params: playlist);
      result.fold(
        (l) => emit(CreatePlaylistFailure(message: l.toString())),
        (r) => emit(CreatePlaylistSuccess(message: r.toString()))
      );
    }
  }

}