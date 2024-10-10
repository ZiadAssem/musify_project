import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/playlist/playlist.dart';
import 'package:spotify_project/presentation/playlists/bloc/create_playlist_cubit.dart';
import 'package:spotify_project/presentation/playlists/bloc/create_playlist_state.dart';

import '../bloc/playlists_cubit.dart';
import '../bloc/playlists_state.dart';

class PlaylistsListPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  PlaylistsListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: Text('Playlists'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Show dialog box with a form
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlocProvider(
                  create: (context) => CreatePlaylistCubit(),
                  child: BlocBuilder<CreatePlaylistCubit,CreatePlaylistState>(
                    builder: (context, state) {
                    return _createPlaylistDialog(context,state);
                  }),
                );
              });
        },
        backgroundColor: AppColors.primary,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          1,
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (_) => PlaylistsCubit()..fetchPlaylists(),
        child: BlocBuilder<PlaylistsCubit, PlaylistsState>(
          builder: (context, state) {
            if (state is PlaylistsLoading) {
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
              return Center(
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
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/playlist-details',
                  arguments: playlists[index]);
            },
            child: ListTile(
              tileColor: Colors.transparent,
              selected: false,
              leading: playlists[index].imageURL != null
                  ? Image.network(playlists[index].imageURL!)
                  : const Icon(Icons.image),
              title: Text(playlists[index].title!),
              subtitle: Text(
                playlists[index].description!,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: playlists.length);
  }

  Widget _createPlaylistDialog(BuildContext context ,  state) {
    return AlertDialog(
      title: Text('New Playlist'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            //Create playlist
            context.read<CreatePlaylistCubit>().createPlaylist(
                _titleController.text, _descriptionController.text, []);
            
          },
          child: Text('Create'),
        ),
      ],
      content: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ).applyDefaults(Theme.of(context).inputDecorationTheme),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ).applyDefaults(Theme.of(context).inputDecorationTheme),
          ),
          if(state is CreatePlaylistInitial)
            const Text(''),
          if(state is CreatingPlaylist)
            const CircularProgressIndicator(),
          if(state is CreatePlaylistFailure)
            Text(state.message),
          if(state is CreatePlaylistSuccess)
            Text(state.message),
        ],
      ),
    );
  }
}
