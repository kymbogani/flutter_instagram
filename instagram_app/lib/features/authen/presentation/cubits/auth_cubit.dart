/*
Auth Cubit: State Management
*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_app/features/authen/domain/entities/app_user.dart';
import 'package:instagram_app/features/authen/domain/repo/auth_repo.dart';
import 'package:instagram_app/features/authen/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentuser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  //check if user is already authenticated
  void checkAuth () async {
    final AppUser? user = await authRepo.getCurrentUser();
    if(user != null){
      _currentuser = user;
      emit(AuthAuthenticated(user));
    } else {
      emit(Authunauthenticated());
    }
  }
  // get current user
  AppUser? get currentUser => _currentuser;
  //login iwth email+password
  Future<void> login(String email, String password) async{
   try {
    
    emit(AuthLoading());
    final user = await authRepo.loginWithEmailPassword(email, password);

    if (user != null){
      _currentuser = user;
      emit(AuthAuthenticated(user));
  
    }
   }catch (e) {
    emit (AuthErrors(e.toString()));
    emit (Authunauthenticated());
   }
  } 
  //register iwth email+password
    Future<void> register(String name, String email, String password) async{
   try {
    
    emit(AuthLoading());
    final user = await authRepo.registerWithEmailPassword(name,  email, password);

    if (user != null){
      _currentuser = user;
      emit(AuthAuthenticated(user));
  
    }
   }catch (e) {
    emit (AuthErrors(e.toString()));
    emit (Authunauthenticated());
   }
  }
  //logout
  Future<void> logout() async {
    authRepo.logout();
    emit(Authunauthenticated());
  }
}


