import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

import '../../../domain/entities/song/song.dart';
import '../../bloc/favorite_button/favorite_butoon_state.dart';
import '../../bloc/favorite_button/favorite_button_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity song;
  final Function? function;
  const FavoriteButton({super.key, required this.song, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              icon: (song.isFavorite ?? false)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              iconSize: 25,
              color: AppColors.darkGrey,
              onPressed: () async {
                await context.read<FavoriteButtonCubit>().updateFavorite(song.songId);
                if(function!=null){
                  function!();
                }
              },
            );
          } else if (state is FavoriteButtonUpdated) {
            return IconButton(
              icon: state.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              iconSize: 25,
              color: AppColors.darkGrey,
              onPressed: () {
                context.read<FavoriteButtonCubit>().updateFavorite(song.songId);
              },
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
