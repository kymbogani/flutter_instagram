/*
Auth Repository - Outlines the possible auth operation for this app.
*/
import 'package:instagram_app/features/authen/domain/entities/app_user.dart';

abstract class AuthRepo{
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}