import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/common/widgets/favorite_button.dart/favorite_button.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/song_player/bloc/cubit/song_player_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';

class SongPlayer extends StatelessWidget {
  final List<SongEntity> songs;
  final int index;

  const SongPlayer({super.key, required this.songs, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text('Now Playing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSongs(songs, index),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<SongPlayerCubit, SongPlayerState>(
                builder: (context, state) {
                  final cubit = context.read<SongPlayerCubit>();
                  if (state is SongPlayerLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is SongPlayerLoaded) {
                    return Column(
                      children: [
                        _songCover(context, cubit.songs[cubit.currentIndex]),
                        _songInfo(cubit.songs[cubit.currentIndex]),
                        _seekBar(context),
                      ],
                    );
                  } else if (state is SongPlayerLoadFailure) {
                    return Text(state.message);
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context, SongEntity song) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              image: NetworkImage(song.coverURL), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _songInfo(SongEntity song) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            song.artist,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: AppColors.grey),
          ),
        ],
      ),
      trailing: FavoriteButton(song: song),
      contentPadding: const EdgeInsets.all(16),
    );
  }

  Widget _seekBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          final cubit = context.read<SongPlayerCubit>();
          return Column(
            children: [
              Slider(
                value: cubit.songPosition.inSeconds.toDouble(),
                min: 0,
                max: cubit.songDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  cubit.seekSong(Duration(seconds: value.toInt()));
                },
                activeColor: AppColors.primary,
                inactiveColor: AppColors.grey,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(cubit.songPosition)),
                  Text(formatDuration(cubit.songDuration)),
                ],
              ),
              const SizedBox(height: 8),
              _songNavigationButtons(context)
            ],
          );
        },
      ),
    );
  }

  Widget _playOrPauseButton(BuildContext context) {
    final cubit = context.read<SongPlayerCubit>();
    return GestureDetector(
      onTap: () => cubit.playOrPauseSong(),
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: cubit.audioPlayer.playing
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _songNavigationButtons(BuildContext context) {
    final cubit = context.read<SongPlayerCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: cubit.previousSong,
        ),
        _playOrPauseButton(context),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: cubit.nextSong,
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
