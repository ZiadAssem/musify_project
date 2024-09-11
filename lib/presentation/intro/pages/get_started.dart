import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/widgets/button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.introBG), fit: BoxFit.cover)),
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
                'Enjoy Listening To Music',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 21),
              const Text(
                'Explore millions of songs to listen, share, and discover new favorites. Connect with friends, create playlists, and enjoy endless music anywhere, anytime.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              BasicAppButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/choose-mode');
                  },
                  title: 'Get Started')
            ],
          ),
        ),
      ]),
    );
  }
}
