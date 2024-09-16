import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';
import 'package:spotify_project/data/models/auth/signin_user_request.dart';
import 'package:spotify_project/service_locater.dart';

import '../../repository/auth/auth.dart';

class SigninUseCase implements UseCase<Either,SigninUserRequest>{
  @override
  Future<Either> call({SigninUserRequest ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
  
}