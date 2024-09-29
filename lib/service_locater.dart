import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/playlist/playlist_repository_impl.dart';
import 'package:spotify_project/data/repository/song/song_repository_impl.dart';
import 'package:spotify_project/data/sources/song/song_firestore_service.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/domain/usecases/auth/get_user.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify_project/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_all_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_playlist_songs.dart';
import 'package:spotify_project/domain/usecases/song/is_favorite.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'data/sources/playlist/playlist_firestore_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/repository/playlist/playlist.dart';
import 'domain/usecases/auth/signin.dart';
import 'domain/usecases/playlist/get_all_playlists.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongsRepository>(SongsRepositoryImpl());
  sl.registerSingleton<GetNewSongsUseCase>(GetNewSongsUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetAllSongsUseCase>(GetAllSongsUseCase());
  sl.registerSingleton<AddOrRemoveToFavoritesUseCase>(AddOrRemoveToFavoritesUseCase());
  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
  sl.registerSingleton<PlaylistRepository>(PlaylistRepositoryImpl());
  sl.registerSingleton<PlaylistFirebaseService>(PlaylistFirebaseServiceImpl());
  sl.registerSingleton<GetAllPlaylistsUseCase>(GetAllPlaylistsUseCase());
  sl.registerSingleton<GetPlaylistSongsUseCase>(GetPlaylistSongsUseCase());
}
