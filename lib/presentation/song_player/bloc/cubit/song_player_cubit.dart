import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      emit(SongPlayerLoaded());
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
      emit(SongPlayerLoaded());
    });
  }

  Future<void> loadSong(String songURL) async {
    try {
      audioPlayer.setUrl(songURL);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerLoadFailure(e.toString()));
    }
  }

  Future<void> playOrPauseSong() async {
    try {
      if (audioPlayer.playing) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.play();
      }
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerLoadFailure(e.toString()));
    }
  }

  
  void seekSong(Duration duration) {
    audioPlayer.seek(duration);
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
