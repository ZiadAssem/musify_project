import '../../../domain/entities/song/song.dart';

abstract class NewSongsState {

  const NewSongsState();
}

class NewSongsLoading extends NewSongsState {
  const NewSongsLoading();
}

class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;

  const NewSongsLoaded({required this.songs});
}

class NewSongsLoadFailure extends NewSongsState {
  final String message;

  const NewSongsLoadFailure({required this.message});
}