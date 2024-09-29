import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/presentation/home/widgets/new_songs.dart';
import 'package:spotify_project/presentation/home/widgets/all_songs.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../bloc/all_songs_cubit.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/profile').then((result) {
             
            }),
          ),
        ],
        hideBackButton: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _homeTopCard(),
          _tabs(),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(

                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 250, child: NewSongs()),
                     Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Songs',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      _sortPopUpMenu(context),
                    ],
                  ),
                ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            250,
                        child: const AllSongs()),
                  ],
                ),
              ),
              Container(),
              Container(),
              Container(),
            ]),
          )
        ],
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              AppVectors.homeTopCard,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 60),
              child: Image.asset(AppImages.homeArtist),
            ),
          )
        ]),
      ),
    );
  }

  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
      ),
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          tabs: const [
            Tab(
              text: 'New Songs',
            ),
            Tab(text: 'Playlists'),
            Tab(text: 'Artists'),
            Tab(text: 'Podcasts'),
          ]),
    );
  }
Widget _sortPopUpMenu(context) {
  return PopupMenuButton<String>(
    onSelected: (String sortOption) {
      _sortSongs(context, sortOption);
    },
    itemBuilder: (BuildContext context) {
      return [
        const PopupMenuItem(
          value: 'Name',
          child: Text('Sort by Name'),
        ),
        const PopupMenuItem(
          value: 'Artist',
          child: Text('Sort by Artist'),
        ),
        const PopupMenuItem(
          value: 'Release Date',
          child: Text('Sort by Release Date'),
        ),
      ];
    },
    child: const Text(
      'Sort by',
      style: TextStyle(color: AppColors.primary),
    ),
  );
}

void _sortSongs(BuildContext context, String sortOption) {
  final cubit = context.read<AllSongsCubit>();
  cubit.sortSongsBy(sortOption);
}

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
