part of 'add_songs_to_playlist_cubit.dart';

abstract class AddSongsToPlaylistState {}

class AddSongsToPlaylistInitial extends AddSongsToPlaylistState {}

class AddingSongsToPlaylist extends AddSongsToPlaylistState {}

class AddSongsToPlaylistSuccess extends AddSongsToPlaylistState {}

class AddSongsToPlaylistFailure extends AddSongsToPlaylistState {
  final String message;

  AddSongsToPlaylistFailure({required this.message});
}