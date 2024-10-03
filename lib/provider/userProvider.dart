// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:test_app/Model/user_models.dart';
// import 'package:test_app/services/user.dart';
// import 'package:test_app/config/constant.dart';

// enum LoginState {
//   normal,
//   loading,
//   success,
//   error,
// }

// class UserProvider extends ChangeNotifier {
//   UserModel user = UserModel();
//   LoginState loginState = LoginState.normal;
//   final box = GetStorage();

//     UserModel? _currentUser;

//   UserModel? get currentUser => _currentUser;

//   UserProvider() {
//     _loadUser();
//   }

//   Future<void> login({
//     String? username,
//     String? email,
//     required String password,
//     Function(UserModel)? onSuccess,
//     Function(String)? onError,
//   }) async {
//     try {
//       loginState = LoginState.loading;
//       notifyListeners();
//       user = await UserServices().login(username: username, email: email, password: password);
//       await saveUser(user);
//       loginState = LoginState.success;
//       notifyListeners();
//       if (onSuccess != null) {
//         onSuccess(user);
//       }
//     } catch (e) {
//       loginState = LoginState.error;
//       notifyListeners();
//       if (onError != null) {
//         onError(e.toString());
//       }
//     }
//   }

//     Future<void> signup({
//     required String name,
//     required String username,
//     required String email,
//     required String password,
//     String? photo,
//     Function(UserModel)? onSuccess,
//     Function(String)? onError,
//   }) async {
//     try {
//       loginState = LoginState.loading;
//       notifyListeners();
//       user = await UserServices().signup(
//         name: name,
//         username: username,
//         email: email,
//         password: password,
//         photo: photo,
//       );
//       await saveUser(user);
//       loginState = LoginState.success;
//       notifyListeners();
//       if (onSuccess != null) {
//         onSuccess(user);
//       }
//     } catch (e) {
//       loginState = LoginState.error;
//       notifyListeners();
//       if (onError != null) {
//         onError(e.toString());
//       }
//     }
//   }

//   void _loadUser() {
//     if (box.hasData(kUserInfo)) {
//       final json = box.read(kUserInfo);
//       if (json != null) {
//         user = UserModel.fromJson(json);
//         notifyListeners();
//       }
//     }
//   }

//   Future<void> saveUser(UserModel user) async {
//     box.write(kUserInfo, user.toJson());
//   }

//    void setUser(UserModel user) {
//     _currentUser = user;
//     notifyListeners();
//   }

//   void clearUser() {
//     _currentUser = null;
//     notifyListeners();
//   }
// }
// user_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_app/Model/user_models.dart';
import 'package:test_app/config/constant.dart';
import 'package:test_app/services/user.dart';

enum LoginState {
  normal,
  loading,
  success,
  error,
}

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel();
  LoginState loginState = LoginState.normal;
  final box = GetStorage();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  UserProvider() {
    _loadUser();
  }

  Future<void> login({
    String? username,
    String? email,
    required String password,
    Function(UserModel)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      loginState = LoginState.loading;
      notifyListeners();
      user = await UserServices()
          .login(username: username, email: email, password: password);
      await saveUser(user);
      _currentUser = user;
      loginState = LoginState.success;
      notifyListeners();
      if (onSuccess != null) {
        onSuccess(user);
      }
    } catch (e) {
      loginState = LoginState.error;
      notifyListeners();
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  Future<void> signup({
    required String name,
    required String username,
    required String email,
    required String password,
    String? photo,
    Function(UserModel)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      loginState = LoginState.loading;
      notifyListeners();
      user = await UserServices().signup(
        name: name,
        username: username,
        email: email,
        password: password,
        photo: photo,
      );
      await saveUser(user);
      _currentUser = user;
      loginState = LoginState.success;
      notifyListeners();
      if (onSuccess != null) {
        onSuccess(user);
      }
    } catch (e) {
      loginState = LoginState.error;
      notifyListeners();
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  void _loadUser() {
    if (box.hasData(kUserInfo)) {
      final json = box.read(kUserInfo);
      if (json != null) {
        user = UserModel.fromJson(json);
        _currentUser = user;
        notifyListeners();
      }
    }
  }

  Future<void> saveUser(UserModel user) async {
    await box.write(kUserInfo, user.toJson());
  }

  void setUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }
}
