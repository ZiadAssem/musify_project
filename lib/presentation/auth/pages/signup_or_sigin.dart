import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/common/widgets/button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(height: 40),
                  const Text('Welcome to Spotify',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Text('Millions of songs. Free on Spotify.',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: BasicAppButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                }, title: 'Register')),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/choose-mode');
                            },
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signin');
                              },
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ))
        ],
      ),
    );
  }
}
