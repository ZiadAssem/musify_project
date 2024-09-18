import 'package:flutter_bloc/flutter_bloc.dart';
import 'playlist_state.dart';
import '../../../domain/usecases/song/get_playlist.dart';
import '../../../service_locater.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(const PlaylistLoading());

  Future<void> getPlaylist() async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold((l) {
      emit(PlaylistLoadFailure(
        
        message: l.toString(),
      ));
    }, (data) {
      emit(PlaylistLoaded(songs: data));
    });
  }
}
