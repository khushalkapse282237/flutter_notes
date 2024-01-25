import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/widget/themes.dart';

class NotesEditorScreen extends StatefulWidget {
  const NotesEditorScreen({super.key});

  @override
  State<NotesEditorScreen> createState() => _NotesEditorScreenState();
}

class _NotesEditorScreenState extends State<NotesEditorScreen> {
  int color_id = Random().nextInt(Themes.cardColor.length);
  TextEditingController notesTitle = TextEditingController();
  TextEditingController notesContent = TextEditingController();
  String date = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: Themes.cardColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "Add a new note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: notesTitle,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: Themes.mainTitle,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: Themes.dateTitle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: notesContent,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Content",
              ),
              style: Themes.mainTitle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("notes").add({
            "notes_title": notesTitle.text,
            "creation_date": date,
            "notes_content": notesContent.text,
            "color_id": color_id,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((error) => print("failed to insert data"));
        },
        backgroundColor: Themes.accentColor,
        child: const Icon(Icons.save),
      ),
    );
  }
}
