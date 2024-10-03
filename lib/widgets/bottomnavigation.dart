import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconly/iconly.dart';
import 'package:test_app/Model/orders_model.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/screens/cart_screen.dart';
import 'package:test_app/screens/home_page.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/search_screen.dart';
import 'package:test_app/screens/transaction_history.dart';
import '../provider/bottomnavigate_provider.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentIndexProvider>(
      builder: (context, currentIndexProvider, _) {
        return BottomNavigationBar(
          currentIndex: currentIndexProvider.currentIndex,
          onTap: (value) {
            currentIndexProvider
                .update(value); // Update the currentIndexProvider
            // Navigate to the corresponding screen
            switch (value) {
              case 0:
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home_Page()),
                );
                break;
              case 1:
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
                break;
              case 2:
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );

                break;
              case 3:
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
                break;
            }
          },
          selectedItemColor: kPrimarycolor,
          unselectedItemColor: kSecondcolor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              label: "Home",
              activeIcon: Icon(IconlyBold.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.bag_2),
              label: "Cart",
              activeIcon: Icon(IconlyBold.bag_2),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.search),
              label: "History",
              activeIcon: Icon(IconlyBold.search),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile),
              label: "Profile",
              activeIcon: Icon(IconlyBold.profile),
            ),
          ],
        );
      },
    );
  }
}
