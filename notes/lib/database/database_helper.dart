import 'package:notes/model/note_model.dart';
import 'package:notes/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  DatabaseHelper._();

  static final String notesTable = "notes";
  static final String usersTable = "users";

  Database? _database;

  Future<Database> get database async {
    // if (_database != null) {
    //   return _database!;
    // }
    // _database = await _initDatabase();
    // return _database!;
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final dbpath = await getDatabasesPath();

    return openDatabase(
      join(dbpath, "database.db"),
      version: 1,

      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE $usersTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      email TEXT UNIQUE,
      password TEXT
    )
  ''');

        await db.execute('''
          CREATE TABLE $notesTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
           
            title TEXT,
            description TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;

    return await db.insert(usersTable, user.toMap());
  }

  Future<UserModel?> loginUser(String email, String password) async {
    final db = await database;

    final data = await db.query(
      usersTable,
      where: "email = ? AND password = ? ",
      whereArgs: [email, password],
    );

    if (data.isEmpty) {
      return null;
    }
    return UserModel.fromMap(data.first);
  }

  Future<List<NoteModel>> fecthNote() async {
    final db = await database;

    final data = await db.query(notesTable);

    return data.map((e) => NoteModel.fromMap(e)).toList();
  }

  Future<int> insertNote(NoteModel note) async {
    final db = await database;

    return db.insert(notesTable, note.toMap());
  }

  Future<int> updateNote(NoteModel note) async {
    final db = await database;
    return db.update(
      notesTable,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return db.delete(notesTable, where: "id = ?", whereArgs: [id]);
  }
}
