import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/screens/home_page.dart';
import '../provider/bottomnavigate_provider.dart';
 // Import your provider

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            'Your Cart is Empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Get some amazing products & offers',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Update the current index to 0 (Home)
              Provider.of<CurrentIndexProvider>(context, listen: false).update(0);
              // Navigate to Home_Page and remove all other routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home_Page()),
                (Route<dynamic> route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: kPrimarycolor,
              foregroundColor: kwhitecolor,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            ),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }
}
