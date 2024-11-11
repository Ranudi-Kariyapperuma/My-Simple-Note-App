import 'package:flutter/material.dart';
import 'package:mysimplenote/screens/edit_note_screen.dart';
import '../models/note.dart';
import '../database/database_helper.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note displayedNote;

  @override
  void initState() {
    super.initState();
    displayedNote = widget.note;
  }

  Future<void> _deleteNote() async {
    await DatabaseHelper.instance.deleteNote(displayedNote.id!);
    Navigator.pop(context, true);
  }

  void _navigateToEditScreen(BuildContext context) async {
    final updatedNote = await Navigator.push<Note>(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: displayedNote),
      ),
    );

    if (updatedNote != null) {
      setState(() {
        displayedNote = updatedNote;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Simple Note',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 55, 21, 115),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayedNote.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              displayedNote.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToEditScreen(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 55, 21, 115),
                  ),
                  child: Text('Edit Note'),
                ),
                ElevatedButton(
                  onPressed: _deleteNote,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 55, 21, 115),
                  ),
                  child: Text('Delete Note'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
