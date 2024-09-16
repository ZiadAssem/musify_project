import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/common/widgets/button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/data/models/auth/create_user_request.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';

import '../../../service_locater.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      bottomNavigationBar: _signinText(context),
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
              _fullNameField(context),
              _emailField(context),
              _passwordField(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: BasicAppButton(
                    onPressed: () async {
                      var result = await sl<SignupUseCase>().call(
                        params: CreateUserRequest(
                            email: _emailController.text.trim().toString(),
                            password:
                                _passwordController.text.trim().toString(),
                            fullName:
                                _fullNameController.text.trim().toString()),
                      );
                      result.fold((l) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.toString())));
                      }, (r) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(r.toString())));
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/root', (route) => false);
                      });
                    },
                    title: 'Create Account'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: TextField(
        controller: _fullNameController,
        decoration: const InputDecoration(
          hintText: 'Full Name',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: TextField(
        controller: _emailController,
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
        controller: _passwordController,
        decoration: const InputDecoration(
          hintText: 'Password',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: const Text('Sign In'))
        ],
      ),
    );
  }
}
