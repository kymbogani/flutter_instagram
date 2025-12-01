import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_app/features/authen/domain/entities/app_user.dart';
import 'package:instagram_app/features/authen/domain/repo/auth_repo.dart';

class FireBaseAuthRepo implements AuthRepo{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;



  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //attempt sign in
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
         email: email,
         name: '',
      );
      //return user
      return user;
     } 
      catch (e){
      throw Exception('Login Failed, Try Again!$e');
    }
  }
 
  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async {
   try {
      //attempt sign up
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
         email: email,
         name: name,
      );
      //return user
      return user;
     } 
      catch (e){
      throw Exception('Login Failed, Try Again!$e');
    }
  }
  
  @override
  Future<void> logout() async {

    await firebaseAuth.signOut();
  }
  
  @override
  Future<AppUser?> getCurrentUser() async {
    //get Current logged in user from firebase
   final firebaseUser = firebaseAuth.currentUser;

   if(firebaseUser == null) {
    return null;
   }
   // user exists
   return AppUser(
    uid: firebaseUser.uid, 
    email: firebaseUser.email!, 
    name: '',
    );
  }
}