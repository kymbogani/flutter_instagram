import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authen/data/firebase_auth_repo.dart';
import 'package:instagram_app/features/authen/post/presentation/pages/home_pag.dart';
import 'package:instagram_app/features/authen/presentation/cubits/auth_cubit.dart';
import 'package:instagram_app/features/authen/presentation/cubits/auth_states.dart';
import 'package:instagram_app/features/authen/presentation/pages/auth_page.dart' show AuthPage;
import 'package:instagram_app/themes/light_mode.dart' show ligthMode;

/*
APP - Root Level

repositories: for the database
 -firebase

 bloc providers: for state management
  -auth
  -profile
  -post
  -searh
  -theme

Check Auth State
 -unauthenticated -> auth page (log/register)
 -authenticated -> home page
*/

class MyApp extends StatelessWidget {
  //auth repo
  final authRepo = FireBaseAuthRepo();
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    //provide cubit to app
    return BlocProvider(create: (context) =>AuthCubit(authRepo: authRepo)..checkAuth(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ligthMode,
      home: BlocConsumer<AuthCubit, AuthState>(
        builder:(context, state) {
          print(AuthState);
          //-unauthenticated -> auth page (log/register)
          if(state is Authunauthenticated) {
            return const AuthPage();
          }
          //  -authenticated -> home page
          if (state is AuthAuthenticated) {
            return const HomePage();
          }
          //loading.....
          else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        //listen for errors...
        listener:(context, state) {
          if(state is AuthErrors){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(state.message)));
          }
        },
      ),
    ),
   );
  }
}
