import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/domain/usecases/auth/signout.dart';
import '../../../common/helpers/is_dark_mode.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/favorite_button.dart/favorite_button.dart';
import '../../../service_locater.dart';
import '../bloc/favorite_songs_cubit.dart';
import '../bloc/favorite_songs_state.dart';
import '../bloc/profile_info_cubit.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        actions: [
          // This function needs to be separated from ui
          IconButton(
            onPressed: () async {
              // Show the loading dialog
              showDialog(
                context: context,
                barrierDismissible:
                    false, // Prevent closing the dialog by tapping outside
                builder: (context) => const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text('Signing out...'),
                    ],
                  ),
                ),
              );

              // Perform sign-out
              final result = await sl<SignoutUseCase>().call();

              // Close the loading dialog
              Navigator.of(context).pop();

              // Handle the result of sign-out
              result.fold(
                (failure) {
                  // Show an error message
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to sign out. Please try again.'),
                    ),
                  );
                },
                (success) {
                  // Navigate to sign-in page
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/signin', (route) => false);
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
        backgroundColor: Color(0xff2C2B2B),
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          const SizedBox(height: 25),
          SizedBox(
            height: 75,
            width: MediaQuery.of(context).size.width * 0.9,
            child: _buttonList(context),
          ),
          const SizedBox(height: 25),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileInfoLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: NetworkImage(state.user.profileImageURL!),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.user.fullName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.user.email!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            } else if (state is ProfileInfoError) {
              return const Center(
                child: Text('Error'),
              );
            }
            return const Text('Error');
          },
        ),
      ),
    );
  }

  Widget _buttonList(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _squareButton(() {
          Navigator.pushNamed(context, '/playlists');
        }, 'Playlists', icon: Icons.playlist_play),
        _squareButton(() {}, 'Artists', icon: Icons.person),
        _squareButton(() {}, 'Albums', icon: Icons.album),
        _squareButton(() {}, 'Genres', icon: Icons.library_music),
      ],
    );
  }

  Widget _squareButton(Function() onTap, String title, {IconData? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 30,
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 8, 8),
            child: Text('FAVORITE SONGS'),
          ),
          BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
            builder: (context, state) {
              if (state is FavoriteSongsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavoriteSongsLoaded) {
                return state.songs.isEmpty
                    ? const Text('You Have No Favorite Songs')
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5 - 120,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.songs.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return _songTile(context, state, index);
                          },
                        ),
                      );
              } else if (state is FavoriteSongsFailure) {
                return Text(state.message);
              }
              return const Text('Error');
            },
          ),
        ],
      ),
    );
  }

  Widget _songTile(BuildContext context, state, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(state.songs[index].coverURL),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.songs[index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.songs[index].artist,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(state.songs[index].duration.toString().replaceAll('.', ':')),
              FavoriteButton(
                key: UniqueKey(),
                song: state.songs[index],
                function: () {
                  context.read<FavoriteSongsCubit>().removeFavoriteSong(index);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
