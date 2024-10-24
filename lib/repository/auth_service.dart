import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AdminAuth{

}
abstract class BarberAuth{

}
class AdminAuthService implements AdminAuth {

}


abstract class LoginLogic {
  FirebaseAuth auth;
  LoginLogic({required this.auth});
  Future? login(String email, String password);
}

class LoginWithEmail implements LoginLogic {
  @override
  FirebaseAuth auth;
  LoginWithEmail({required this.auth});
  @override
  Future<UserCredential>? login(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }
}

abstract class AuthService {
  Future getUser();
  Future loginWithEmail(String email, String password);
  Future<UserCredential> registerUser(
      String login, String password);

  Future<void> logOut();
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late LoginLogic loginEmail = LoginWithEmail(auth: _firebaseAuth);
  User? _user;

  @override
  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> loginWithEmail(String email, String password) async {
    return await loginEmail.login(email, password);
  }

  @override
  Future<User?> getUser() async {
    if (_user != null) return _user;
    try {
      _user = _firebaseAuth.currentUser;
      return _user;
    } catch (e) {
      throw (Exception(e),);
    }
  }


  @override
  Future<UserCredential> registerUser(
      String email, String password) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firebaseFirestore.collection('Users').doc(user.user!.uid).set(
        {
          'uid': user.user!.uid,
          'email': user.user!.email,
          'code': 'User',
        },
      );
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
