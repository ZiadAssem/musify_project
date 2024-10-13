import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

import '../bloc/search_cubit.dart';

class SearchPage extends StatelessWidget {
  final bool addToPlaylist;
  final TextEditingController _searchController = TextEditingController();
  SearchPage({super.key, required this.addToPlaylist});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: BasicAppBar(
            title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            context.read<SearchCubit>().searchSongs(query);
          },
        )),
        body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          if (state is SearchInitial) {
            return const Center(
              child: Text('Search for songs'),
            );
          } else if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoaded) {
            return _songs(context, state.songs);
          } else if (state is SearchNoResults) {
            return Center(
              child: Text('No results found'),
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
        }),
      ),
    );
  }

  Widget _songs(BuildContext context, List<SongEntity> songs) {
    return Container();
  }
}
