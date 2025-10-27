import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RegisterService {
 
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<UserCredential> signUp({
    required String email, 
    required String password, 
    String? username 
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      
      if (username != null && userCredential.user != null) {
        await userCredential.user!.updateDisplayName(username);
      }
      
      debugPrint("Kayıt Başarılı: ${userCredential.user?.email}");
      return userCredential;
      
    } on FirebaseAuthException {
      
      rethrow; 
    } catch (e) {
      debugPrint("RegisterService Kayıt Hatası: $e");
      rethrow;
    }
  }
}
