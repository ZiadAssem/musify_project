import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/domain/entities/playlist/playlist.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

import '../bloc/playlists_cubit.dart';
import '../bloc/playlists_state.dart';

class PlaylistsListPage extends StatelessWidget {
  const PlaylistsListPage({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title:  Text('Playlists'),
      ),
      body: BlocProvider(
        create: (_) => PlaylistsCubit()..fetchPlaylists(),
        child: BlocBuilder<PlaylistsCubit, PlaylistsState>(
          builder: (context, state) {
            if (state ==  PlaylistsLoading()) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PlaylistsLoaded) {
              return _playlists(state.playlists);
            } else if (state is PlaylistsFailure) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return  Center(
                child: Text('${state.toString()} Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _playlists(List<PlaylistEntity> playlists) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return ListTile(
            tileColor: Colors.transparent,
            selected: false,
            leading: playlists[index].imageURL != null
                ? Image.network(playlists[index].imageURL!)
                : const Icon(Icons.image),
            title: Text(playlists[index].title!),
            subtitle: Text(playlists[index].description!,overflow: TextOverflow.ellipsis,),
          );
        }),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: playlists.length);
  }
}