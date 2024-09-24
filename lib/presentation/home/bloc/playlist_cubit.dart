import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/song/song.dart';
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

  void updateSongFavoriteStatus(SongEntity song) {
    print('UPDATING SONG FAVORITE STATUS');
    if (state is PlaylistLoaded) {
      final loadedState = state as PlaylistLoaded;
      final updatedSongs = loadedState.songs.map((s) {
        if (s.songId == song.songId) {
          return song.copyWith(isFavorite: !s.isFavorite);
        }
        return s;
      }).toList();
      print('EMITTING UPDATED STATE');
      emit(PlaylistLoaded(songs: updatedSongs));
    }
  }
}
