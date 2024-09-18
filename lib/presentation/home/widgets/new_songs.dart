import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

import '../../../domain/entities/song/song.dart';
import '../bloc/new_songs_cubit.dart';
import '../bloc/new_songs_state.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewSongsCubit()..getNewSongs(),
      child: BlocBuilder<NewSongsCubit, NewSongsState>(
        builder: (context, state) {
          if (state is NewSongsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NewSongsLoaded) {
            print('SONGS: ${state.songs}');
            return _songs(state.songs);
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

Widget _songs(List<SongEntity> songs) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0,left: 16.0),
    child: SizedBox(
      
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const Divider(),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(songs[index].coverURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height:40 ,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration:  BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode? AppColors.darkGrey: const Color(0xffE6E6E6)
                          ),
                          child: IconButton(
                            alignment: Alignment.topLeft,
                            
                            icon: const Icon(Icons.play_arrow_rounded,),
                            onPressed: () {},
                            color: context.isDarkMode?   const Color(0xff959595):const Color(0xff555555),
                            iconSize: 25,
                          ),
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
          );
        },
      ),
    ),
  );
}
