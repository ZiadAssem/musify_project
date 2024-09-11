import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40,
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.chooseModeBG),
                    fit: BoxFit.cover)),
          ),
          Container(color: Colors.black.withOpacity(0.15)),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40,
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.logo)),
                const Spacer(),
                const Text(
                  'Choose Mode',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ModeButton(
                      onPressed: () {
                        context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                      },
                      vector: AppVectors.moon,
                      title: 'Dark Mode',
                    ),
                    // const SizedBox(width: 20),
                    ModeButton(
                      onPressed: () {
                        context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                      },
                      vector: AppVectors.sun,
                      title: 'Light Mode',
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                BasicAppButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/authentication'),
                    title: 'Continue ')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModeButton extends StatelessWidget {
  final String vector;
  final String title;
  final VoidCallback onPressed;
  const ModeButton(
      {super.key,
      required this.vector,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onPressed(),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF30393C).withOpacity(0.5),
                ),
                child: SvgPicture.asset(
                  vector,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: AppColors.grey),
        )
      ],
    );
  }
}
