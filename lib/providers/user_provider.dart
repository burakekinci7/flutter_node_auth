import 'package:flutter/material.dart';
import 'package:flutter_node_auth/feature/models/user_model.dart';

/// Providers 
class UserProvider extends ChangeNotifier {
  UserModel _userModel = UserModel(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
  );

  /// Get user Model
  UserModel get userModel => _userModel;

  /// Ser User Model
  void setUser(String userModel) {
    _userModel = UserModel.fromJson(userModel);
    notifyListeners();
  }

  /// Set user mode to user model
  void setUserFromModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}
