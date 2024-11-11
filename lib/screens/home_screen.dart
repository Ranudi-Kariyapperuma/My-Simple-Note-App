import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    final notes = await DatabaseHelper.instance.getNotes();
    setState(() {
      this.notes = notes;
    });
  }

  void _navigateToAddNoteScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteScreen()),
    ).then((_) => _loadNotes());
  }

  void _navigateToNoteDetailScreen(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    ).then((_) => _loadNotes());
  }

  void _deleteNote(Note note) async {
    final confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Note'),
          content: Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                
                if (note.id != null) {
                  DatabaseHelper.instance
                      .deleteNote(note.id!); 
                }
                Navigator.of(context)
                    .pop(true); 
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      setState(() {
        notes.remove(note); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'My Simple Note 📝',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 55, 21, 115),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 249, 216, 249),
      body: notes.isEmpty
          ? Center(child: Text('No notes available'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              _navigateToNoteDetailScreen(notes[index]),
                          child: NoteCard(
                            note: notes[index],
                            onDelete:
                                _deleteNote, 
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNoteScreen,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 55, 21, 115),
      ),
    );
  }
}