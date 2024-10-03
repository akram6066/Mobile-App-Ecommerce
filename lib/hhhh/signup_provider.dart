import 'package:flutter/material.dart';
import 'package:test_app/Model/user_models.dart';

import 'package:test_app/services/signup_services.dart';

enum SignupState {
  normal,
  loading,
  success,
  error,
}

class SignupProvider extends ChangeNotifier {
  final SignUpServices userServices;

  SignupProvider({required this.userServices});

  SignupState _signupState = SignupState.normal;

  SignupState get signupState => _signupState;

  set signupState(SignupState state) {
    _signupState = state;
    notifyListeners();
  }

  Future<void> signup({
    required String name,
    required String username,
    required String email,
    required String password,
    String? photo,
    required Function(UserModel) onSuccess,
    required Function(String) onError,
  }) async {
    try {
      signupState = SignupState.loading;

      final UserModel? user = await userServices.signup(
        name: name,
        username: username,
        email: email,
        password: password,
        photo: photo,
      );

      if (user != null) {
        signupState = SignupState.success;
        onSuccess(user);
      } else {
        signupState = SignupState.error;
        onError("Signup failed. Please try again.");
      }
    } catch (error) {
      signupState = SignupState.error;
      onError(error.toString());
    }
  }
}
