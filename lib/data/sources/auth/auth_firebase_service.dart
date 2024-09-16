import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);

  Future<void> signin();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(createUserRequest) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserRequest.email, password: createUserRequest.password);

      return const Right('User created successfully');
    } on FirebaseAuthException catch (e) {
        String message = '';
        if(e.code == 'weak-password'){
          message = 'The password provided is weak.';
        }else if(e.code == 'email-already-in-use'){
          message = 'The account already exists for that email.';
        }
        return Left(message);
      }
  }
}
