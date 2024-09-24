import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/song/song_repository_impl.dart';
import 'package:spotify_project/data/sources/song/song_firestore_service.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/domain/usecases/auth/get_user.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify_project/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_playlist.dart';
import 'package:spotify_project/domain/usecases/song/is_favorite.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/usecases/auth/signin.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongsRepository>(SongsRepositoryImpl());
  sl.registerSingleton<GetNewSongsUseCase>(GetNewSongsUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetPlaylistUseCase>(GetPlaylistUseCase());
  sl.registerSingleton<AddOrRemoveToFavoritesUseCase>(AddOrRemoveToFavoritesUseCase());
  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
}
