import 'package:notes/database/database_helper.dart';
import 'package:notes/model/note_model.dart';

class NoteRepository {
  final DatabaseHelper databaseHelper;
  NoteRepository(this.databaseHelper);

  Future<int> addNote(NoteModel note) {
    return databaseHelper.insertNote(note);
  }

  Future<List<NoteModel>> getNote() {
    return databaseHelper.fecthNote();
  }

  Future<int> deleteNote(int id) {
    return databaseHelper.deleteNote(id);
  }

  Future<int> updateNote(NoteModel note) {
    return databaseHelper.updateNote(note);
  }
}
