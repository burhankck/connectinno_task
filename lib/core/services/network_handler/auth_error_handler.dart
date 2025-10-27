
import 'package:connectinno_task/enum/auth_error_type.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthHelper {
  static String handleAuthError(String errorCode, AuthErrorType type) {
    switch (type) {
      case AuthErrorType.login:
        return _handleLoginError(errorCode);
      case AuthErrorType.register:
        return _handleRegisterError(errorCode);
      case AuthErrorType.logout:
        return _handleLogoutError(errorCode);
    }
  }

 
  static String _handleLoginError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Geçersiz e-posta adresi formatı.';
      case 'user-disabled':
        return 'Bu kullanıcı hesabı devre dışı bırakılmıştır.';
      case 'user-not-found':
        return 'Bu e-posta adresine kayıtlı kullanıcı bulunamadı.';
      case 'wrong-password':
        return 'Hatalı şifre. Lütfen tekrar deneyin.';
      default:
        return 'Giriş yapılırken bir hata oluştu: ($code)';
    }
  }

  
  static String _handleRegisterError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Bu e-posta adresi zaten kullanımda.';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi.';
      case 'weak-password':
        return 'Şifre çok zayıf. En az 6 karakter olmalıdır.';
      default:
        return 'Kayıt sırasında hata oluştu: ($code)';
    }
  }

 
  static String _handleLogoutError(String code) {
    switch (code) {
      case 'network-request-failed':
        return 'İnternet bağlantısı yok. Lütfen tekrar deneyin.';
      default:
        return 'Çıkış yapılırken hata oluştu: ($code)';
    }
  }

  
  static String fromException(FirebaseAuthException e, AuthErrorType type) {
    return handleAuthError(e.code, type);
  }
}

