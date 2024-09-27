 import '../../../domain/entities/song/song.dart';

abstract class AllSongsState {

  const AllSongsState();
}

class AllSongsLoading extends AllSongsState {
  const AllSongsLoading();
}

class AllSongsLoaded extends AllSongsState {
  final List<SongEntity> songs;

  const AllSongsLoaded({required this.songs});
}

class AllSongsLoadFailure extends AllSongsState {
  final String message;

  const AllSongsLoadFailure({required this.message});
}