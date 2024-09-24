import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';
import 'package:spotify_project/data/models/auth/signin_user_request.dart';
import 'package:spotify_project/data/models/auth/user.dart';
import 'package:spotify_project/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);

  Future<Either> signin(SigninUserRequest signinUserRequest);

  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserRequest.email, password: signinUserRequest.password);

      return const Right('Sign in was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserRequest.email, password: createUserRequest.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'email': data.user?.email,
        'name': createUserRequest.fullName,
      });

      return const Right('User created successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var user = await firestore
          .collection('Users')
          .doc(
            auth.currentUser?.uid,
          )
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.profileImageURL =
          auth.currentUser?.photoURL ?? AppURLS.defaultImage;
      UserEntity userEntity = userModel.toEntity();

      return Right(userEntity);
    } on Exception catch (_) {
      return const Left('An error occurred while fetching user data');
    }
  }
}
