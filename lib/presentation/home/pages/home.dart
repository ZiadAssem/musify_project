import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/presentation/home/widgets/new_songs.dart';
import 'package:spotify_project/presentation/home/widgets/playlist.dart';

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
        hideBackButton: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            const NewSongs(),
            const SizedBox(height: 8),
            const Playlist(),
          ],
        ),
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
      padding: const EdgeInsets.only(top: 16.0,),
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          tabs: const [
            Tab(text: 'New',),
            Tab(text: 'Videos'),
            Tab(text: 'Artists'),
            Tab(text: 'Podcasts'),
          ]),
    );
  }
}
