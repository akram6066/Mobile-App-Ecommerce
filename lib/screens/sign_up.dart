import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:test_app/config/themes.dart';
import 'package:test_app/provider/userProvider.dart';
import 'package:test_app/screens/home_page.dart';
import 'package:test_app/screens/log_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? photo;
  bool isLoading = false;
  bool passwordVisible = false;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photo = pickedFile.path;
      });
    }
  }

  void clearFields() {
    nameController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    setState(() {
      photo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: pickImage,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 85.0),
                        alignment: Alignment.center,
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: photo == null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-BV14ov6TF0vYDMEpM1eBSkBpvhTjTLNteE_gl29ZWA&s",
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error_outline),
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      File(photo!),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                            ),
                            if (photo ==
                                null) // Conditionally render based on whether photo is null
                              const Positioned(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Dimcad Online Shopping",
                style: AppTheme.kbigtitle
                    .copyWith(color: kPrimarycolor, fontSize: 14),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Get Started",
                style: AppTheme.kbodyfonts.copyWith(fontSize: 14),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(IconlyBold.profile),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Username",
                    prefixIcon: Icon(IconlyBold.call),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(IconlyBold.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Use a ternary operator to switch between the eye and eye-off icons
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          // Toggle the visibility state
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  obscureText:
                      !passwordVisible, // Show/hide the password based on visibility state
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home_Page()),
                  );
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 147.0),
                  child: Text(
                    "Already have an account?",
                    style: AppTheme.kbodyfonts.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: screenWidth * 0.8,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          if (passwordController.text.length < 8) {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Password is weak. Please use at least 8 characters.")),
                            );
                          } else {
                            await userProvider.signup(
                              name: nameController.text,
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              photo: photo,
                              onSuccess: (user) {
                                setState(() {
                                  isLoading = false;
                                });
                                clearFields();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home_Page()),
                                );
                              },
                              onError: (error) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                                clearFields();
                              },
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimarycolor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Sign Up",
                          style: AppTheme.kbodyfonts.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Forgot Password",
                style: AppTheme.kbodyfonts.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                """By continuing you agree to our Terms and 
                        Privacy Policy""",
                style: AppTheme.kbodyfonts.copyWith(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
