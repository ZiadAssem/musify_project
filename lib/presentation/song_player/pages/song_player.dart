import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/song_player/bloc/cubit/song_player_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';

class SongPlayer extends StatelessWidget {
  final SongEntity song;
  const SongPlayer({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(' Now Playing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(song.songURL),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _songCover(context, song),
              _songInfo(song),
              _songPlayer(),
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
              image: NetworkImage(
                song.coverURL,
              ),
              fit: BoxFit.cover),
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
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          
          Icons.favorite_border_rounded,
          color: AppColors.darkGrey,
          size: 30,
        ),
      ),
      contentPadding:
          const EdgeInsets.all(16), // Padding for the ListTile itself
    );
  }

  Widget _songPlayer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          if (state is SongPlayerLoading) {
            return const CircularProgressIndicator();
          } else if (state is SongPlayerLoaded) {
            return _seekBar(context);
          } else if (state is SongPlayerLoadFailure) {
            return Text(state.message);
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }

  Widget _seekBar(BuildContext context) {
    return Column(
      children: [
        Slider(
          value:
              context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
          min: 0,
          max:
              context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
          onChanged: (value) {
            context.read<SongPlayerCubit>().seekSong(Duration(seconds: value.toInt()));
          },
          activeColor: AppColors.primary,
          inactiveColor: AppColors.grey,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDuration(context.read<SongPlayerCubit>().songPosition)),
            Text(formatDuration(context.read<SongPlayerCubit>().songDuration)),
          ],
        ),
        const SizedBox(height: 8),
        _playOrPauseButton(context),
      ],
    );
  }

  Widget _playOrPauseButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<SongPlayerCubit>().playOrPauseSong(),
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: context.read<SongPlayerCubit>().audioPlayer.playing
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
