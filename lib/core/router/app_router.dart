import 'package:flutter/material.dart';
import 'package:spotify_project/domain/entities/playlist/playlist.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/auth/pages/signin_page.dart';
import 'package:spotify_project/presentation/auth/pages/signup.dart';
import 'package:spotify_project/presentation/auth/pages/signup_or_sigin.dart';
import 'package:spotify_project/presentation/choose_mode/pages/choose_mode.dart';
import 'package:spotify_project/presentation/intro/pages/get_started.dart';
import 'package:spotify_project/presentation/playlist_details/pages/playlist_details.dart';
import 'package:spotify_project/presentation/playlists/pages/playlists.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player.dart';
import '../../presentation/home/pages/home.dart';
import '../../presentation/profile/pages/profile.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/get-started':
        return MaterialPageRoute(builder: (_) => const GetStartedPage());
      case '/choose-mode':
        return MaterialPageRoute(builder: (_) => const ChooseModePage());
      case '/authentication':
        return MaterialPageRoute(builder: (_) => const SignupOrSigninPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SigninPage());
      case '/root':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/playlists':
        return MaterialPageRoute(builder: (_) => const PlaylistsListPage());

      case '/playlist-details':
        final PlaylistEntity playlist = routeSettings.arguments as PlaylistEntity;
        return MaterialPageRoute(
            builder: (_) => PlaylistDetailsPage(
                  playlist: playlist,
                ));
      case '/song-player':
        final args = routeSettings.arguments as Map<String, dynamic>;
        final songs = args['songs'] as List<SongEntity>;
        final index = args['index'] as int;
        return MaterialPageRoute(
            builder: (_) => SongPlayer(
                  songs: songs,
                  index: index,
                ));
      default:
        return null;
    }
  }
}
