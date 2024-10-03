import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/provider/cartprovider.dart';
import 'package:test_app/provider/category_provider.dart';
import 'package:test_app/provider/order_provider.dart';
import 'package:test_app/provider/product_provider.dart';
import 'package:test_app/provider/search%20provider.dart';
import 'package:test_app/provider/userProvider.dart';
import 'package:test_app/screens/home_page.dart';
import 'package:test_app/screens/log_in.dart';
import 'package:test_app/screens/sign_up.dart';

import 'provider/banner_provider.dart';
import 'provider/bottomnavigate_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  bool isLogin = box.hasData(kUserInfo) ?? false; // Ensure isLogin is not null

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MyApp(isLogin: isLogin),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLogin;

  const MyApp({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    // home: isLogin ? const Home_Page() : const Login(),
     home: Login(),
    );
  }
}
