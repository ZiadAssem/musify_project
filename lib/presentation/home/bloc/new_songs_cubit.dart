import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/new_songs_state.dart';

import '../../../service_locater.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> getNewSongs() async {
    var returnedSongs = await sl<GetNewSongsUseCase>().call();

    returnedSongs.fold((l) {
      emit(NewSongsLoadFailure(
        
        message: l.toString(),
      ));
    }, (data) {
      emit(NewSongsLoaded(songs: data));
    });
  }
}
