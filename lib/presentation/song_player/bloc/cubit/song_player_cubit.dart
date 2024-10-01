import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../domain/entities/song/song.dart';

part 'song_player_state.dart';


class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  ConcatenatingAudioSource? playlist;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  List<SongEntity> songs = [];
  int currentIndex = 0;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      emit(SongPlayerLoaded());
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        emit(SongPlayerLoaded());
      }
    });

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        nextSong();
      }
    });
  }

  /// Loads the songs as a playlist using ConcatenatingAudioSource
  Future<void> loadSongs(List<SongEntity> songList, int startIndex) async {
    songs = songList;
    currentIndex = startIndex;
    
    // Create a concatenated playlist
    playlist = ConcatenatingAudioSource(
      children: songs.map((song) => AudioSource.uri(Uri.parse(song.songURL))).toList(),
    );
    
    try {
      await audioPlayer.setAudioSource(playlist!, initialIndex: currentIndex);
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

  /// Moves to the next song in the playlist
  void nextSong() {
    if (currentIndex < songs.length - 1) {
      currentIndex++;
      audioPlayer.seekToNext();
      emit(SongPlayerLoaded());
    }
  }

  /// Moves to the previous song in the playlist
  void previousSong() {
    if (currentIndex > 0) {
      currentIndex--;
      audioPlayer.seekToPrevious();
      emit(SongPlayerLoaded());
    }
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
