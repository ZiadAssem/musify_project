import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_project/common/widgets/favorite_button.dart/favorite_button.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_cubit.dart';
import 'package:spotify_project/presentation/home/widgets/play_button.dart';
import 'package:spotify_project/presentation/home/widgets/shimmer/playlist_shimmer.dart';
import 'package:spotify_project/presentation/home/widgets/shimmer/shimmer_loading.dart';
import 'shimmer/shimmer.dart';

import '../../../common/bloc/favorite_button/favorite_butoon_state.dart';
import '../bloc/playlist_state.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state == const PlaylistLoading()) {
            return const Center(
              child: PlaylistShimmer(),
            );
          } else if (state is PlaylistLoaded) {
            return  
            // Shimmer(
            //   linearGradient: AppColors.shimmerGradient,
            //   child: PlaylistShimmer(),
              // );
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Playlist',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See More',
                            style: TextStyle(color: AppColors.primary),
                          ))
                    ],
                  ),
                ),
                _songs(state.songs),
              ],
            );
          } else if (state is PlaylistLoadFailure) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}

Widget _songs(List<SongEntity> songs) {
  return SizedBox(
    child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return ListTile(
            tileColor: Colors.transparent,
            selected: false,
            leading: PlayButtonIcon(
              dimensions: 50,
              iconSize: 35,
              onPressed: () => Navigator.pushNamed(context, '/song-player',
                      arguments: songs[index])
                  
            ),
            title: Text(songs[index].title),
            subtitle: Text(songs[index].artist),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(songs[index].duration.toString().replaceAll('.', ':')),
                  BlocProvider(
                    create: (context) => FavoriteButtonCubit(),
                    child:
                        BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
                      builder: (context, state) {
                        if (state is FavoriteButtonInitial) {
                          return FavoriteButton(song: songs[index]);
                        } else if (state is FavoriteButtonUpdated) {
                          return FavoriteButton(song: songs[index]);
                        } else {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: songs.length),
  );
}
