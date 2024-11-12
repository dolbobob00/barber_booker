import 'package:barber_booker/repository/admin_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AdminAuth {}

abstract class BarberAuth {}

class AdminAuthService implements AdminAuth {}

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
  Future<UserCredential?>? login(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on PlatformException catch (e) {
      print(e);
      return null;
    }
  }
}

abstract class AuthService {
  Future getUser();
  Future loginWithEmail(String email, String password);
  Future<UserCredential> registerUser(String login, String password);
  Future<void> logOut();
  Future<String> getUserStatus(String uid);
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> loginByCode(String specialUid);
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AdminService _adminService = FirebaseAdminService();
  late LoginLogic loginEmail = LoginWithEmail(auth: _firebaseAuth);
  User? _user;

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        print('User cancelled the sign-in process.');
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await _firebaseFirestore.collection('Users').doc(gUser.id).set({
        'uid': gUser.id,
        'email': gUser.email,
        'code': 'user',
        'name': gUser.displayName,
        'phone': 'null',
        'lastdate': 'null',
      });

      return await _firebaseAuth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        print('Sign-in was canceled by user.');
        return null;
      } else {
        print('PlatformException: ${e.message}');
        return null;
      }
    } catch (e) {
      print('Unknown error during Google Sign-In: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> loginByCode(String specialUid) async {
    final docs = await _adminService.fetchBarbersDocs();

    for (var doc in docs) {
      if (doc['specialUidCode'] == specialUid &&
          (doc['code'] == 'barber' || doc['code'] == 'admin')) {
        try {
          final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: doc['email'],
            password: doc['password'],
          );
          return userCredential;
        } catch (e) {
          try {
            final userCredential =
                await _firebaseAuth.createUserWithEmailAndPassword(
              email: doc['email'],
              password: doc['password'],
            );
            await _firebaseFirestore.collection('Users').doc(doc['uid']).set(
              {
                'uid': doc['uid'],
                'email': userCredential.user!.email,
                'code': 'barber',
                'name': 'User-${userCredential.user!.uid}',
                'phone': 'null',
                'lastdate': 'null',
                'specialUidCode': specialUid,
              },
            );
            return userCredential;
          } on FirebaseAuthException {
            rethrow;
          }
        }
      }
    }

    // Если пользователь с данным specialUid не найден, возвращаем null
    return null;
  }

  @override
  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String> getUserStatus(String uid) async {
    try {
      print('get user status start');
      final querySnapshot =
          await _firebaseFirestore.collection('Users').doc(uid).get();
      print('return user status this is ${querySnapshot['code']}');
      return querySnapshot['code'];
    } catch (e) {
      return 'ERORR';
    }
  }

  @override
  Future<UserCredential> loginWithEmail(String email, String password) async {
    try {
      return await loginEmail.login(email, password);
    } on FirebaseAuthException {
      rethrow;
    }
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
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firebaseFirestore.collection('Users').doc(user.user!.uid).set(
        {
          'uid': user.user!.uid,
          'email': user.user!.email,
          'code': 'user',
          'name': 'User-${user.user!.uid}',
          'phone': 'null',
          'lastdate': 'null',
          'specialUidCode': 'null',
          'password': password,
        },
      );
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
