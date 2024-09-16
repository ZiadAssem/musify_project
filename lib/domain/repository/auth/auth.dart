import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';

abstract class AuthRepository{

  Future<void> signin();

  Future<Either> signup(CreateUserRequest createUserRequest);


}