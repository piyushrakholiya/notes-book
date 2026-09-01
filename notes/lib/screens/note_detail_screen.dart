import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/notes_cubite.dart';
import 'package:notes/cubit/notes_state.dart';

class NoteDetailScreen extends StatelessWidget {
  final String noteId;

  const NoteDetailScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubite, NotesState>(
      builder: (context, state) {
        String title = "Note Details";
        String description = "";

        if (state is LoadedState) {
          // 👉 id ના આધારે નોટ શોધી કાઢવી
          final note = state.notes.firstWhere(
            (n) => n.id.toString() == noteId,
            orElse: () => state.notes.first, // Fallback
          );
          title = note.title;
          description = note.description;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              "Note Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👉 Hero tag માં પણ id નો ઉપયોગ કરવો જેથી એનિમેશન પરફેક્ટ થાય
                Hero(
                  tag: 'noteTitle_$noteId',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 1.5, color: Colors.deepPurple),
                const SizedBox(height: 16),
                Hero(
                  tag: 'noteContent_$noteId',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
