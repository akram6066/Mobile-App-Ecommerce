// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:test_app/config/themes.dart';
// import 'package:test_app/provider/bottomnavigate_provider.dart';
// import 'package:test_app/screens/home_page.dart';
// import '../widgets/bottomnavigation.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Update the current index to Home
//             Provider.of<CurrentIndexProvider>(context, listen: false).update(0);
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const Home_Page()),
//               (Route<dynamic> route) => false,
//             );
//           },
//         ),
//         title: const Text('Profile'),
//         backgroundColor: kPrimarycolor,
//         foregroundColor: kwhitecolor,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double screenWidth = constraints.maxWidth;
//           double screenHeight = constraints.maxHeight;
//           double imageSize = screenWidth * 0.3;

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: screenHeight * 0.05),
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: imageSize / 2,
//                         backgroundColor: Colors.grey.shade300,
//                         backgroundImage: const AssetImage('assets/profile_placeholder.png'), // Replace with actual image
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           width: imageSize * 0.3,
//                           height: imageSize * 0.3,
//                           decoration: const BoxDecoration(
//                             color: kPrimarycolor,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: imageSize * 0.15,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.05),
//                   Form(
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           initialValue: 'Abdirizak',
//                           decoration: InputDecoration(
//                             labelText: 'First name',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'User Name',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         TextFormField(
//                           initialValue: '683649109',
//                           decoration: InputDecoration(
//                             labelText: 'Number',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.04),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: kPrimarycolor,
//                             foregroundColor: kwhitecolor,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth * 0.25,
//                               vertical: screenHeight * 0.02,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           child: const Text('EDIT PROFILE'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Consumer<CurrentIndexProvider>(
//         builder: (context, currentIndexProvider, _) {
//           return BottomNavigationBarWidget(
//             currentIndex: currentIndexProvider.currentIndex,
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/bottomnavigate_provider.dart';

import 'package:test_app/screens/home_page.dart';
import '../provider/userProvider.dart';
import '../widgets/bottomnavigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Update the current index to Home
            Provider.of<CurrentIndexProvider>(context, listen: false).update(0);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home_Page()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Text('Profile'),
        backgroundColor: kPrimarycolor,
        foregroundColor: kwhitecolor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double imageSize = screenWidth * 0.3;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: imageSize / 2,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: ("$kEndpoint/${user.photo}") != null
                            ? NetworkImage("$kEndpoint/${user.photo!}")
                            : const AssetImage('assets/profile_placeholder.png')
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: imageSize * 0.3,
                          height: imageSize * 0.3,
                          decoration: const BoxDecoration(
                            color: kPrimarycolor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: imageSize * 0.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: user.name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          initialValue: user.username,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          initialValue: user.email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimarycolor,
                            foregroundColor: kwhitecolor,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.25,
                              vertical: screenHeight * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text('EDIT PROFILE'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
