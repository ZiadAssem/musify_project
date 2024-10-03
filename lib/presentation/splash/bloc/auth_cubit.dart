
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locater.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit() : super(AuthInitial());

  Future<void> checkSignedInUser() async{
    final result =  sl<AuthRepository>().checkSignedInUser();
    return result.fold(
      (l) => emit(UnAuthenticated()), 
      (r) => emit(Authenticated()));
  }
}