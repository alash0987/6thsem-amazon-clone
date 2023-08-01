// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:convert';

import 'package:amazonclone/constants/button_bar.dart';
import 'package:amazonclone/constants/error_handling.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/models/users.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //  SignUp user
  Future<void> signupUser(
      {required String email,
      required BuildContext context,
      required String password,
      required String name}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          type: '',
          token: '');
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(
                context: context, message: 'User created successfully');
          });
      debugPrint(res.body);
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
  }

  // Sign in user
  Future<void> signinUser(
      {required String email,
      required BuildContext context,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            showSnackbar(
                context: context, message: 'User logged in successfully');
            Navigator.pushNamedAndRemoveUntil(
                context, ButtomBar.routeName, (route) => false);
          });
      debugPrint(res.body);
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
  }

  //  Get user data
  getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      if (token == null) {
        pref.setString('x-auth-token', '');
      }
      var tokenRes = await http
          .post(Uri.parse('$uri/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        //  get user data
        http.Response userResponse =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
  }
}
