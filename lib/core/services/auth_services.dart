import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/feature/models/user_model.dart';
import 'package:flutter_node_auth/feature/utils/constants.dart';
import 'package:flutter_node_auth/feature/utils/http_error_handle.dart';
import 'package:flutter_node_auth/feature/view/home_view.dart';
import 'package:flutter_node_auth/feature/view/signup_view.dart';
import 'package:flutter_node_auth/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Authetication Service Operations
class AuthService {
  /// Sign up func (create new user)
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel userModel = UserModel(
        id: '',
        name: name,
        email: email,
        token: '',
        password: password,
      );

      http.Response res = await http.post(
          Uri.parse('${Constants.uri}/api/signup'),
          body: userModel.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (context.mounted) {
        httpHandleError(
          response: res,
          context: context,
          onSucces: () {
            showSnackBar(context, 'Account created! Login with the credentail');
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  /// Sign In User func (login - enter the app)
  /// ```dart
  /// AuthService authSErvice = AuthService();
  /// ```
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (context.mounted) {
        httpHandleError(
          response: res,
          context: context,
          onSucces: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await preferences.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
              (route) => false,
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'Sing in Error: $e');
      }
    }
  }

  /// Get User Data
  /// Authentication - for example changeUser
  Future<void> getUserData({required BuildContext context}) async {
    try {
      //var userProvider = context.read<UserProvider>();
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('x-auth-token');

      if (token == null) {
        preferences.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.uri}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var responce = jsonDecode(tokenRes.body);
      if (responce == true) {
        http.Response userRes = await http.get(
          Uri.parse('${Constants.uri}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print('loginnn main erororre');
    }
  }

  /// Sign Out User
  Future<void> signOut({required BuildContext context}) async {
    final NavigatorState navigator = Navigator.of(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SignUpView(),
        ),
        (route) => false);
  }
}
