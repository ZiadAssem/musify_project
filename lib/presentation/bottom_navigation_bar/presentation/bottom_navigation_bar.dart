import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_navigation_bar_cubit.dart';
import '../bloc/bottom_navigation_bar_state.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: BottomNavigationState.values.indexOf(state),
          onTap: (index) {
            switch (index) {
              case 0:
                context.read<BottomNavigationCubit>().selectHome();
                break;
              case 1:
                context.read<BottomNavigationCubit>().selectSearch();
                break;
              case 2:
                context.read<BottomNavigationCubit>().selectProfile();
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }
}