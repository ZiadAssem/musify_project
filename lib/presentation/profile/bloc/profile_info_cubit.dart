import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/auth/get_user.dart';
import 'package:spotify_project/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_project/service_locater.dart';


class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await sl<GetUserUseCase>().call();

    user.fold((l) => emit(ProfileInfoError(message: l.toString())),
        (user) => emit(ProfileInfoLoaded(user: user)));
  }
}
