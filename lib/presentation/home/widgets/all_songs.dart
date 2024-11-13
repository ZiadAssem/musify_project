import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spotify_project/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/loading_dummy/loading_dummy.dart';
import 'package:spotify_project/common/widgets/favorite_button.dart/favorite_button.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/widgets/play_button.dart';

import '../../../common/bloc/favorite_button/favorite_button_state.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/all_songs_cubit.dart';
import '../bloc/all_songs_state.dart';

class AllSongs extends StatelessWidget {
  AllSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllSongsCubit()..getAllSongs(),
      child: BlocBuilder<AllSongsCubit, AllSongsState>(
        builder: (context, state) {
          if (state is AllSongsLoading) {
            return Skeletonizer(
              enabled: true,
              child: Column(
                children: [
                  _topRow(context),
                  _songs(LoadingDummy.dummySongs),
                ],
              ),
            );
          } else if (state is AllSongsLoaded) {
            return Column(
              children: [
                _topRow(context),
                _songs(state.songs),
              ],
            );
          } else if (state is AllSongsLoadFailure) {
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

Widget _topRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'All Songs',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _sortPopUpMenu(context),
      ],
    ),
  );
}

Widget _songs(List<SongEntity> songs) {
  return ListView.separated(
    
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        return ListTile(
          tileColor: Colors.transparent,
          selected: false,
          leading: PlayButtonIcon(
              dimensions: 50,
              iconSize: 35,
              onPressed: () =>
                  Navigator.pushNamed(context, '/song-player', arguments: {
                    'songs': songs,
                    'index': index,
                  })),
          title: Text(songs[index].title),
          subtitle: Text(songs[index].artist),
          trailing: SizedBox(
            width: 100,
            child: Skeleton.unite(
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
          ),
        );
      }),
      separatorBuilder: (context, index) => const Divider(color: AppColors.darkGrey, thickness: 0.5,),
      itemCount: songs.length);
}

Widget _sortPopUpMenu(BuildContext context) {
  return PopupMenuButton<String>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
    onSelected: (String sortOption) {
      _sortSongs(context, sortOption);
    },
    itemBuilder: (BuildContext context) {
      return [
        const PopupMenuItem(value: 'Name', child: Text('Name')),
        const PopupMenuItem(value: 'Artist', child: Text('Artist')),
        const PopupMenuItem(value: 'Release Date', child: Text('Release Date')),
      ];
    },
    child: const Text(
      'Sort by',
      style: TextStyle(color: AppColors.primary),
    ),
  );
}

void _sortSongs(BuildContext context, String sortOption) {
  final cubit = context.read<AllSongsCubit>();
  cubit.sortSongsBy(sortOption);
}
