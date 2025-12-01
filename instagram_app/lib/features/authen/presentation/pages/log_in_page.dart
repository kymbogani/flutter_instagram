/*
Once the user successfully logs in, they will be redirected to home page.

if user doesn't have an account yet, they can go to register page from here to create one
 */


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authen/presentation/components/my_button.dart';
import 'package:instagram_app/features/authen/presentation/components/my_textfield.dart';
import 'package:instagram_app/features/authen/presentation/cubits/auth_cubit.dart';

class LogInPage extends StatefulWidget {
  final void Function ()? togglePages;

  const LogInPage({super.key, required this.togglePages});
  
  @override
  State<LogInPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LogInPage> {
  //text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  //login button pressed
  void login(){
    //prepare email & PW
    final email = emailController.text;
    final pw = pwController.text;
    //auth cubit
    final authCubit = context.read<AuthCubit>();
    //ensure that the email & pw fiels are not empty
    if(email.isNotEmpty && pw.isNotEmpty){
      //login!
      authCubit.login(email, pw);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter the both email and password')));
    }
  }
  @override
  void dispose () {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      //body
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 50),
              //Welcome back msg
              Text(
                "Welcome back, you've beee missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                 ),
                ),
                const  SizedBox(height: 25),
            
                //email textfiel
                MyTextfield(
                  controller: emailController, 
                  hintText: "Input Email:", 
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //pw textfield
                MyTextfield(
                  controller: pwController, 
                  hintText: 'Password:', 
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                //login button
                MyButton(
                  onTap: login, 
                  text: "Login",
                ),

                const SizedBox(height: 50),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        " Register now!",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}