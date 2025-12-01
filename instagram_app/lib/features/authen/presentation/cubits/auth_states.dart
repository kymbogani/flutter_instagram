/*
Auth States
*/

import 'package:instagram_app/features/authen/domain/entities/app_user.dart';

abstract class AuthState {}

//initial
class AuthInitial extends AuthState{}
//loading
class AuthLoading extends AuthState{}
//authenticated
class AuthAuthenticated extends AuthState {
  final AppUser user;
  AuthAuthenticated(this.user);
}
//unauthenticated
class Authunauthenticated extends AuthState{}
//errors..
class AuthErrors extends AuthState{
  final String message;
  AuthErrors(this.message);
}