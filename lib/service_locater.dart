import 'package:get_it/get_it.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'domain/repository/auth/auth.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  

  sl.registerSingleton<AuthRepository>(AuthRepositoryIml());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
}