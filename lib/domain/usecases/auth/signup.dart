import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';
import 'package:spotify_project/service_locater.dart';

import '../../repository/auth/auth.dart';

class SignupUseCase implements UseCase<Either,CreateUserRequest>{
  @override
  Future<Either> call({CreateUserRequest ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
  
}