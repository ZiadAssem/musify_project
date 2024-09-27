import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/song/get_favorite_songs.dart';

import '../../../domain/entities/song/song.dart';
import '../../../service_locater.dart';
import 'favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var songs = await sl<GetFavoriteSongsUseCase>().call();

    songs.fold((l) => emit(FavoriteSongsFailure(message: l.toString())), (r) {
      favoriteSongs = r;
      emit(FavoriteSongsLoaded(songs: favoriteSongs));
    });
  }

  void removeFavoriteSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(songs: favoriteSongs));
  }

  
}
