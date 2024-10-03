// // import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:test_app/config/themes.dart';
// import 'package:test_app/provider/userProvider.dart';
// import 'package:test_app/screens/home_page.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:iconly/iconly.dart';
// import 'package:page_transition/page_transition.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     username.dispose();
//     password.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 margin: const EdgeInsets.only(top: 85.0),
//                 alignment: Alignment.center,
//                 width: screenWidth * 0.25,
//                 height: screenWidth * 0.22,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: kPrimarycolor),
//                 ),
//                 child: ClipRRect(
//                   child: CachedNetworkImage(
//                     imageUrl:
//                         "https://img.freepik.com/free-vector/gradient-mobile-store-logo-design_23-2149699842.jpg?t=st=1715351101~exp=1715354701~hmac=5976a276c7f36bcdb0b7e589fa353fa494e0b6ce8a7ac245d0efded11b7408ac&w=740",
//                     placeholder: (context, url) =>
//                         const Center(child: CircularProgressIndicator()),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error_outline),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Dimcad Online Shopping",
//               style: AppTheme.kbigtitle
//                   .copyWith(color: kPrimarycolor, fontSize: 14),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "Get Started",
//               style: AppTheme.kbodyfonts.copyWith(fontSize: 14),
//             ),
//             const SizedBox(height: 60),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 40),
//               child: TextField(
//                 controller: username,
//                 decoration: const InputDecoration(
//                   hintText: "E-mail",
//                   prefixIcon: Icon(Icons.email),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 40),
//               child: TextField(
//                 controller: password,
//                 decoration: const InputDecoration(
//                   hintText: "Password",
//                   prefixIcon: Icon(IconlyBold.lock),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Login()),
//                 );
//                 setState(() {});
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 147.0),
//                 child: Text(
//                   "Don’t have an account?",
//                   style: AppTheme.kbodyfonts.copyWith(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                       fontSize: 14),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 100),
//             Consumer<UserProvider>(
//               builder: (context, cont, child) {
//                 return SizedBox(
//                   width: screenWidth * 0.8,
//                   height: 55,
//                   child: ElevatedButton(
//                     onPressed: cont.loginState == LoginState.loading
//                         ? null
//                         : () => cont.login(
//                             username: username.text,
//                             password: password.text,
//                             onSuccess: (user) {
//                               password.clear();
//                               Navigator.pushAndRemoveUntil(
//                                 context,
//                                 PageTransition(
//                                     child: const Home_Page(),
//                                     type: PageTransitionType.fade),
//                                 (route) => false,
//                               );
//                             },
//                             onError: (error) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(error.toString()),
//                                 ),
//                               );
//                             }),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kPrimarycolor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                     ),
//                     child: cont.loginState == LoginState.loading
//                         ? const CircularProgressIndicator()
//                         : const Text(
//                             "Sign in",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 30),
//             Text(
//               "Forgot Password",
//               style: AppTheme.kbodyfonts.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                   fontSize: 14),
//             ),
//             const SizedBox(height: 70),
//             Text(
//               """By continuing you agree to our Terms and
//                         Privacy Policy""",
//               style: AppTheme.kbodyfonts.copyWith(fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/userProvider.dart';
import 'package:test_app/screens/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:test_app/screens/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = false; // New variable to track password visibility

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 85.0),
                alignment: Alignment.center,
                width: screenWidth * 0.25,
                height: screenWidth * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kPrimarycolor),
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://img.freepik.com/free-vector/gradient-mobile-store-logo-design_23-2149699842.jpg?t=st=1715351101~exp=1715354701~hmac=5976a276c7f36bcdb0b7e589fa353fa494e0b6ce8a7ac245d0efded11b7408ac&w=740",
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "App Online Shopping",
              style: AppTheme.kbigtitle
                  .copyWith(color: kPrimarycolor, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              "Get Started",
              style: AppTheme.kbodyfonts.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: username,
                decoration: const InputDecoration(
                  hintText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType:
                    TextInputType.emailAddress, // Set keyboard type for email
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(IconlyBold.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible =
                            !passwordVisible; // Toggle password visibility
                      });
                    },
                  ),
                ),
                obscureText:
                    !passwordVisible, // Hide/show password based on visibility
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 147.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  });
                },
                child: Text(
                  "Don’t have an account?",
                  style: AppTheme.kbodyfonts.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Consumer<UserProvider>(
              builder: (context, cont, child) {
                return SizedBox(
                  width: screenWidth * 0.8,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: cont.loginState == LoginState.loading
                        ? null
                        : () => cont.login(
                            username: username.text,
                            password: password.text,
                            onSuccess: (user) {
                              password.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    child: const Home_Page(),
                                    type: PageTransitionType.fade),
                                (route) => false,
                              );
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.toString()),
                                ),
                              );
                            }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimarycolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: cont.loginState == LoginState.loading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Text(
              "Forgot Password",
              style: AppTheme.kbodyfonts.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 14),
            ),
            const SizedBox(height: 70),
            Text(
              """By continuing you agree to our Terms and 
                        Privacy Policy""",
              style: AppTheme.kbodyfonts.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
