import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/notes_state.dart';
import 'package:notes/model/note_model.dart';
import 'package:notes/repository/note_repository.dart';

class NotesCubite extends Cubit<NotesState> {
  final NoteRepository repository;

  NotesCubite(this.repository) : super(NoteInitial()) {
    getNote();
  }

  Future<void> getNote() async {
    emit(LoadingState());

    try {
      final notes = await repository.getNote();
      emit(LoadedState(notes: notes));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> addNote(NoteModel note) async {
    emit(LoadingState());

    try {
      await repository.addNote(note);
      await getNote();
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    emit(LoadingState());

    try {
      await repository.updateNote(note);
      await getNote();
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> deleteNote(int id) async {
    emit(LoadingState());

    try {
      await repository.deleteNote(id);
      await getNote();
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
