part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthDisplay extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String title;
  final String description;

  AuthError({required this.title, required this.description});
}

class AuthVisibilityChange extends AuthState {}
