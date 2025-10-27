import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';



class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> logIn({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("Giriş Başarılı: ${userCredential.user?.email}");
      return userCredential;
    } on FirebaseAuthException {
      
      rethrow; 
    } catch (e) {
      debugPrint("AuthService Giriş Hatası: $e");
      rethrow;
    }
  }

  
  Future<void> logOut() async {
    await _auth.signOut();
  }
}
