part of 'notes_add_cubit.dart';

abstract class NotesAddState {}

class NotesAddInitial extends NotesAddState {}

class NotesAddDisplay extends NotesAddState {
  bool isSuccess;
   String? message;


  NotesAddDisplay( {this.isSuccess = false,  required  this.message});
}

class NotesAddLoading extends NotesAddState {}

class NotesAddError extends NotesAddState {
  final String title;
  final String description;

  NotesAddError({required this.title, required this.description});
}

class NotesAddInternetState extends NotesAddState {
  final bool hasInternet;
  NotesAddInternetState({required this.hasInternet});
}

