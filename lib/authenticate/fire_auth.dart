import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rent_tech/models/myuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //create myuser obj based on FirebaseUser
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(userID: user.uid) : null;
  }

  //checks status of user if signed in or not and chooses stream accordingly uses Provider
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  String getCurrentUser() {
    return _auth.currentUser!.uid;
  }

  String? getCurrentUserEmail() {
    return _auth.currentUser!.email;
  }

  Future updateCurrentUserEmail(String email, String password) async {
    try {
      //method requires recent authentication so you have to do this step
      User user = await _auth.currentUser!;
      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);
      await _auth.currentUser!.updateEmail(email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future updateCurrentUserPassword(String pwd, String oldpwd) async {
    try {
      //method requires recent authentication so you have to do this step
      User user = await _auth.currentUser!;
      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: oldpwd);
      await user.reauthenticateWithCredential(credential);
      _auth.currentUser!.updatePassword(pwd);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
    }
  }
}
