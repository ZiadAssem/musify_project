import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/pages/home.dart';
import '../../profile/pages/profile.dart';
import '../../search/pages/search_page.dart';
import '../bloc/bottom_navigation_bar_cubit.dart';
import '../bloc/bottom_navigation_bar_state.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          Widget page;

          switch (state) {
            case BottomNavigationState.home:
              page = HomePage(); // Replace with your HomePage widget
              break;
            case BottomNavigationState.search:
              page = SearchPage(); // Replace with your SearchPage widget
              break;
            case BottomNavigationState.profile:
              page = ProfilePage(); // Replace with your ProfilePage widget
              break;
          }

          return Scaffold(
            body: page,
            bottomNavigationBar: BottomNavigationBar(
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
            ),
          );
        },
      ),
    );
  }
}
