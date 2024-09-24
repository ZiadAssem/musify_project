import 'package:flutter/material.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final bool hideBackButton;
  final Color backgroundColor;
  const BasicAppBar(
      {super.key, this.title, this.hideBackButton = false, this.actions, this.backgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: title,
      actions: actions,
      
      leading: hideBackButton
          ? null
          : IconButton(
              icon: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  )),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
