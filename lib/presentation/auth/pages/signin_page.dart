import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/common/widgets/button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/data/models/auth/signin_user_request.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';

import '../../../service_locater.dart';

class SigninPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SigninPage({super.key});

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
          physics:BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              _registerText(),
              _emailField(context),
              _passwordField(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: BasicAppButton(
                    onPressed: () async {
                      var result = await sl<SigninUseCase>().call(
                        params: SigninUserRequest(
                          email: _emailController.text.trim().toString(),
                          password: _passwordController.text.trim().toString(),
                        ),
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
                    title: 'Sign In'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Column(
      children: [
         Text(
          'Sign In',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          'Get back in, enjoy your customized playlists and continue listening to your favorite artists!',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _emailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
        obscureText: true,
        controller: _passwordController,
        decoration: const InputDecoration(
          hintText: 'Password',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
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
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: const Text('Sign Up'))
        ],
      ),
    );
  }
}
