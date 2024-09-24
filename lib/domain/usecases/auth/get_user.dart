import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/service_locater.dart';

import '../../repository/auth/auth.dart';

class GetUserUseCase implements UseCase<Either, dynamic>{
  @override
  Future<Either> call({ params}) async {
    return sl<AuthRepository>().getUser();
  }
  
}