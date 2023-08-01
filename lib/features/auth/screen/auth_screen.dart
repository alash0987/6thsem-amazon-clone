// ignore_for_file: must_be_immutable

import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/common/widgets/custom_textfield.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/auth/provider/login_signup_provider.dart';
import 'package:amazonclone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  bool isSelected = false;
  static const String routeName = '/auth_screen';
  AuthScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();
  final _signUpKey = GlobalKey<FormState>();
  final _loginKey = GlobalKey<FormState>();

  void signUpUser(BuildContext context) {
    authService.signupUser(
        email: _emailController.text,
        context: context,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser(BuildContext context) {
    authService.signinUser(
        email: _emailController.text,
        context: context,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Consumer<LoginSignupProvider>(builder: (context, provEnum, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    isSelected = !isSelected;
                    provEnum.authTypeFun =
                        isSelected ? AuthType.signup : AuthType.login;
                  },
                  child: ListTile(
                    tileColor: provEnum.authType == AuthType.signup
                        ? GlobalVariable.backgroundColor
                        : GlobalVariable.greyBackgroundColor,
                    title: const Text(
                      'Create Account',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariable.secondaryColor,
                      value: AuthType.signup,
                      groupValue: provEnum.authType,
                      onChanged: (value) {
                        provEnum.authTypeFun = value!;
                      },
                    ),
                  ),
                ),
                if (provEnum.authType == AuthType.signup)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariable.backgroundColor,
                    child: Form(
                        key: _signUpKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                hintText: 'Enter you name',
                                title: 'Name',
                                controller: _nameController),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: 'Enter you email',
                              title: 'Email',
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: 'Enter you password',
                              title: 'Password',
                              controller: _passwordController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                text: 'Sign Up',
                                onPressed: () {
                                  if (_signUpKey.currentState!.validate()) {
                                    signUpUser(context);
                                  }
                                })
                          ],
                        )),
                  ),
                InkWell(
                  onTap: () {
                    isSelected = !isSelected;
                    provEnum.authTypeFun =
                        isSelected ? AuthType.signup : AuthType.login;
                  },
                  child: ListTile(
                    tileColor: provEnum.authType == AuthType.login
                        ? GlobalVariable.backgroundColor
                        : GlobalVariable.greyBackgroundColor,
                    title: const Text(
                      'Sign-In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariable.secondaryColor,
                      value: AuthType.login,
                      groupValue: provEnum.authType,
                      onChanged: (value) {
                        provEnum.authTypeFun = value!;
                      },
                    ),
                  ),
                ),
                if (provEnum.authType == AuthType.login)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariable.backgroundColor,
                    child: Form(
                        key: _loginKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Enter you email',
                              title: 'Email',
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              hintText: 'Enter you password',
                              title: 'Password',
                              controller: _passwordController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                text: 'Login',
                                onPressed: () {
                                  if (_loginKey.currentState!.validate()) {
                                    debugPrint('login button pressed');
                                    signInUser(context);
                                    debugPrint('login button pressed');
                                  }
                                })
                          ],
                        )),
                  ),
              ],
            ),
          );
        }),
      )),
    );
  }
}
