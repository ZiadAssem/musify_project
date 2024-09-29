import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/presentation/playlist_details/bloc/playlist_details_cubit.dart';

import '../../../domain/entities/song/song.dart';
import '../bloc/playlist_details_state.dart';

class PlaylistDetailsPage extends StatelessWidget {
  final List<String> songURLs;
  const PlaylistDetailsPage({super.key, required this.songURLs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text('Playlist Details'),
      ),
      body: BlocProvider(
        create: (context) =>
            PlaylistDetailsCubit()..fetchPlaylistDetails(songURLs),
        child: BlocBuilder<PlaylistDetailsCubit, PlaylistDetailsState>(
          builder: (context, state) {
            if (state is PlaylistDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PlaylistDetailsLoaded) {
              return _songs(state.songs);
            } else if (state is PlaylistDetailsLoadFailure) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(' Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        return ListTile(
          tileColor: Colors.transparent,
          selected: false,
          leading: Image.network(songs[index].coverURL),
          title: Text(songs[index].title),
          subtitle: Text(songs[index].artist,overflow: TextOverflow.ellipsis,),
        
        );
      }),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: songs.length,
    );
  }
}
