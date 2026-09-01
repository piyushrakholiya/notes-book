import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/notes_cubite.dart';
import 'package:notes/database/database_helper.dart';
import 'package:notes/repository/note_repository.dart';
import 'package:notes/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper.instance;

  runApp(
    BlocProvider(
      create: (context) => NotesCubite(NoteRepository(databaseHelper)),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Note App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.black,
        ),
      ),

      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
