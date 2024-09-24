import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_cubit.dart';
import '../../../common/helpers/is_dark_mode.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/favorite_button.dart/favorite_button.dart';
import '../bloc/favorite_songs_cubit.dart';
import '../bloc/favorite_songs_state.dart';
import '../bloc/profile_info_cubit.dart';
import '../bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppBar(
          backgroundColor: Color(0xff2C2B2B),
          title: Text('Profile'),
        ),
        body: Column(
          children: [
            _profileInfo(context),
            const SizedBox(height: 25),
            _favoriteSongs(),
          ],
        ));
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
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
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(state.user.profileImageURL!),
                  ),
                  const SizedBox(height: 10),
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

  Widget _favoriteSongs() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlaylistCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
        ),
        
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0, 8, 8),
            child: Text(
              'FAVORITE SONGS',
            ),
          ),
          BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
            if (state is FavoriteSongsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteSongsLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.songs.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
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
                                        image: NetworkImage(
                                            state.songs[index].coverURL)),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.songs[index].duration
                                    .toString()
                                    .replaceAll('.', ':')),
                                FavoriteButton(
                                  key: UniqueKey(),
                                  song: state.songs[index],
                                  function: () {
                                    // BUG NEEDS FIXING
                                    // context
                                    //     .read<PlaylistCubit>()
                                    //     .updateSongFavoriteStatus(
                                    //         state.songs[index]);
                                    context
                                        .read<FavoriteSongsCubit>()
                                        .removeFavoriteSong(index);
                                    
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } else if (state is FavoriteSongsFailure) {
              return Text(state.message);
            }
            return const Text('Error');
          })
        ],
      ),
    );
  }
}