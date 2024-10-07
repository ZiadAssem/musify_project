import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/home/widgets/play_button.dart';

import '../../../domain/entities/song/song.dart';
import '../bloc/new_songs_cubit.dart';
import '../bloc/new_songs_state.dart';

class NewSongs extends StatelessWidget {
   NewSongs({super.key});
   final List<SongEntity> fakeSongs = [
    SongEntity(
        title: 'title for song',
        artist: 'artist for',
        duration: 1,
        releaseDate: Timestamp.now(),
        coverURL: 'coverURL',
        songURL: 'songURL',
        isFavorite: false,
        songId: 'songId'),
    SongEntity(
        title: 'title for song',
        artist: 'artist for',
        duration: 1,
        releaseDate: Timestamp.now(),
        coverURL: 'coverURL',
        songURL: 'songURL',
        isFavorite: false,
        songId: 'songId'),
    SongEntity(
        title: 'title for song',
        artist: 'artist for',
        duration: 1,
        releaseDate: Timestamp.now(),
        coverURL: 'coverURL',
        songURL: 'songURL',
        isFavorite: false,
        songId: 'songId'),
  ];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewSongsCubit()..getNewSongs(),
      child: BlocBuilder<NewSongsCubit, NewSongsState>(
        builder: (context, state) {
          if (state is NewSongsLoading) {
            return Skeletonizer(child: _songs(context, fakeSongs,state));
          } else if (state is NewSongsLoaded) {
            print('SONGS: ${state.songs}');
            return _songs(context, state.songs,state);
          } else if (state is NewSongsLoadFailure) {
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

Widget _songs(context, List<SongEntity> songs,state) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 16.0,
      left: 16.0,
    ),
    child: SizedBox(
      height: 240,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const Divider(),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, '/song-player', arguments: {
              'songs': songs,
              'index': index,
            }),
            child: SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 160,
                      child: 
                      state is NewSongsLoading ?
                      Skeletonizer(
                        enabled: true,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.darkGrey,
                          ),
                        ),
                      ) :
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage(songs[index].coverURL),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: PlayButtonIcon(
                            dimensions: 40.0,
                            iconSize: 25.0,
                            onPressed: () {},
                            translationValues:
                                Matrix4.translationValues(10, 10, 0),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
