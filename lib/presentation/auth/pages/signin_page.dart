import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/common/widgets/button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/core/configs/theme/app_theme.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      bottomNavigationBar: _signupText(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 30.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              _emailField(context),
              _passwordField(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: BasicAppButton(onPressed: () {}, title: 'Sign In'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Email',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Password',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _signupText(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not a member?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/signup');
          }, child: 
          const Text('Sign Up'))
        ],
      ),
    );
  }
}
