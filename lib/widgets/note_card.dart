import 'package:flutter/material.dart';
import 'package:mysimplenote/screens/note_detail_screen.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard({required this.note, required void Function(Note note) onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteDetailScreen(note: note),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.primaries[note.id! % Colors.primaries.length].shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(
                note.content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.sticky_note_2,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
