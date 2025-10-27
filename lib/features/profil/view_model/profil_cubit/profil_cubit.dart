import 'package:connectinno_task/core/services/network_handler/auth_error_handler.dart';
import 'package:connectinno_task/enum/auth_error_type.dart';
import 'package:connectinno_task/features/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profil_state.dart';

class ProfileCubit extends Cubit<ProfileState> with _CubitProperties {
  ProfileCubit() : super(ProfileInitial());

  void refreshProfile() async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(
      ProfileLoaded(
        displayName:
            FirebaseAuth.instance.currentUser?.displayName ?? "Kullanıcı",
      ),
    );
  }

  Future<void> logOut() async {
    emit(ProfileLoading());

    try {
      await _authService.logOut();
      emit(ProfileLoaded(displayName: ""));
      emit(ProfileDisplay());
    } on FirebaseAuthException catch (e) {
      final message = AuthHelper.fromException(e, AuthErrorType.logout);

      emit(ProfileError(title: "Hata", description: message));
    } catch (e) {
      emit(
        ProfileError(
          title: "Çıkış Başarısız",
          description: "Çıkış yapılırken bir hata oluştu.",
        ),
      );
    }
  }
}

mixin _CubitProperties {
  final AuthService _authService = AuthService();
}
