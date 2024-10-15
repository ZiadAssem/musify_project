import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:spotify_project/core/configs/theme/app_theme.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/usecases/song/search_song.dart';
import 'package:spotify_project/firebase_options.dart';
import 'package:spotify_project/core/router/app_router.dart';
import 'package:spotify_project/presentation/splash/bloc/auth_cubit.dart';
import 'package:spotify_project/presentation/splash/pages/splash.dart';
import 'package:spotify_project/service_locater.dart';
import 'presentation/choose_mode/bloc/theme_cubit.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();

  final storageDirectory = kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory();

  HydratedBloc.storage =
      await HydratedStorage.build(storageDirectory: storageDirectory);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  
  
   WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async{
        // final signIn = await sl<SigninUseCase>().call(params: SigninUserRequest(email: 'ziad.assem2001@gmail.com', password: 'Ziad2001'));

    runApp(MainApp());
  });
}

class MainApp extends StatelessWidget {

  MainApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_)=> AuthCubit()..checkSignedInUser())
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _appRouter.onGenerateRoute,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const SplashPage(),
        ),
      ),
    );
  }
}

testCase()async{
  final List<SongEntity> songs = [];
  try {
  final result = await sl<SearchSongUseCase>().call(params: {'query': 'Diamonds', 'songs': songs});
  List<SongEntity> playlistSongs = result.fold((l) => throw Exception(l.toString()), (r) => r);
  print(playlistSongs);
} on Exception catch (e) {
  print(e.toString());
  print('TEST HAS FAILED');
  // TODO
}
  
}