import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/presentation/bottom_navigation_bar/bloc/bottom_navigation_bar_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState.home);

  void selectHome() => emit(BottomNavigationState.home);
  void selectSearch() => emit(BottomNavigationState.search);
  void selectProfile() => emit(BottomNavigationState.profile);
}