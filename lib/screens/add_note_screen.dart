import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _saveNote() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both title and content')),
      );
      return;
    }

    final newNote = Note(
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
    );

    await DatabaseHelper.instance.addNote(newNote);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note added successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Note',
        ),
        backgroundColor: const Color.fromARGB(255, 55, 21, 115),
        titleTextStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 23,
        ),
        iconTheme:
            IconThemeData(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Save Note', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                // Set the background color of the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
