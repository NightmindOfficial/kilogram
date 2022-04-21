import 'package:flutter/material.dart';
import 'package:kilogram/models/user.dart' as model;
import 'package:kilogram/resources/auth_methods.dart';

class UserDataProvider extends ChangeNotifier {
  model.User? _user;
  final AuthMethods _authMethods = AuthMethods();

  model.User get getUser =>
      _user ??
      const model.User(
          uid: "ERROR",
          uname: "ERROR",
          email: "ERROR",
          profilePictureUrl: "",
          bio: "ERROR",
          followers: [],
          following: []);

  Future<void> refreshUser() async {
    model.User updatedUser = await _authMethods.getUserDetails();
    _user = updatedUser;
    notifyListeners();
  }
}
