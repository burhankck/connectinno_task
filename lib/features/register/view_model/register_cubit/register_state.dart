part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterDisplay extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String title;
  final String description;

  RegisterError({required this.title, required this.description});
}
