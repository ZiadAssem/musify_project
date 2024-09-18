import 'package:flutter/material.dart';
import '../../../common/helpers/is_dark_mode.dart';

import '../../../core/configs/theme/app_colors.dart';

class PlayButtonIcon extends StatelessWidget {
  final double dimensions;
  final double iconSize;
  final Matrix4? translationValues;
  final VoidCallback onPressed;

  const PlayButtonIcon(
      {super.key,
      required this.dimensions,
      required this.iconSize,
      required this.onPressed,
      this.translationValues});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimensions,
      width: dimensions,
      transform: translationValues,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.isDarkMode
              ? AppColors.darkGrey
              : const Color(0xffE6E6E6)),
      child: IconButton(
        alignment: Alignment.topLeft,
        icon: const Icon(
          Icons.play_arrow_rounded,
        ),
        onPressed: onPressed,
        color: context.isDarkMode
            ? const Color(0xff959595)
            : const Color(0xff555555),
        iconSize: iconSize,
      ),
    );
  }
}
