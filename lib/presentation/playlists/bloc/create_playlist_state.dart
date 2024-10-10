abstract class CreatePlaylistState {}

class CreatePlaylistInitial extends CreatePlaylistState {}

class CreatingPlaylist extends CreatePlaylistState {}

class CreatePlaylistSuccess extends CreatePlaylistState {
  final String message;

  CreatePlaylistSuccess({required this.message});
}

class CreatePlaylistFailure extends CreatePlaylistState {
  final String message;

  CreatePlaylistFailure({required this.message});
}