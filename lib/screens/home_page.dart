import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/userProvider.dart';
import 'package:test_app/widgets/card_widget.dart';
import 'package:test_app/widgets/category_view.dart';
import 'package:test_app/widgets/header.dart';
import 'package:test_app/widgets/search_widget.dart';

import '../provider/bottomnavigate_provider.dart';
import '../widgets/bannerswidget.dart';
import '../widgets/bottomnavigation.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double mainAxisExtent = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              const Gap(3),
              const HeaderWidget(),
              const Gap(3),
              const SearchCard(),
              const Gap(3),
              CategoryView(
                screenHeight: screenHeight,
                mainAxisExtent: mainAxisExtent,
                screenWidth: screenWidth,
              ),
              const SizedBox(
                height: 12,
              ),
              BannersWidget(
                screenWidth: screenWidth,
                currentindex: currentindex,
                imageUrls: [],
                currentIndex: currentindex,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending 🔥",
                      style: AppTheme.kbodyfonts.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    // Text(
                    //   "More ",
                    //   style: AppTheme.kbodyfonts.copyWith(fontSize: 14),
                    // ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                // ignore: prefer_const_constructors
                child: CardWidget(
                  products: [],
                  imgUrl: [],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer<CurrentIndexProvider>(
        builder: (context, currentIndexProvider, _) {
          return BottomNavigationBarWidget(
            currentIndex: currentIndexProvider.currentIndex,
          );
        },
      ),
    );
  }
}
