import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/search/bloc/add_songs_to_playlist_cubit.dart';

import '../../../common/bloc/favorite_button/favorite_button_state.dart';
import '../../../common/bloc/favorite_button/favorite_button_cubit.dart';
import '../../../common/widgets/favorite_button.dart/favorite_button.dart';
import '../../home/widgets/play_button.dart';
import '../bloc/search_cubit.dart';

class SearchPage extends StatelessWidget {
  final String? playlistId;
  final List<String>? playlistSongsId;

  final TextEditingController _searchController = TextEditingController();
  SearchPage({super.key, this.playlistSongsId, this.playlistId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchCubit()),
        if (playlistId != null)
          BlocProvider(create: (context) => AddSongsToPlaylistCubit()),
      ],
      child: Scaffold(
        appBar: BasicAppBar(
          title: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  isCollapsed: true,
                  hintText: 'Search',
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none, // Removes enabled border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none, // Removes focused border
                  ),
                ),
                onChanged: (query) {
                  context.read<SearchCubit>().searchSongs(query);
                },
              );
            },
          ),
          actions: [
            playlistId != null
                ? BlocBuilder<AddSongsToPlaylistCubit, AddSongsToPlaylistState>(
                    builder: (context, state) {
                      return BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          return IconButton(
                              onPressed: () {
                                context
                                    .read<AddSongsToPlaylistCubit>()
                                    .addSongsToPlaylist(
                                        playlistId!, playlistSongsId!);
                              },
                              icon: const Icon(Icons.check));
                        },
                      );
                    },
                  )
                : Container()
          ],
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial || _searchController.text.isEmpty) {
              return const Center(
                child: Text('Search for songs', style: TextStyle(fontSize: 20),),
              );
            } else if (state is SearchLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchLoaded) {
              return _songs(state.songs);
            } else if (state is SearchNoResults) {
              return Center(
                child: Text('No results found',style: TextStyle(fontSize: 20),),
              );
            } else if (state is SearchFailure) {
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
          leading: playlistSongsId != null
              ? Checkbox(
                  value: playlistSongsId!.contains(songs[index].songId),
                  onChanged: (value) {
                    if (playlistSongsId!.contains(songs[index].songId) ==
                        false) {
                      playlistSongsId!.add(songs[index].songId);
                    } else {
                      playlistSongsId!.remove(songs[index].songId);
                    }
                  },
                )
              : PlayButtonIcon(
                  dimensions: 50,
                  iconSize: 35,
                  onPressed: () =>
                      Navigator.pushNamed(context, '/song-player', arguments: {
                    'songs': songs,
                    'index': index,
                  }),
                ),
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
                        if (state is FavoriteButtonInitial ||
                            state is FavoriteButtonUpdated) {
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
      separatorBuilder: (context, index) => const Divider(),
      itemCount: songs.length,
    );
  }
}
