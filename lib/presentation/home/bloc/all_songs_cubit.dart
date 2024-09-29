import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/song/song.dart';
import '../../../domain/usecases/song/get_all_songs.dart';
import 'all_songs_state.dart';
import '../../../service_locater.dart';

class AllSongsCubit extends Cubit<AllSongsState> {
  AllSongsCubit() : super(const AllSongsLoading());

  Future<void> getAllSongs() async {
    var returnedSongs = await sl<GetAllSongsUseCase>().call();

    returnedSongs.fold((l) {
      emit(AllSongsLoadFailure(message: l.toString()));
    }, (data) {
      emit(AllSongsLoaded(songs: data));
    });
  }

  void sortSongsBy(String sortOption) {
    if (state is AllSongsLoaded) {
      final loadedState = state as AllSongsLoaded;
      List<SongEntity> sortedSongs = List.from(loadedState.songs);

      switch (sortOption) {
        case 'Name':
          sortedSongs.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Artist':
          sortedSongs.sort((a, b) => a.artist.compareTo(b.artist));
          break;
        case 'Release Date':
          sortedSongs.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
          break;
      }

      emit(AllSongsLoaded(songs: sortedSongs));
    }
  }

  void updateSongFavoriteStatus(SongEntity song) {
    print('UPDATING SONG FAVORITE STATUS');
    if (state is AllSongsLoaded) {
      final loadedState = state as AllSongsLoaded;
      final updatedSongs = loadedState.songs.map((s) {
        if (s.songId == song.songId) {
          return song.copyWith(isFavorite: !s.isFavorite);
        }
        return s;
      }).toList();
      print('EMITTING UPDATED STATE');
      emit(AllSongsLoaded(songs: updatedSongs));
    }
  }
}
