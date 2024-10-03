import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';

import '../../../service_locater.dart';

class SignoutUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call({params})async {
    return sl<AuthRepository>().signout();
  }
  
}