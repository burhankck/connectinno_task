import 'package:connectinno_task/core/services/network_handler/auth_error_handler.dart';
import 'package:connectinno_task/enum/auth_error_type.dart';
import 'package:connectinno_task/features/register/model/register_model.dart';
import 'package:connectinno_task/features/register/service/register_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> with _CubitProperties {
  RegisterCubit() : super(RegisterInitial());

  void _clearControllers() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
  }

  Future<void> getSignUp() async {
    emit(RegisterLoading());

    final requestModel = RegisterRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: usernameController.text.trim(),
    );
 await FirebaseAuth.instance.currentUser
        ?.updateDisplayName(usernameController.text.trim());
    try {
      await _registerService.signUp(
        email: requestModel.email,
        password: requestModel.password,
        username: requestModel.name,
      );
      _clearControllers();
      emit(RegisterDisplay());
    } on FirebaseAuthException catch (e) {
      final message = AuthHelper.fromException(e, AuthErrorType.register);
      emit(RegisterError(title: "Kayıt Hatası", description: message));
    } catch (e) {
      emit(
        RegisterError(
          title: "Hata",
          description: "Kayıt olunurken beklenmeyen bir sorun oluştu.",
        ),
      );
    }
  }
}

mixin _CubitProperties {
  final RegisterService _registerService = RegisterService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
}
