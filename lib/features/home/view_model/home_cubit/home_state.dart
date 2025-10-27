part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeDisplay extends HomeState {
  final List<NotesListModel?> notesListModel;
  final bool isSearchNotFound;
  final bool hasInternet;

  HomeDisplay({required this.notesListModel, this.isSearchNotFound =false, this.hasInternet =false});
}

class HomeDeleteSuccess extends HomeState {
  final List<NotesListModel?> notesListModel;
  final String message;
  HomeDeleteSuccess({required this.notesListModel, required this.message});
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String title;
  final String description;
  final bool hasInternet;

  HomeError({required this.title, required this.description, this.hasInternet =false});
}


