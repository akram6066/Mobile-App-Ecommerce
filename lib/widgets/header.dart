import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Model/user_models.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/cartprovider.dart';
import 'package:badges/badges.dart' as badges;

import 'package:test_app/provider/userProvider.dart';
import 'package:test_app/screens/cart_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Consumer<UserProvider>(
      builder: (context, cont, child) {
        return Container(
          padding: const EdgeInsets.only(left: 10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: CachedNetworkImageProvider(
                "${cont.user.photo}",
                scale: 1.0,
              ),
            ), // Icon on the left side
            title: Text(
              cont.user.name ?? "Abdirizak",
              style: AppTheme.kbigtitle.copyWith(color: Colors.black),
            ),
            subtitle: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'welcome',
                  style: AppTheme.kbodyfonts,
                )),

            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: cartProvider.itemCount > 0
                  ? badges.Badge(
                      badgeContent: Text(
                        cartProvider.itemCount.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        padding: EdgeInsets.all(5),
                      ),
                      position: badges.BadgePosition.topEnd(top: 5, end: 5),
                      child: const Icon(
                        IconlyBold.bag_2,
                        color: kPrimarycolor,
                        size: 25,
                      ),
                    )
                  : const Icon(
                      IconlyBold.bag_2,
                      color: kPrimarycolor,
                      size: 25,
                    ),
            ),
          ),
        );
      },
    );
  }
}
