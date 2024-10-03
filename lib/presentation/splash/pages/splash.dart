import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/presentation/splash/bloc/auth_cubit.dart';
import 'package:spotify_project/presentation/splash/bloc/auth_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('SplashPage');

    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            print(state);

            return Center(
              child: SvgPicture.asset(AppVectors.logo),
            );
          } else if (state is Authenticated) {
            print(state);
            redirect(context, '/root');
          } else if (state is UnAuthenticated) {
            print(state);

            redirect(context, '/authentication');
          }
           return Center(
              child: SvgPicture.asset(AppVectors.logo),
            );
        },
      ),
    );
  }

  Future<void> redirect(context, String route) async {
    await Future.delayed(const Duration(seconds: 2));
    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }
  
}
