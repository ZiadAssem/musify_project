import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/appbar/app_bar.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/presentation/home/widgets/new_songs.dart';
import 'package:spotify_project/presentation/home/widgets/all_songs.dart';

import '../../../core/configs/theme/app_colors.dart';

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

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushReplacementNamed(context, '/profile')
                .then((result) {}),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                     SizedBox(height: 260, child: NewSongs()),
                    SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            290,
                        child:  AllSongs()),
                  ],
                ),
              ),
              Center(child: Text("Coming Soon")),
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
          padding: EdgeInsets.all(8),
          indicatorSize: TabBarIndicatorSize.tab,
          tabAlignment: TabAlignment.center,
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.darkGrey.withOpacity(0.5),
          ),
          isScrollable: true,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          tabs: const [
            Tab(text: 'New Songs'),
            Tab(text: 'Podcasts'),
          ]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
