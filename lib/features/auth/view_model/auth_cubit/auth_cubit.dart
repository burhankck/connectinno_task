import 'package:connectinno_task/core/services/network_handler/auth_error_handler.dart';
import 'package:connectinno_task/enum/auth_error_type.dart';
import 'package:connectinno_task/features/auth/model/auth_model.dart';
import 'package:connectinno_task/features/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with _PageProperties {
  AuthCubit() : super(AuthInitial());

  bool obscurePassword = true;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(AuthVisibilityChange());
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> getAuth() async {
    emit(AuthLoading());

    final requestModel = LoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      await _authService.logIn(
        email: requestModel.email,
        password: requestModel.password,
      );
      emit(AuthDisplay());
    } on FirebaseAuthException catch (e) {
      final message = AuthHelper.fromException(e, AuthErrorType.login);

      emit(AuthError(title: "Hata", description: message));
    } catch (e) {
      emit(
        AuthError(
          title: "Hata",
          description: "Giriş yapılırken beklenmeyen bir sorun oluştu.",
        ),
      );
    }
  }
}

mixin _PageProperties {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
