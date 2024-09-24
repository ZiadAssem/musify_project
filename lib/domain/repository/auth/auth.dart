import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';
import 'package:spotify_project/data/models/auth/signin_user_request.dart';

abstract class AuthRepository{

  Future<Either> signin(SigninUserRequest signinUserRequest);

  Future<Either> signup(CreateUserRequest createUserRequest);

  Future<Either> getUser();

}