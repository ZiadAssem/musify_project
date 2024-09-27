import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';
import 'package:spotify_project/data/models/auth/signin_user_request.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locater.dart';
import '../../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async {
    print('test: Entered domain AbstractAuthRepo into data AuthRepoImpl:');
    return await sl<AuthFirebaseService>().signin(signinUserRequest);
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    return await sl<AuthFirebaseService>().signup(createUserRequest);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }
}
