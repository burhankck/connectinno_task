part of 'profil_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileDisplay extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String displayName;

  ProfileLoaded({required this.displayName});

}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String title;
  final String description;

  ProfileError({required this.title, required this.description});
}
