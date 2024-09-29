import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_project/common/widgets/favorite_button.dart/favorite_button.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/widgets/play_button.dart';

import '../../../common/bloc/favorite_button/favorite_butoon_state.dart';
import '../bloc/all_songs_cubit.dart';
import '../bloc/all_songs_state.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllSongsCubit()..getAllSongs(),
      child: BlocBuilder<AllSongsCubit, AllSongsState>(
        builder: (context, state) {
          if (state == const AllSongsLoading()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllSongsLoaded) {
            return _songs(state.songs);
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
              onPressed: () => Navigator.pushNamed(context, '/song-player',
                  arguments: songs[index])),
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
                  child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
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
      itemCount: songs.length);
}

