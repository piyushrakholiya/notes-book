import 'package:notes/model/note_model.dart';

abstract class NotesState {}

class NoteInitial extends NotesState {}

class LoadingState extends NotesState {}

class LoadedState extends NotesState {
  final List<NoteModel> notes;
  LoadedState({required this.notes});
}

class ErrorState extends NotesState {
  final String error;
  ErrorState({required this.error});
}
