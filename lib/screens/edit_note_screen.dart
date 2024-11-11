import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  void _saveNote() async {
    final updatedNote = Note(
      id: widget.note.id,
      title: titleController.text,
      content: contentController.text,
      createdAt: widget.note.createdAt,
    );

    await DatabaseHelper.instance.updateNote(updatedNote);

    Navigator.pop(context, updatedNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Note',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 55, 21, 115),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 55, 21, 115),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 55, 21, 115)),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 55, 21, 115),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 55, 21, 115)),
                ),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 55, 21, 115),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
