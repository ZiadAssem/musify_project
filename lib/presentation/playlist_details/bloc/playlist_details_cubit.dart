import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/presentation/playlist_details/bloc/playlist_details_state.dart';
import 'package:spotify_project/service_locater.dart';

import '../../../domain/usecases/song/get_playlist_songs.dart';

class PlaylistDetailsCubit extends Cubit<PlaylistDetailsState>{
  PlaylistDetailsCubit() : super( PlaylistDetailsLoading());

  void fetchPlaylistDetails(List<String> songURLs) async {
    var playlistSongs = await sl<GetPlaylistSongsUseCase>().call(params: songURLs);
    playlistSongs.fold((l) {
      emit(PlaylistDetailsLoadFailure(message: l.toString()));
    }, (data) {
      emit(PlaylistDetailsLoaded(songs: data));
    });
  }
}