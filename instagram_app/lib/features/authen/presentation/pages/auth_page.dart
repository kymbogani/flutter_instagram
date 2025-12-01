/*
Auth page- This page determines whether to show the log in or register page
*/
import 'package:flutter/material.dart';
import 'package:instagram_app/features/authen/presentation/pages/log_in_page.dart';
import 'package:instagram_app/features/authen/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially, show loginpage
  bool showLoginPage = true;
  //toggle between pages
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInPage(
        togglePages: togglePages,
      );
    } else{
      return RegisterPage(
        togglePages: togglePages,
      );
    }
  }
}