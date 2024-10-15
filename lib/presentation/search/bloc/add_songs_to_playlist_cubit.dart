import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/song/song.dart';
import '../../../service_locater.dart';
part 'add_songs_to_playlist_state.dart';


class AddSongsToPlaylistCubit extends Cubit<AddSongsToPlaylistState> {
  AddSongsToPlaylistCubit() : super(AddSongsToPlaylistInitial());

  void addSongsToPlaylist(String playlistId , List<String> songId) async {
    emit(AddingSongsToPlaylist());
    final result = await sl<SongsRepository>().addToPlaylist(playlistId, songId);
    result.fold(
      (failure) => emit(AddSongsToPlaylistFailure(message: failure.toString())),
      (_) => emit(AddSongsToPlaylistSuccess()),
    );
  }
}