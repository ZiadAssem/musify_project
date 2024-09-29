import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/playlist/get_all_playlists.dart';
import '../../../service_locater.dart';
import 'playlists_state.dart';

class PlaylistsCubit extends Cubit<PlaylistsState> {

  PlaylistsCubit() : super(PlaylistsLoading());
  

  void fetchPlaylists() async {
    var returnedPlaylistss = await sl<GetAllPlaylistsUseCase>().call();
    returnedPlaylistss.fold(
      (l) => emit(PlaylistsFailure(message: l.toString())),
      (playlists) => emit(PlaylistsLoaded(playlists: playlists)),
    );
  }
}